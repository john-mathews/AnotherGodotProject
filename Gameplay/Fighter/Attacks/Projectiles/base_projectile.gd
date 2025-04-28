extends CharacterBody2D

@export var speed: float = 500.0
@export var pattern: String = "straight" # Options: "straight", "sine", "arc"
@export var gravity: float = 0.0 # Gravity strength
@export var explosion_timer: float = -1.0 # Time for explosion (-1 means no timer)
@export var is_explosive: bool = false
@export var explode_on_contact: bool = false
@export var arc_angle: float = 45.0 # Used for arc pattern
@export var attack: Attack
@export var max_bounces: int = 3 # Limits the number of bounces
@export var bounciness: float = 0.6

# Internal variables
var time_elapsed: float = 0.0
var explosion_countdown: float = 0.0
var bounce_count: int = 0


func _physics_process(delta: float) -> void:
	time_elapsed += delta
	var x_speed = speed * sign(attack.attack_owner.direction)
	# Determine velocity based on pattern
	match pattern:
		"straight":
			velocity.x = x_speed
			
		"sine":
			velocity.x = x_speed
			velocity.y = sin(time_elapsed * 5.0) * speed / 3.0
			
		"arc":
			velocity.x = x_speed * cos(deg_to_rad(arc_angle))
			velocity.y += gravity * delta
			
		_:
			velocity.x = x_speed
	
	# Apply gravity to all patterns
	velocity.y += gravity * delta
	
	# Collision handling
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		handle_collision(collision_info)
	
	# Handle timed explosion
	if explosion_timer > 0.0:
		explosion_countdown += delta
		if explosion_countdown >= explosion_timer:
			Command.projectile_explode.emit(attack) # No specific collision object for timed explosion
			queue_free()

# Function to handle collisions
func handle_collision(collision_info: KinematicCollision2D) -> void:
	var collider = collision_info.get_collider()
	var normal = collision_info.get_normal()

	if collider is Fighter:
		attack.handle_collision(collider)
		
	if explode_on_contact:
		Command.projectile_explode.emit(attack) # Send the hit object
		
	# Apply bounce effect if within bounce limit
	if bounce_count < max_bounces:
		velocity = velocity.bounce(normal) * bounciness
		bounce_count += 1
	else:
		if is_explosive:
			Command.projectile_explode.emit(attack) # Send the hit object
		queue_free() # Remove grenade after max bounces

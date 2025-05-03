class_name BaseProjectile extends CharacterBody2D

@export var speed: float = 500.0
@export var pattern: String = "straight" # Options: "straight", "sine", "arc"
@export var gravity: float = 0.0 # Gravity strength
@export var explosion_timer: float = -1.0 # Time for explosion (-1 means no timer)
@export var is_explosive: bool = false
@export var explode_on_contact: bool = false
@export var arc_angle: float = 45.0 # Used for arc pattern
@export var attack: Attack
@export var max_bounces: int = 1 # Limits the number of bounces
@export var bounciness: float = 0.6

const attack_particles_uid = 'uid://c1rx4heifng37'
const min_particles:= 5
const max_particles:= 100

# Internal variables
var time_elapsed: float = 0.0
var explosion_countdown: float = 0.0
var bounce_count: int = 0
var initial_direction: int = 1
var particles: GPUParticles2D
var combat_collision_handler: CombatCollisionHandler

func _ready() -> void:
	combat_collision_handler = CombatCollisionHandler.new()
	add_child(combat_collision_handler)
	particles = preload(attack_particles_uid).instantiate()
	add_child(particles)
	
	initial_direction = -1 if attack.attack_owner.flip_horizontal else 1
	
	var collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = 10
	collision_shape.debug_color = Color.AQUAMARINE
	collision_shape.shape = circle_shape
	set_collision_layer_value(4, true)
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, true)
	set_collision_mask_value(2, true)
	set_collision_mask_value(3, true)
	set_collision_mask_value(4, true)
	add_child(collision_shape)

func _physics_process(delta: float) -> void:
	time_elapsed += delta
	var x_speed = speed * initial_direction
	# Determine velocity based on pattern
	match pattern:
		"straight":
			velocity.x = x_speed
			velocity.y = 0
			
		"sine":
			velocity.x = x_speed
			velocity.y = sin(time_elapsed * 5.0) * speed / 3.0
			
		"arc":
			velocity.x = x_speed * cos(deg_to_rad(arc_angle))
			velocity.y += gravity * delta
			
		_:
			velocity.x = x_speed
			velocity.y = 0
			
	
	# Apply gravity to all patterns
	velocity.y += gravity * delta
	
	# Collision handling
	var collision = move_and_slide()
	if collision:
		var collider = get_last_slide_collision().get_collider()
		if collider is Fighter && collider != attack.attack_owner:
			handle_collision(collider)
	
	# Handle timed explosion
	if explosion_timer > 0.0:
		explosion_countdown += delta
		if explosion_countdown >= explosion_timer:
			Command.projectile_explode.emit(attack) # No specific collision object for timed explosion
			queue_free()

# Function to handle collisions
func handle_collision(collider: Fighter) -> void:
	print('projectile handle collision')
	var collision_normal = (collider.global_position - global_position).normalized()

	if collider is Fighter && collider != attack.attack_owner:
		combat_collision_handler.handle_combat_collision(self, collider, attack)
		emit_particles(attack.knockback)
		
	if explode_on_contact:
		Command.projectile_explode.emit(attack) # Send the hit object
		
	# Apply bounce effect if within bounce limit
	if bounce_count < max_bounces:
		velocity = velocity.bounce(collision_normal) * bounciness
		bounce_count += 1
	else:
		if is_explosive:
			Command.projectile_explode.emit(attack) # Send the hit object
		queue_free() # Remove grenade after max bounces

func emit_particles(knockback: float) -> void:
	particles.amount = clamp(knockback/50, min_particles, max_particles)
	if !particles.is_emitting():
		particles.set_emitting(true)

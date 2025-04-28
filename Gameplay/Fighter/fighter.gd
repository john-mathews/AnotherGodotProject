class_name Fighter extends CharacterBody2D

@export var fighter_name: String = 'Fighter!'

@export_group("movement")
@export var max_speed: float = 300
@export var acceleration: float = 30
@export var friction: float = 5
@export var air_strafe_speed: float = 300
@export var air_strafe_acceleration: float = 15
@export var air_resistence: float = 2
@export var gravity_modifier: float = 1
@export var jump_velocity: float = -500
@export var jump_release_dampening: float = 2
@export var max_jumps: int = 2

@export_group("combat")
#number goes up like ssb
@export var health: float = 0 
#items or perks could help recover health over time
@export var health_recharge_rate: float = 0 
@export var shield: float = 100
@export var shield_recharge_rate: float = .1
@export var bounce: float = .5
@export var absorption: float = .5
@export var push_force: float = 100

#updated in physics process or by behavior
var last_velocity: Vector2
var direction: float = 0
var v_direction: float = 0
var input_dir: Vector2
var flip_horizontal: bool
var jumps_available: int = 2

const health_label_path = 'uid://jfvxm63tgfgs'
var health_label: HealthLabel 

var frozen:= false

func _ready() -> void:
	on_spawn()
	
func on_spawn() -> void:
	SharedData.add_fighter(self)
	health_label = preload(health_label_path).instantiate()
	Command.create_fighter_label.emit(health_label, fighter_name)
	
#fall off stage -> remove stock etc
func on_death() -> void:
	pass

func on_damaged() -> void:
	if health_label != null:
		health_label.set_health(health)

#character out of stock -> removed from game -> game over?
func on_elimination() -> void:
	SharedData.remove_fighter(self)
	queue_free()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * gravity_modifier * delta
		if !direction:
			velocity.x = move_toward(velocity.x, 0, air_resistence)
	else:
		if !direction:
			velocity.x = move_toward(velocity.x, 0, friction)
		if jumps_available < max_jumps && velocity.y >= 0:
			jumps_available = max_jumps
	
	if frozen:
		velocity = Vector2.ZERO
		
	var collision = move_and_slide()
	if collision:
		var collider = get_last_slide_collision().get_collider()
		if collider is Fighter:
			handle_collision(collider)
	last_velocity = velocity
				

func handle_collision(other_ball: Fighter):
	var collision_normal = (other_ball.position - position).normalized()
	var relative_velocity = last_velocity - other_ball.last_velocity
	var velocity_along_normal = relative_velocity.dot(collision_normal)

	# Calculate impulse for elastic collision
	var restitution = bounce  # 1 = Perfectly elastic
	var impulse = -((1 + restitution) * velocity_along_normal) / 2
	
	velocity += impulse * collision_normal * absorption
	other_ball.velocity -= impulse * collision_normal * other_ball.absorption

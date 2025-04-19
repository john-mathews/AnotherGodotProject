class_name Fighter extends CharacterBody2D

var state_machine: CharacterStateMachine
const STATES = CharacterStateMachine.CharacterStates

# doing action is more generic version of attacking, KO'd, guarding, rolling, etc 
# since we can only do one at once
var doing_action: bool = false
var max_speed: float = 300
#below this we walk
var run_speed: float = 150
var acceleration: float = 30
var friction: float = 5
var air_strafe_speed: float = 300
var air_strafe_acceleration: float = 15
var air_resistence: float = 2
var gravity_modifier: float = 1
var jump_velocity: float = -500
var jumps_available: int = 2
var max_jumps: int = 2
#number goes up like ssb
var health: float = 0 
#items or perks could help recover health over time
var health_recharge_rate: float = 0 
var shield: float = 100
var shield_recharge_rate: float = .1
var direction: float = 0
var flip_horizontal: bool
var last_velocity: Vector2
#var attack_list: Array[Attack]
#var current_attack: Attack
var bounce: float = 1
var absorption: float = .8
var min_push: float = 5

func _ready() -> void:
	state_machine = CharacterStateMachine.new()

func _physics_process(delta: float) -> void:
	if not doing_action:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * gravity_modifier * delta
		else:
			if jumps_available < max_jumps && state_machine.current_state != STATES.JUMPING:
				jumps_available = max_jumps
				
	if state_machine && state_machine.current_state_node:
		state_machine.current_state_node.run(self)
		
	var collision = move_and_slide()
	if collision:
		var collider = get_last_slide_collision().get_collider()
		if collider is Fighter:
			handle_collision(collider)
	last_velocity = velocity
				
func change_state(new_state: CharacterStateMachine.CharacterStates) -> void:
	state_machine.change_state(new_state, self)

func handle_collision(other_ball: Fighter):
	var collision_normal = (other_ball.position - position).normalized()
	var relative_velocity = last_velocity - other_ball.last_velocity
	var velocity_along_normal = relative_velocity.dot(collision_normal)

	# Calculate impulse for elastic collision
	var restitution = bounce  # 1 = Perfectly elastic
	var impulse = -((1 + restitution) * velocity_along_normal) / 2
	
	velocity += impulse * collision_normal * absorption
	other_ball.velocity -= impulse * collision_normal * other_ball.absorption
	if (velocity == Vector2.ZERO && direction && 
		other_ball.velocity == Vector2.ZERO && !other_ball.direction):
		print('here')
		velocity = collision_normal * min_push
		other_ball.velocity = collision_normal * min_push

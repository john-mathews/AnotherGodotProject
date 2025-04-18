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
var direction: float
var flip_horizontal: bool
#var attack_list: Array[Attack]
#var current_attack: Attack

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
				
func change_state(new_state: CharacterStateMachine.CharacterStates) -> void:
	state_machine.change_state(new_state, self)

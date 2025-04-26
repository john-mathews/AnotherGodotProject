class_name PlayerFighter extends FighterWithBehaviors

const roll_threshold:= 0.8
const v_attack_threshold:= 0.3

@onready var dynamic_particles:= $DynamicParticles
@onready var attacks:= $Attacks

func _ready() -> void:
	assign_attack_owner()

func _physics_process(delta: float) -> void:
	direction = Input.get_axis("left","right")
	if direction < 0:
		flip_horizontal = true
		attacks.scale.x = -1
	elif direction > 0:
		flip_horizontal = false
		attacks.scale.x = 1
	v_direction = Input.get_axis("up", "down")
	input_dir = Vector2(direction, v_direction)
	can_jump = Input.is_action_just_pressed("jump") && jumps_available > 0
	can_fall = Input.is_action_just_released("jump") && velocity.y < 0 
	can_move = !!direction
	
	can_shield = Input.is_action_pressed("shield") && shield > 0
	can_roll = can_shield && abs(direction > roll_threshold)
	can_attack = Input.is_action_just_pressed("attack")
	can_special = Input.is_action_just_pressed("special")
	#add check later to see if attack should be up or down based on attack threshold and v_direction
	
	#run behavior tree
	super(delta)
	
	dynamic_particles.update_particles(delta, velocity)
	

func assign_attack_owner() -> void:
	for child in attacks.get_children():
		if child is Attack:
			child.attack_owner = self

func select_attack(fighter: FighterWithBehaviors) -> Attack:
	if fighter.v_direction < -v_attack_threshold:
		return fighter.up_attack
	elif fighter.v_direction > v_attack_threshold:
		return fighter.down_attack
	else:
		return fighter.neutral_attack
	
func select_special(fighter: FighterWithBehaviors) -> Attack:
	if fighter.v_direction < -v_attack_threshold:
		return fighter.up_special
	elif fighter.v_direction > v_attack_threshold:
		return fighter.down_special
	else:
		return fighter.neutral_special

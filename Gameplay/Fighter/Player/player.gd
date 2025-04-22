extends FighterWithBehaviors

var roll_threshold:= 0.8
var attack_threshold:= 0.6

@onready var dynamic_particles:= $DynamicParticles
@onready var base_attack:= $BasicAttack

func _ready() -> void:
	neutral_attack = base_attack
	assign_attack_owner()

func _physics_process(delta: float) -> void:
	super(delta)
	direction = Input.get_axis("left","right")
	if direction < 0:
		flip_horizontal = true
		base_attack.scale.x = -1
	elif direction > 0:
		flip_horizontal = false
		base_attack.scale.x = 1
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
	dynamic_particles.update_particles(delta, velocity)

func assign_attack_owner() -> void:
	for child in get_children():
		if child is Attack:
			child.attack_owner = self

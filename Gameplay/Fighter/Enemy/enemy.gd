class_name EnemyFighter extends FighterWithBehaviors

const roll_threshold := 0.8
const v_attack_threshold := 0.3

@export var buffer_distance: float = 150.0

@export var players: Array[Fighter]
var current_target: Fighter
var current_target_dir: Vector2
var current_target_distance: float
var current_target_pos: Vector2

@onready var dynamic_particles := $DynamicParticles
@onready var attacks := $Attacks
@onready var animation_player := $AnimationPlayer
@onready var attack_hitbox_node := $Attacks/AttackHitBox
@onready var projectile_list := $Projectiles

func _ready() -> void:
	animation = animation_player
	attack_hitbox = attack_hitbox_node
	super ()
	assign_attack_owner()


func _physics_process(delta: float) -> void:
	current_target = Brain.set_target(self)
	current_target_dir = Brain.get_direction(current_target.global_position, global_position)
	current_target_pos = Brain.set_target_pos(self)

	input_dir = Brain.get_direction(current_target_pos, global_position)
	direction = current_target_dir.x if current_target_pos == global_position else input_dir.x
	if direction < 0:
		flip_horizontal = true
		attacks.scale.x = -1
	elif direction > 0:
		flip_horizontal = false
		attacks.scale.x = 1

	if current_target_pos == global_position:
		direction = 0
		can_special = false
		can_attack = true
	elif current_target_distance > buffer_distance:
		can_attack = false
		can_special = true
	else:
		can_attack = false
		can_special = false
	v_direction = input_dir.y

	can_jump = !is_on_floor() && jumps_available > 0
	can_fall = randf() > .98 && velocity.y < 0
	can_move = !!direction
	
	# can_shield = Input.is_action_pressed("shield") && shield > 0
	can_roll = can_shield && abs(direction > roll_threshold)
	# can_attack = Input.is_action_just_pressed("attack")
	# can_special = Input.is_action_just_pressed("special")
	#add check later to see if attack should be up or down based on attack threshold and v_direction
	
	#run behavior tree
	super (delta)
	
	dynamic_particles.update_particles(delta, velocity)
	

func assign_attack_owner() -> void:
	for child in attacks.get_children():
		if child is Attack:
			child.attack_owner = self

#func select_attack(fighter: FighterWithBehaviors) -> Attack:
#	if fighter.v_direction < -v_attack_threshold:
#		return fighter.up_attack
#	elif fighter.v_direction > v_attack_threshold:
#		return fighter.down_attack
#	else:
#		return fighter.neutral_attack
	
#func select_special(fighter: FighterWithBehaviors) -> Attack:
#	if fighter.v_direction < -v_attack_threshold:
#		return fighter.up_special
#	elif fighter.v_direction > v_attack_threshold:
#		return fighter.down_special
#	else:
#		return fighter.neutral_special

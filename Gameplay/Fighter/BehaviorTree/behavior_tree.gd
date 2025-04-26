class_name FighterWithBehaviors extends Fighter

@export_group("attacks")
@export var up_attack: Attack
@export var neutral_attack: Attack
@export var down_attack: Attack
@export var up_special: Attack
@export var neutral_special: Attack
@export var down_special: Attack

var can_attack:= false
var can_up_attack:= false
var can_down_attack:= false
var can_roll:= false
var can_shield:= false
var can_special:= false
var can_up_special:= false
var can_down_special:= false

var can_move:= false
var can_jump:= false
var can_fall:= false
var is_KOd:= false
var is_attacking:= false

func _physics_process(delta: float) -> void:
	super(delta)
	if is_KOd:
		velocity = Vector2.ZERO
	else:
		#combat behaviors
		if can_roll:
			pass
		elif can_shield:
			pass
		elif can_special:
			var selected_special = select_special(self)
			selected_special.play(selected_special.attack_name)
		elif can_attack:
			var selected_attack = select_attack(self)
			selected_attack.play(selected_attack.attack_name)
		
		#movement behaviors	
		if can_fall:
			velocity.y /= jump_release_dampening
		elif can_jump:
			velocity.y = jump_velocity
			jumps_available -= 1
		elif can_move:
			velocity.x = move_toward(velocity.x, max_speed * direction, acceleration)


func select_attack(fighter: FighterWithBehaviors) -> Attack:
	return fighter.neutral_attack

func select_special(fighter: FighterWithBehaviors) -> Attack:
	return fighter.neutral_special
	

class_name BaseAttack extends Attack

const hit_box_uid:= "uid://bvkwkh1yplrb5"
const attacks_uid:= "uid://bcimm45u6x63r"


func _ready() -> void:
	## TODO
	#optimize attacks by moving attack hit box and animation player 
	#to the fighter level that can be shared by all attacks
	#we can assign the player ones to the attack hurtbox and animation values
	
	
	var hitbox = preload(hit_box_uid).instantiate()
	hurtbox = hitbox
	add_child(hitbox)
	var new_animation = AnimationPlayer.new()
	var attacks = preload(attacks_uid)
	new_animation.add_animation_library(attack_library_name, attacks)
	animation = new_animation
	add_child(animation)
	super()

func owner_velocity_override(vel: Vector2) -> void:
	attack_owner.velocity = vel

func freeze_owner() -> void:
	attack_owner.frozen = true
	
func unfreeze_owner() -> void:
	attack_owner.frozen = false

func set_init() -> void:
	pass

func reset_init() -> void:
	pass

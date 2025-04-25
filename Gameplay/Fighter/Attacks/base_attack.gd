class_name BaseAttack extends Attack

const hit_box_uid:= "uid://bvkwkh1yplrb5"
const attacks_uid:= "uid://bcimm45u6x63r"
#rename library and use for all attacks
#make new animation and load this library
#don't use global library anywhere
func _ready() -> void:
	var hitbox = load(hit_box_uid).instantiate()
	add_child(hitbox)
	var animation = AnimationPlayer.new()
	var attacks = load(attacks_uid)
	animation.add_animation_library("attacks", attacks)
	add_child(animation)

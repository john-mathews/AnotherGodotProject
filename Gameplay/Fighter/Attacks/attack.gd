class_name Attack extends Node2D

@export var attack_name: String
@export var damage: float
@export var knockback: float #use collision normal for direction
@export var attack_hit_direction: Vector2
@export var is_projectile:= false

var attack_owner: Fighter
const attack_library_name:= "attacks"
	
func play(animation_name: String) -> void:
	if attack_owner.animation != null:
		attack_owner.animation.play(attack_library_name + "/" + animation_name)

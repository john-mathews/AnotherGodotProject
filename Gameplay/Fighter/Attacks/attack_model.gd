class_name Attack extends Node2D

@export var attack_name: String
@export var damage: float
@export var knockback: float #use collision normal for direction

@onready var hurtbox: Area2D = $Area2D
@onready var animation: AnimationPlayer = $AnimationPlayer

var attack_owner: Fighter

func _ready() -> void:
	hurtbox.collision_layer = 0b0100
	hurtbox.collision_mask = 0b0110
	hurtbox.connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D):
	if  body != attack_owner && body is Fighter:
		print(body)
		handle_collision(body)
		
func handle_collision(getting_hit: Fighter):
	var collision_normal = (getting_hit.position - attack_owner.position).normalized()
	collision_normal.y -= 1 
	var attack_force = collision_normal * knockback * max(getting_hit.health, 1)
	getting_hit.health += damage
	var relative_velocity = attack_force - getting_hit.velocity
	print(attack_force)
	print(relative_velocity)
	getting_hit.velocity = relative_velocity * getting_hit.absorption

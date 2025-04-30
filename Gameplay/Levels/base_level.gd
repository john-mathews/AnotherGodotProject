class_name BaseLevel extends Node2D

func _ready() -> void:
	var center = get_viewport_rect().size / 2
	position = center

func _on_battle_field_body_exited(body: Node2D) -> void:
	if body is Fighter:
		respawn_fighter(body)
		#later we can handle more death logic, 
		#but just nice to be able to reset for now
func respawn_fighter(fighter: Fighter) -> void:
		fighter.velocity = Vector2.ZERO
		fighter.global_position = global_position
		fighter.health = 0
		fighter.gravity_modifier = 0
		fighter.on_respawn()

		await get_tree().create_timer(.2).timeout
		fighter.gravity_modifier = 1

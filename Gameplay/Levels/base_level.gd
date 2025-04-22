class_name BaseLevel extends Node2D

func _ready() -> void:
	var center = get_viewport_rect().size / 2
	position = center

func _on_battle_field_body_exited(body: Node2D) -> void:
	if body is Fighter:
		spawn_fighter(body)
		#later we can handle more death logic, 
		#but just nice to be able to reset for now
func spawn_fighter(fighter: Fighter) -> void:
		fighter.velocity = Vector2.ZERO
		fighter.global_position = global_position
		fighter.health = 0
		fighter.gravity_modifier = 0
		var tween = create_tween().set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(fighter, "modulate", Color.WHITE, 1)
		await get_tree().create_timer(.3).timeout
		fighter.gravity_modifier = 1
		SharedData.set_current_fighters()

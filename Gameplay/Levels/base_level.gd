class_name BaseLevel extends Node2D

func _ready() -> void:
	var center = get_viewport_rect().size / 2
	position = center

func _on_battle_field_body_exited(body: Node2D) -> void:
	if body is Fighter:
		body.velocity = Vector2.ZERO
		body.global_position = global_position
		#later we can handle more death logic, 
		#but just nice to be able to reset for now

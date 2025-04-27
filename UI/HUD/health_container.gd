extends HBoxContainer

func _ready() -> void:
	Command.connect("create_fighter_label", update_hud)
	
func update_hud(node: HealthLabel, new_name: String) -> void:
	add_child(node)
	node.set_fighter_name(new_name)
	node.set_health(0)
	
	

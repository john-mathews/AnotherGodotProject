extends Node

var current_scene: Node = null
var loading_screen: Node = null

func _ready():
	loading_screen = preload("uid://c17uitab8iua5").instantiate()
	
func init_current_scene(init_scene: Node2D) -> void:
	current_scene = init_scene

func change_scene(new_scene_path: String):
	# Show loading screen
	if loading_screen and !loading_screen.is_inside_tree():
		add_child(loading_screen)
		loading_screen.visible = true

	await get_tree().create_timer(1).timeout

	# Transition out current scene
	if current_scene:
		current_scene.queue_free()

	# Load new scene
	var new_scene = load(new_scene_path).instantiate()
	get_tree().root.add_child(new_scene)
	current_scene = new_scene

	# Transition into the new scene

	# Hide loading screen
	loading_screen.visible = false

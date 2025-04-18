extends Node2D

const test_level_uid := "uid://ddofhuqt8mw1i"


func _ready() -> void:
	SceneSwitcher.init_current_scene(self)

func _on_test_level_pressed() -> void:
	SceneSwitcher.change_scene(test_level_uid)

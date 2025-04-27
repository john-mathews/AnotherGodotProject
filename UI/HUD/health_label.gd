class_name HealthLabel extends Control

@onready var health:= $PanelContainer/VBoxContainer/Health
@onready var fighter_name:= $PanelContainer/VBoxContainer/Name


func set_health(value: float) -> void:
	health.text = str(value)+'%'

func set_fighter_name(new_name: String) -> void:
	fighter_name.text = new_name

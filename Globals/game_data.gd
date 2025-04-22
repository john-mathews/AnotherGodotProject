extends Node

var current_fighers: Array[Fighter] = []

const heartbeat_time:= 1.0
var heartbeat_count:= 0.0
var game_area = Area2D

func _ready() -> void:
	var area = Area2D.new()
	area.collision_layer = 0b0001
	area.collision_mask = 0b0010
	var shape = CollisionShape2D.new()
	shape.shape = CircleShape2D.new()
	shape.shape.radius = 10000
	area.add_child(shape)
	add_child(area)
	game_area = area
	set_current_fighters()

#func _process(delta: float) -> void:
	#heartbeat_count += delta
	#if heartbeat_count >= heartbeat_time:
		#heartbeat_count = 0
		#set_current_fighters()
		

func set_current_fighters() -> void:
	current_fighers = []
	for child in game_area.get_overlapping_bodies():
		if child is Fighter:
			current_fighers.push_back(child)

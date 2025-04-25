extends Node

var current_fighers: Array[Fighter] = []

func add_fighter(fighter: Fighter):
	current_fighers.push_back(fighter)
	
func remove_fighter(fighter: Fighter):
	current_fighers.erase(fighter)

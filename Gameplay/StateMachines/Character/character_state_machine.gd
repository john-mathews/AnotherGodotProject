class_name CharacterStateMachine extends Node

enum CharacterStates {
	IDLE, #not moving on ground
	WALKING, #moving slower than max speed
	RUNNING, #when moving at (near?) max speed
	JUMPING, #initial jump and while moving upward in air
	FALLING, #idle in air (downward)
	ATTACKING, #during any attack
	CHARGING, #charging up an attack
	GUARDING, #holding shield button
	ROLLING, #from guard position
	DODGING, #when guarding in air
	DUCKING, #duck to go through platform
	KNOCKED #stunned/ragdolled unable to input
}

var current_state:= CharacterStates.IDLE
var current_state_node: StateAction
var previous_state:= CharacterStates.IDLE
var previous_state_node: StateAction
	
func change_state(new_state: CharacterStates, character: Fighter) -> void:
	if current_state != new_state:
		if current_state && current_state_node:
			previous_state = current_state
			previous_state_node = current_state_node
			previous_state_node.end(character)
		
		current_state = new_state
		current_state_node = SharedData.character_state_node_map[current_state]
		print(current_state_node)
		if current_state_node:
			current_state_node.start(character)
		#get state node, call init()
		#init could set player values, like is_attacking or is_guarding or pass
		
func run_state(character: Fighter) -> void:
	#Make state node map
	#Make nodes for each state with actions
	#actions set animations, adjust velocity, do combat, etc.
	current_state_node.run(character)
	pass

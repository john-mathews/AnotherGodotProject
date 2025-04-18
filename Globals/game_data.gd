extends Node

const character_states_root_path:= "res://Gameplay/StateMachines/Character/States/"

var character_state_node_map: Dictionary[CharacterStateMachine.CharacterStates, StateAction]

func _ready() -> void:
	build_node_map()

func build_node_map() -> void:
	for state_name in CharacterStateMachine.CharacterStates:
		var state_node_path = character_states_root_path + state_name.to_pascal_case() + ".tscn"
		if ResourceLoader.exists(state_node_path, "PackedScene"):
			var state_node = load(state_node_path).instantiate() as StateAction
			character_state_node_map[CharacterStateMachine.CharacterStates[state_name]] = state_node
			add_child(state_node)
		

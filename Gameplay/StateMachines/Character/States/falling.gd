extends StateAction

func run(fighter: Fighter) -> void:
	if fighter.is_on_floor():
		fighter.change_state(CharacterStateMachine.CharacterStates.IDLE)

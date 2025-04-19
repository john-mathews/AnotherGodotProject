extends StateAction

func start(fighter: Fighter) -> void:
	if fighter.jumps_available > 0:
		fighter.velocity.y = fighter.jump_velocity
		fighter.jumps_available -= 1

	
func run(fighter: Fighter) -> void:
	if fighter.velocity.y > 0:
		fighter.change_state(CharacterStateMachine.CharacterStates.FALLING)
		

func end(fighter: Fighter) -> void:
	pass
	

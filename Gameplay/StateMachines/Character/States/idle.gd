extends StateAction

func run(fighter: Fighter) -> void:
	var friction: float
	if fighter.is_on_floor():
		friction = fighter.friction
	else:
		friction = fighter.air_resistence
	if !fighter.direction:
		fighter.velocity.x = move_toward(fighter.velocity.x, 0, friction)
	else:
		fighter.change_state(CharacterStateMachine.CharacterStates.RUNNING)

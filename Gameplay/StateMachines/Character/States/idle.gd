extends StateAction

func start(fighter: Fighter) -> void:
	fighter.doing_action = false

func run(fighter: Fighter) -> void:
	var friction: float
	if fighter.is_on_floor():
		friction = fighter.friction
		if !fighter.direction:
			fighter.velocity.x = move_toward(fighter.velocity.x, 0, friction)
		else:
			fighter.change_state(CharacterStateMachine.CharacterStates.RUNNING)
	else:
		fighter.change_state(fighter.STATES.FALLING)

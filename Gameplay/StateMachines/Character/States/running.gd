extends StateAction

func run(fighter: Fighter) -> void:
	var max_speed: float
	var acceleration: float
	if fighter.is_on_floor():
		max_speed = fighter.max_speed
		acceleration = fighter.acceleration
		if fighter.velocity.x >= fighter.run_speed || fighter.velocity.x <= -fighter.run_speed:
			#play run animation
			pass
		else:
			#play walk animation
			pass
	else:
		max_speed = fighter.air_strafe_speed
		acceleration = fighter.air_strafe_acceleration
		
	if fighter.direction:
		fighter.velocity.x = move_toward(fighter.velocity.x, max_speed * fighter.direction, acceleration)
	else:
		fighter.change_state(CharacterStateMachine.CharacterStates.IDLE)

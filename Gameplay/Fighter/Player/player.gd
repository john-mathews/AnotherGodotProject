extends Fighter

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		state_machine.change_state(STATES.JUMPING, self)
	elif event.is_action_released("jump"):
		if velocity.y < 0:
			velocity.y /= 3
		state_machine.change_state(STATES.FALLING, self)


func _physics_process(delta: float) -> void:
	super(delta)
	if !doing_action:
		direction = Input.get_axis("left", "right")
		if Input.is_action_pressed("left"):
			flip_horizontal = true
			change_state(STATES.RUNNING)
		elif Input.is_action_pressed("right"):
			flip_horizontal = false
			change_state(STATES.RUNNING)
		else:
			change_state(STATES.IDLE)

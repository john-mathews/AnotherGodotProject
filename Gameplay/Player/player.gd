extends Fighter

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		state_machine.change_state(STATES.JUMPING, self)
	elif event.is_action_released("jump"):
		state_machine.change_state(STATES.FALLING, self)
	elif event.is_action_pressed("left"):
		flip_horizontal = true
		state_machine.change_state(STATES.RUNNING, self)
	elif event.is_action_released("left") && !Input.is_action_pressed("right"):
		state_machine.change_state(STATES.IDLE, self)
	elif event.is_action_pressed("right"):
		flip_horizontal = false
		state_machine.change_state(STATES.RUNNING, self)
	elif event.is_action_released("right") && !Input.is_action_pressed("left"):
		state_machine.change_state(STATES.IDLE, self)

func _physics_process(delta: float) -> void:
	super(delta)

	direction = Input.get_axis("left", "right")

	if state_machine && state_machine.current_state_node:
		state_machine.current_state_node.run(self)
	move_and_slide()

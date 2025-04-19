extends Fighter

var dummy_friction: float = 30
var dummy_absorption: float = 1

func _ready() -> void:
	super()
	friction = dummy_friction
	absorption = dummy_absorption

func _physics_process(delta: float) -> void:
	super(delta)
	if state_machine:
		change_state(STATES.IDLE)

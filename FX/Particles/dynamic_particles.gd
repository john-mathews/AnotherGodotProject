class_name DynamicParticles extends CPUParticles2D

var time_counter: float = 0

func _ready() -> void:
	one_shot = true
	emitting = false

func update_particles(delta: float, velocity: Vector2):
	var speed = velocity.length()  
	direction = -velocity.normalized()
	direction.y -= 0.5
	initial_velocity_max = speed 
	emitting = speed > 10 

	if !emitting || time_counter >= lifetime:
		time_counter = 0
	elif emitting:
		time_counter += delta
	
	

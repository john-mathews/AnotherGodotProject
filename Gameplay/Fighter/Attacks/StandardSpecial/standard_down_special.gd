extends BaseAttack

const PULL_FORCE = 2000.0 # Adjust for the strength of the pull
var init_spawn: Vector2
var use_init: bool = false

func _process(delta):
	if use_init:
		global_position = init_spawn
	if hurtbox.monitoring:
		for body in hurtbox.get_overlapping_bodies():
			if body is Fighter && body != attack_owner:
				var direction = (global_position - body.global_position).normalized()
				var distance = global_position.distance_to(body.global_position)
				var force = direction * PULL_FORCE / max(distance/100, 1) # Pull decreases with distance
				
				body.health += damage / max(distance, 1)
				body.velocity += force * delta

func set_init() -> void:
	use_init = true
	init_spawn = global_position

func reset_init() -> void:
	use_init = false
	global_position = attack_owner.global_position

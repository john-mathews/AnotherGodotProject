class_name AttackHitBox extends Area2D

@onready var particles := $AttackParticles

const min_particles:= 5
const max_particles:= 100

func emit_particles(knockback: float) -> void:
	particles.amount = clamp(knockback/50, min_particles, max_particles)
	if !particles.is_emitting():
		particles.set_emitting(true)
		

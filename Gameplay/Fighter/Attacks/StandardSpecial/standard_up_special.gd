extends BaseAttack

func owner_velocity_override(_vel: Vector2) -> void:
	var input_dir = Vector2(attack_owner.direction, attack_owner.v_direction).normalized()
	attack_owner.velocity = input_dir * attack_owner.jump_velocity * -1.5
	var og_friction = attack_owner.friction
	var og_air_resistance = attack_owner.air_resistence
	attack_owner.friction = 0
	attack_owner.air_resistence = 0
	await get_tree().create_timer(.5).timeout
	attack_owner.friction = og_friction
	attack_owner.air_resistence = og_air_resistance

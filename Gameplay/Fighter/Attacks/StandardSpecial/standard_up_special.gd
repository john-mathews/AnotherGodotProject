extends BaseAttack

func owner_velocity_override(_vel: Vector2) -> void:
	var input_dir = Vector2(attack_owner.direction, attack_owner.v_direction).normalized()
	attack_owner.velocity = input_dir * attack_owner.jump_velocity * -1.5

class_name CombatCollisionHandler extends Node2D

func handle_combat_collision(source: CharacterBody2D, target: Fighter, attack: Attack) -> void:
	if (source != null && target != null && attack != null):
		var collision_normal = (target.global_position - global_position).normalized()
		var direction_bool = source.flip_horizontal if source is Fighter else source.velocity.x < 0
		#collision_normal.y -= 1 #adds more vertical knockback to hit
		var hit_direction_modifier = Vector2(-1, 1) if direction_bool else Vector2(1, 1)
		var total_knockback = attack.knockback * max(target.health / 2, 1)
		var total_direction = collision_normal + (attack.attack_hit_direction * hit_direction_modifier)
		var attack_force = total_direction * total_knockback
		var relative_velocity = target.velocity + attack_force

		target.health += attack.damage
		if !attack.is_projectile:
			target.velocity = relative_velocity * target.absorption
			source.attack_hitbox.emit_particles(total_knockback)

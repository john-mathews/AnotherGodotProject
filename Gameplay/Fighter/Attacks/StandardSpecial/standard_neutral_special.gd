extends BaseAttack

#can add properties to this later to customize it
#should also add shape properties to projectiles 
func shoot_projectile() -> void:
	if attack_owner.get('projectile_list'):
		var projectile = BaseProjectile.new()
		projectile.global_position = attack_owner.attack_hitbox.global_position
		projectile.attack = self
		attack_owner.projectile_list.add_child(projectile)

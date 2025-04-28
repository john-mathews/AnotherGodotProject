class_name BaseAttack extends Attack


func owner_velocity_override(vel: Vector2) -> void:
	attack_owner.velocity = vel

func freeze_owner() -> void:
	attack_owner.frozen = true
	
func unfreeze_owner() -> void:
	attack_owner.frozen = false

func set_init() -> void:
	pass

func reset_init() -> void:
	pass

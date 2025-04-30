extends BaseAttack

const PULL_FORCE = 2000.0 # Adjust for the strength of the pull
@onready var gravity_well_hitbox: AttackHitBox = $AttackHitBox
var grav_position:= Vector2.ZERO
const grav_timer:= 3

func _process(delta):
	if gravity_well_hitbox.monitoring:
		gravity_well_hitbox.global_position = grav_position
		for body in gravity_well_hitbox.get_overlapping_bodies():
			if body is Fighter && body != attack_owner:
				var direction = (gravity_well_hitbox.global_position - body.global_position).normalized()
				var distance = gravity_well_hitbox.global_position.distance_to(body.global_position)
				var force = direction * PULL_FORCE / max(distance/100, 1) # Pull decreases with distance
				
				body.health += damage / max(distance, 50)
				
				body.velocity += force * delta
		
		
func activate() -> void:
	visible = true
	gravity_well_hitbox.monitoring = true
	grav_position = global_position
	await get_tree().create_timer(grav_timer).timeout
	deactivate()
	
func deactivate() -> void:
	visible = false
	gravity_well_hitbox.monitoring = false
	gravity_well_hitbox.position = Vector2.ZERO

class_name Attack extends Node2D

@export var attack_name: String
@export var damage: float
@export var knockback: float #use collision normal for direction
@export var attack_hit_direction: Vector2

var hurtbox: AttackHitBox
var animation: AnimationPlayer 

var attack_owner: Fighter
const attack_library_name:= "attacks"

	
func set_hurtbox(hitbox: AttackHitBox) -> void:
	hurtbox = hitbox
	hurtbox.connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node2D):
	if  attack_owner != null && body != attack_owner && body is Fighter:
		handle_collision(body)
		
func handle_collision(getting_hit: Fighter):
	var collision_normal = (getting_hit.position - attack_owner.position).normalized()
	#collision_normal.y -= 1 #adds more vertical knockback to hit
	var hit_direction_modifier = Vector2(-1, 1) if attack_owner.flip_horizontal else Vector2(1, 1)
	var total_knockback = knockback * max(getting_hit.health/2, 1)
	var total_direction = collision_normal + (attack_hit_direction * hit_direction_modifier)
	var attack_force =  total_direction * total_knockback
	var relative_velocity = attack_force - getting_hit.velocity
	getting_hit.velocity = relative_velocity * getting_hit.absorption
	getting_hit.health += damage
	getting_hit.on_damaged()
	hurtbox.emit_particles(total_knockback)
	

func play(animation_name: String) -> void:
	if animation != null:
		animation.play(attack_library_name + "/" + animation_name)

class_name AttackHitBox extends Area2D

@onready var particles := $AttackParticles
@onready var collision := $CollisionShape2D

@export var dimensions: Vector2 #use X value for Radius of circle
@export var shape_type: ShapeTypes

enum ShapeTypes {
	NONE,
	CIRCLE,
	RECTANGLE
}

const min_particles:= 5
const max_particles:= 100

func _ready() -> void:
	set_hitbox_shape(shape_type, dimensions)

func emit_particles(knockback: float) -> void:
	particles.amount = clamp(knockback/50, min_particles, max_particles)
	if !particles.is_emitting():
		particles.set_emitting(true)
		
func set_hitbox_shape(new_shape: ShapeTypes, new_dimensions: Vector2) -> void:
	shape_type = new_shape
	dimensions = new_dimensions
	if shape_type == ShapeTypes.CIRCLE:
		var circle = CircleShape2D.new()
		circle.radius = dimensions.x
		collision.shape = circle
	elif shape_type == ShapeTypes.RECTANGLE:
		var rect = RectangleShape2D.new()
		rect.size = dimensions
		collision.shape = rect

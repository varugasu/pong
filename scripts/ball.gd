@tool

class_name Ball
extends Node2D

@export var radius = 10.0
@export var color = Color.RED
@export var rotation_multiplier = 0.01
@export var circle_segments = 48
@export var line_thickness = 2.0
@export var initial_speed = 200.0
@export var velocity = Vector2.ZERO
@export var bouncing_speed_multiplier = 5.0
@export var max_speed = 5000.0

@export var debug_mode = false

var rotation_angle = 0.0

var screen_size = Vector2.ZERO

enum Side {
	TOP,
	BOTTOM
}

signal scored(side: Side)

func _draw() -> void:
	var velocity_angle = velocity.angle()
	# rotates the coordinate system
	# draw_set_transform(Vector2.ZERO, velocity_angle, Vector2.ONE)

	var arc_points1: Array[Vector2] = []
	var arc_points2: Array[Vector2] = []
	for i in circle_segments + 1:
		var theta = (i / float(circle_segments)) * TAU
		var x = radius * cos(theta)
		var y = radius * sin(theta)

		var p1 = Vector2(x * cos(rotation_angle), y).rotated(velocity_angle)
		var p2 = Vector2(x * cos(rotation_angle + PI / 2), y).rotated(velocity_angle)


		arc_points1.append(p1)
		arc_points2.append(p2)
	
	draw_polyline(arc_points1, color, line_thickness)
	draw_polyline(arc_points2, color, line_thickness)
	if debug_mode:
		draw_line(Vector2.ZERO, velocity.normalized() * radius * 2, Color.YELLOW, 2.0)


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	screen_size = get_viewport_rect().size

func random_launch():
	var angle = TAU * randf()
	velocity = Vector2(cos(angle), sin(angle)) * initial_speed

func _update_wall_collision() -> void:
	if position.x - radius <= 0.0 or position.x + radius >= screen_size.x:
		velocity.x = - velocity.x * randf_range(1, bouncing_speed_multiplier)
	if position.y - radius <= 0.0:
		scored.emit(Side.BOTTOM)
	if position.y + radius >= screen_size.y:
		scored.emit(Side.TOP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	_update_wall_collision()
	
	rotation_angle += velocity.length() * rotation_multiplier * delta
	rotation_angle = fmod(rotation_angle, TAU)

	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	position += velocity * delta

	
	queue_redraw()

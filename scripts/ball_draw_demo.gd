@tool
extends Node2D

@export var radius = 10.0
# Rendering 
@export var arc1_color = Color.RED
@export var arc2_color = Color.RED
@export var rotation_multiplier = 0.01
@export var circle_segments = 48
@export var line_thickness = 2.0

@export var override_rotation_angle = false
@export var override_rotation_angle_value = 0.0
var rotation_angle = 0.0

var screen_size = Vector2.ZERO

@export var velocity = Vector2.ZERO
@export var show_velocity = false

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
	
	draw_polyline(arc_points1, arc1_color, line_thickness)
	draw_polyline(arc_points2, arc2_color, line_thickness)
	if show_velocity:
		draw_line(Vector2.ZERO, velocity.normalized() * radius * 2, Color.YELLOW, 2.0)

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		delta = 0.005
	rotation_angle += rotation_multiplier * delta * 200
	rotation_angle = fmod(rotation_angle, TAU)
	if override_rotation_angle:
		rotation_angle = deg_to_rad(override_rotation_angle_value)
	queue_redraw()

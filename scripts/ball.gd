@tool
extends Node2D

@export var radius = 10.0
@export var color = Color.RED
@export var rotation_multiplier = 0.01
@export var circle_segments = 48
@export var line_thickness = 2.0
@export var speed = 200.0

var rotation_angle = 0.0
var velocity = Vector2.ZERO

func _draw() -> void:
	var arc_points1: Array[Vector2] = []
	var arc_points2: Array[Vector2] = []
	for i in circle_segments + 1:
		var theta = (i / float(circle_segments)) * TAU
		var x_3d = radius * cos(theta)
		var y_3d = radius * sin(theta)


		arc_points1.append(Vector2(x_3d, y_3d * cos(rotation_angle)))
		arc_points2.append(Vector2(x_3d, y_3d * cos(rotation_angle + PI / 2)))
	
	draw_polyline(arc_points1, color, line_thickness)
	draw_polyline(arc_points2, color, line_thickness)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	var angle = 2 * PI * randf()
	velocity = Vector2(cos(angle), sin(angle)) * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	rotation_angle += velocity.y * rotation_multiplier * delta
	rotation_angle = fmod(rotation_angle, TAU)

	position += velocity * delta

	queue_redraw()

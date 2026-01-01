@tool
class_name Paddle extends Node2D

@export var speed = 400
@export var width = 100
@export var height = 20
@export var color = Color.GREEN

var screen_size = Vector2.ZERO

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(width, height)), color)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size

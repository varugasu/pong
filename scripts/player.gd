@tool
extends Node2D


@export
var speed = 400
@export
var width = 100
@export
var height = 20

var screen_size = Vector2.ZERO

func _draw() -> void:
	draw_rect(Rect2(Vector2.ZERO, Vector2(width, height)), Color.GREEN)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if Input.is_action_pressed("move_right"):
		position.x += speed * delta
	elif Input.is_action_pressed("move_left"):
		position.x -= speed * delta

	position = position.clamp(Vector2.ZERO, screen_size - Vector2(width, height))

@tool
extends Paddle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return

	if Input.is_action_pressed("move_right"):
		position.x += speed * delta
	elif Input.is_action_pressed("move_left"):
		position.x -= speed * delta

	position = position.clamp(Vector2.ZERO, screen_size - Vector2(width, height))

@tool
extends Paddle

@export var ball: Ball
@export var reaction_speed = 0.7
@export var max_error = 50.0
@export var update_interval = 0.15

var target_x = 0.0
var update_timer = 0.0
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	super._ready()
	if Engine.is_editor_hint():
		return
	target_x = position.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	update_timer -= delta
	if update_timer <= 0.0:
		update_timer = update_interval
		var error = randf_range(-max_error, max_error)
		target_x = ball.position.x + error
	
	var direction = target_x - (position.x + width / 2.0)
	var move_amount = sign(direction) * speed * reaction_speed * delta

	if abs(direction) < abs(move_amount):
		move_amount = direction
	position.x += move_amount
	position = position.clamp(Vector2.ZERO, screen_size - Vector2(width, height))

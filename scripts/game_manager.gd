extends Node

@export var score_to_win = 5
var bottom_paddle_score = 0
var top_paddle_score = 0

@export var bottom_paddle: Paddle
@export var top_paddle: Paddle
@export var ball: Ball

var screen_size = Vector2.ZERO

func _ready() -> void:
	screen_size = get_viewport().get_visible_rect().size
	ball.scored.connect(_on_scored)

	_reset_objects()

func _reset_objects() -> void:
	var middle = screen_size / 2
	ball.position = middle
	ball.random_launch()

	top_paddle.position.y = 0
	top_paddle.position.x = middle.x - top_paddle.width / 2.0
	bottom_paddle.position.y = screen_size.y
	bottom_paddle.position.x = middle.x - bottom_paddle.width / 2.0

func _on_scored(side: Ball.Side) -> void:
	if side == Ball.Side.TOP:
		top_paddle_score += 1
		_reset_objects()
	elif side == Ball.Side.BOTTOM:
		bottom_paddle_score += 1
		_reset_objects()

extends Node

@export var score_to_win = 5

var current_scene: Node2D = null
var ball: Ball = null
var screen_size = Vector2.ZERO

func _ready() -> void:
	current_scene = get_tree().root.get_child(-1)
	ball = current_scene.get_node("Ball")
	ball.scored.connect(_on_scored)
	screen_size = get_viewport().get_visible_rect().size

	ball.random_launch()

func _reset_ball() -> void:
	ball.position = screen_size / 2
	ball.random_launch()

func _on_scored(side: Ball.Side) -> void:
	if side == Ball.Side.TOP:
		print("Bottom player scored!")
		_reset_ball()
	elif side == Ball.Side.BOTTOM:
		print("Top player scored!")
		_reset_ball()

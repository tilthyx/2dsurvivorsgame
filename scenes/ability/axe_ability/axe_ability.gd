extends Node2D

const MAX_RADIUS = 100

func _ready() -> void:
	var tween = create_tween()
	tween.tween_method(tween_method, 0, 2, 2)


func tween_method(rotations: float):
	var current_radius = (rotations / 2)

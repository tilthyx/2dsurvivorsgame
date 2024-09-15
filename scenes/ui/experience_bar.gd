extends CanvasLayer

@export var experience_manager: Node

@onready var animation_manager = $AnimationPlayer
@onready var progress_bar = $MarginContainer/ProgressBar
@onready var level_label = $Label

func _ready() -> void:
	progress_bar.value = 0
	level_label.text = "LVL: " + str(1)
	experience_manager.experience_updated.connect(on_experience_updated)
	experience_manager.play_experience_bar_animation.connect(play_experience_bar_animation)


func on_experience_updated(current_experience: float, target_experience: float, current_level: int):
	var percent = current_experience / target_experience
	progress_bar.value = percent
	
	level_label.text = "LVL: " + str(current_level)

func play_experience_bar_animation():
	animation_manager.play("progressbar_animation")

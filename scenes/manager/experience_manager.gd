extends Node

signal experience_updated(current_experience: float, target_experience: float, current_level: int)
signal play_experience_bar_animation()
signal level_up(new_level: int)

const TARGET_EXPERIENCE_GROWTH = 5

var current_experience = 0
var current_level = 1
var target_experience = 1


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(xp: float):
	current_experience = min(current_experience + xp, target_experience)
	experience_updated.emit(current_experience, target_experience, current_level)
	if current_experience == target_experience:
		current_level += 1
		target_experience += TARGET_EXPERIENCE_GROWTH
		current_experience = 0
		play_experience_bar_animation.emit()
		experience_updated.emit(current_experience, target_experience, current_level)
		level_up.emit(current_level)
	
	
func on_experience_vial_collected(xp: float):
	increment_experience(xp)

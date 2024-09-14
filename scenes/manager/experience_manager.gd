extends Node

var current_experience = 0

func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(xp: float):
	current_experience += xp
	print(current_experience)
	
	
func on_experience_vial_collected(xp: float):
	increment_experience(xp)

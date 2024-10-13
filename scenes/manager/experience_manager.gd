extends Node

signal experience_updated(current_experience: float, target_experience: float, current_level: int)
signal play_experience_bar_animation()
signal level_up(new_level: int)

@export var level: String = "default"

#TODO: Balancear a quantidade de xp necessaria para o proximo nivel
var target_experience_growth = 0
var expirience_multiply
var current_experience = 0
var current_level = 1
var target_experience = 1

var level_to_growth

func _ready() -> void:
	GameEvents.experience_vial_collected.connect(on_experience_vial_collected)


func increment_experience(xp: float):
	current_experience = min(current_experience + xp, target_experience)
	experience_updated.emit(current_experience, target_experience, current_level)
	if current_experience == target_experience:
		increase_level()
		current_level += 1
		expirience_multiply = current_experience * target_experience_growth
		print("Exp multiply: ", expirience_multiply)
		target_experience += expirience_multiply
		print("Target Exp: ", target_experience)
		current_experience = 0
		play_experience_bar_animation.emit()
		experience_updated.emit(current_experience, target_experience, current_level)
		level_up.emit(current_level)
		

func increase_level():
	if not level == "default":
		level = "level_"+str(current_level)
		print("Level Atual: ", level)
		level_to_growth = Database.get_level(level)
		target_experience_growth = level_to_growth
	
	level_to_growth = Database.get_level(level)
	target_experience_growth = level_to_growth
	
func on_experience_vial_collected(xp: float):
	increment_experience(xp)

extends Node

signal experience_vial_collected(xp: float)

func emit_experience_vial_collected(xp: float):
	experience_vial_collected.emit(xp)

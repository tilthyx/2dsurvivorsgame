extends Node2D

var boss = [3,9]

func _on_area_2d_area_entered(area: Area2D) -> void:
	var boss_spawn_chance: int = randi_range(1, 10)
	var random_xp: float = randf_range(0.1, 1)
	
	print("Boss Spawn Chance: ", boss_spawn_chance)
	
	if boss_spawn_chance in boss:
		random_xp *= 2
		print("Boss XP: ", random_xp)
	
	print("XP: ", random_xp)
	GameEvents.emit_experience_vial_collected(random_xp)
	queue_free()

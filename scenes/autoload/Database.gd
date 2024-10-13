extends Node

var _levels_model: Dictionary
var _player_abilities_model: Dictionary

func get_level(level):
	var file = FileAccess.open("res://data/levels_data.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		_levels_model = JSON.parse_string(content)
	
	if not _levels_model.has(level) or not _levels_model[level].has("target_experience_growth"):
		return _levels_model["default"]["target_experience_growth"]
	
	return _levels_model[level]["target_experience_growth"]

func get_player_abilities(ability: String):
	var file = FileAccess.open("res://data/player_abilities_data.json", FileAccess.READ)
	if file:
		var content = file.get_as_text()
		_player_abilities_model = JSON.parse_string(content)
	
	if not _player_abilities_model.has(ability):
		return _player_abilities_model["default"]
	
	return _player_abilities_model[ability]
	

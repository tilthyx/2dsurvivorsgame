extends CanvasLayer

func _ready() -> void:
	get_tree().paused = true
	

func set_defeat():
	%TitleLabel.text = "Defeat"
	%DescriptionLabel.text = "You Lost!"

func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()

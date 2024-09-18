extends PanelContainer

signal selected

@onready var name_label: Label = %NameLabel
@onready var label_description: Label = %DescriptionLabel


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	label_description.text = upgrade.description


func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		selected.emit()

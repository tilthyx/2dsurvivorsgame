extends PanelContainer

@onready var name_label: Label = %NameLabel
@onready var label_description: Label = %DescriptionLabel


func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	label_description.text = upgrade.description

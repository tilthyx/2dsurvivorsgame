extends Node

# Exports a variable for a sword ability, which is a PackedScene that can be instantiated later.
@export var sword_ability : PackedScene

# Called when the node enters the scene tree for the first time.
# Connects the Timer's timeout signal to the custom 'on_timer_timeout' function.
func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)

# This function is called whenever the Timer node times out.
# It creates an instance of the sword ability and places it at the player's position.
func on_timer_timeout() -> void:
	# Retrieve the first node in the "player" group as a Node2D (the player character).
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	# If no player is found, exit the function.
	if player == null:
		return 
	
	# Instantiate a new instance of the sword ability.
	var sword_instance = sword_ability.instantiate() as Node2D
	
	# Add the sword instance as a child to the player's parent node (usually the game scene).
	player.get_parent().add_child(sword_instance)
	
	# Set the sword instance's position to the player's current global 
	sword_instance.global_position = player.global_position

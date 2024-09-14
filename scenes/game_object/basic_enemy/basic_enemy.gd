extends CharacterBody2D

# Maximum speed the character moves
const MAX_SPEED = 40

@onready var health_component: HealthComponent = $HealthComponent

# Called every frame. 'delta' is the time elapsed since the previous frame.
# Handles the movement of the character towards the player.
func _process(delta: float) -> void:
	# Get the direction towards the player
	var direction = get_direction_to_player()
	
	# Set the velocity in the direction of the player, with the given speed
	velocity = direction * MAX_SPEED
	
	# Move the character while sliding along any obstacles
	move_and_slide()

# Calculates the normalized direction vector towards the player.
# Returns Vector2.ZERO if no player node is found.
func get_direction_to_player() -> Vector2:
	# Retrieve the first node in the "player" group
	var player_node = get_tree().get_first_node_in_group("player") as Node2D
	
	# If a player node exists, calculate the direction towards it
	if player_node != null:
		# Subtract the character's position from the player's to get the direction vector
		# and normalize it to keep the movement speed consistent
		return (player_node.global_position - global_position).normalized()
	
	# Return a zero vector if no player node is found
	return Vector2.ZERO

extends Camera2D

# Target position the camera should move toward
var target_position = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
# This is used to make the camera the active one in the scene.
func _ready() -> void:
	# Sets this camera as the current camera for the scene
	make_current()

# Called every frame. 'delta' is the time elapsed since the previous frame.
# This is used to smoothly update the camera's position.
func _process(delta: float) -> void:
	# Updates the target position to follow the player
	acquire_target()
	
	# Smoothly moves the camera towards the target position using linear interpolation (lerp).
	# The speed of the movement is influenced by 'delta' and the exponential function.
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))

# Acquires the position of the target (usually the player).
# The player node is assumed to be in the "player" group.
func acquire_target() -> void:
	# Gets all nodes in the "player" group.
	var player_node = get_tree().get_nodes_in_group("player")
	
	# If there is at least one node in the "player" group, acquire its position.
	if player_node.size() > 0:
		# Cast the first player node to a Node2D and assign its global position to target_position.
		var player = player_node[0] as Node2D
		target_position = player.global_position

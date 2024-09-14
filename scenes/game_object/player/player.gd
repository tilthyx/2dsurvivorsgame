extends CharacterBody2D

# Maximum speed the character can move
const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

# Called when the node enters the scene tree for the first time.
# This is usually where initialization occurs.
func _ready() -> void:
	pass # Replace with function body if needed.

# Called every frame. 'delta' is the time elapsed since the previous frame.
# Updates the character's movement every frame.
func _process(delta: float) -> void:
	# Get the player's intended movement vector based on input
	var movement_vector = get_movement_vector()
	
	# Normalize the direction vector to ensure movement speed remains consistent 
	# regardless of diagonal movement.
	var direction = movement_vector.normalized()
	
	var target_velocity = direction * MAX_SPEED
	
	# Set velocity based on direction and maximum speed
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * ACCELERATION_SMOOTHING))
	
	# Move the character using the calculated velocity, sliding along surfaces when necessary
	move_and_slide()

# Gets the movement vector based on player input.
# Uses action strength for right/left and up/down movement.
func get_movement_vector() -> Vector2:
	# Horizontal movement: right - left
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	# Vertical movement: down - up
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	# Returns a vector containing the intended movement direction
	return Vector2(x_movement, y_movement)

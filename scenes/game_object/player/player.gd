extends CharacterBody2D

# Maximum speed the character can move
const MAX_SPEED = 125
const ACCELERATION_SMOOTHING = 25

@onready var damage_interval_timer = $DamageIntervalTimer
@onready var health_component = $HealthComponent
@onready var health_bar = $HealthBar

var number_colliding_bodies = 0

func _ready() -> void:
	update_health_display() 

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

func check_deal_demage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	
#	TODO: Fazer a mudança de quando de dano será aplicado
	health_component.damage(1)
	damage_interval_timer.start()
	print(health_component.current_health)

func update_health_display():
	health_bar.value = health_component.get_health_percent()

func _on_colision_area_2d_body_entered(body: Node2D) -> void:
	number_colliding_bodies += 1
	print(body)
	check_deal_demage()


func _on_colision_area_2d_body_exited(body: Node2D) -> void:
	number_colliding_bodies -= 1


func _on_damage_interval_timer_timeout() -> void:
	check_deal_demage()


func _on_health_component_health_changed() -> void:
	update_health_display()

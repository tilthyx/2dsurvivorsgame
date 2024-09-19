extends Node

# Exports a variable to store a PackedScene of the sword ability.
# This scene can be instantiated when the ability is triggered.
@export var sword_ability : PackedScene

# Exports a variable for the maximum range within which enemies can be targeted.
# The default value is set to 150.
@export var max_range : float = 150

var damage = 5
var base_wait_time

# Called when the node enters the scene tree for the first time.
# Connects the Timer node's timeout signal to the 'on_timer_timeout' function.
func _ready() -> void:
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

# This function is called when the Timer times out.
# It finds the nearest enemy within a specified range and spawns the sword ability at their position.
func on_timer_timeout() -> void:
	# Get the first node in the "player" group as a Node2D (the player).
	var player = get_tree().get_first_node_in_group("player") as Node2D
	
	# If no player node is found, exit the function.
	if player == null:
		return
	
	# Get all nodes in the "enemy" group.
	var enemies = get_tree().get_nodes_in_group("enemy")
	
	# Filter the list of enemies to include only those within 'max_range' from the player.
	enemies = enemies.filter(func(enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(max_range, 2)
	)
	
	# If no enemies are within range, exit the function.
	if enemies.size() == 0:
		return 

	# Sort the enemies by their distance from the player, from nearest to farthest.
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)
		return a_distance < b_distance
	)
	
	# Instantiate the sword ability and position it at the nearest enemy.
	var sword_instance = sword_ability.instantiate() as SwordAbility
	
	var foreground_layer = get_tree().get_first_node_in_group("foreground_layer")
	
	# Add the sword instance to the player's parent (usually the game scene).
	foreground_layer.add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	
	# Set the sword instance's position to the nearest enemy's position.
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()


func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return
		
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	$Timer.start()
	
	print($Timer.wait_time)

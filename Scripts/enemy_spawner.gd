extends Node3D

@export var enemy_scene: PackedScene
@export var min_distance_player = 5.0
@export var min_spawn_distance = -10.0
@export var max_spawn_distance = 10.0

func _on_timer_timeout() -> void:
	var enemy : Enemy = enemy_scene.instantiate()
	
	var spawn_vector: Vector3 = Vector3.ZERO
	var distance_to_player: float = 0.0
	
	var player = get_tree().get_first_node_in_group("player")
	
	while distance_to_player <= min_distance_player:
		var x = randf_range(min_spawn_distance, max_spawn_distance)
		var y = 0.0
		var z = randf_range(min_spawn_distance, max_spawn_distance)
		spawn_vector = Vector3(x, y, z)
		var direction_to_player: Vector3 = player.global_position - spawn_vector
		distance_to_player = direction_to_player.length()
		
	add_child(enemy)
	enemy.global_position = spawn_vector

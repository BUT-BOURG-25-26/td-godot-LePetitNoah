extends Node3D

var player : Player
var move_speed : float = 3

var movement : Vector3

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	movement_func()
	movement *= move_speed * delta
	if movement != Vector3.ZERO:
		global_position += Vector3(movement.x, 0.0, movement.y)
	return
	
func movement_func():
	if position.x < player.position.x:
		movement.x = 1
	elif position.x > player.position.x:
		movement.x = -1
	else :
		movement.x = 0
		
	if position.z < player.position.z:
		movement.y = 1
	elif position.z > player.position.z:
		movement.y = -1
	else :
		movement.y = 0
	
	movement = movement.normalized()
	print(movement)
	return

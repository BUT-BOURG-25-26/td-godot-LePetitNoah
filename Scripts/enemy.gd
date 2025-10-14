extends CharacterBody3D

class_name Enemy

var player : Player
var move_speed : float = 3

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	
func _physics_process(delta: float) -> void:
	var look_at_player = player.global_position
	look_at_player.y = global_position.y
	look_at(look_at_player)
	
	var direction = player.global_position - global_position
	direction = direction.normalized()
	velocity = direction * move_speed
	velocity.y = get_gravity().y
	move_and_slide()
	
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is Player:
			player.take_damage(1)
			print("ba alors tu dpop pas")
			queue_free()
	return
	

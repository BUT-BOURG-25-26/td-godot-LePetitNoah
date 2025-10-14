extends Camera3D

@export var offset : Vector3
var player : Player

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	global_position = player.global_position + offset
	return

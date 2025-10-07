extends CharacterBody3D

class_name Player

var healthbar
@export var move_speed:float = 5
@export var health: int = 3

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health

func _process(delta:float) -> void:
	return

func _physics_process(delta: float) -> void:
	var move_inputs = read_move_inputs()
	move_inputs *= move_speed
	velocity = move_inputs
	move_and_slide()
	return

func read_move_inputs() -> Vector3:
	var move_inputs : Vector3
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return move_inputs

func take_damage(damage):
	health -= 1
	healthbar.update(health)
	return 

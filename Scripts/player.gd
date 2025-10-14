extends CharacterBody3D

class_name Player

var healthbar
@export var move_speed:float = 5
@export var health: int = 3

@export var mouse_sensitivity: float = 0.003
@export var max_look_up: float = 80.0   # en degrés
@export var max_look_down: float = -80.0 # en degrés

@onready var camera_pivot: Node3D = $CameraPivot
@onready var camera: Camera3D = $CameraPivot/Camera3D

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _process(delta:float) -> void:
	return

func _physics_process(delta: float) -> void:
	var move_inputs = read_move_inputs()
	move_inputs = global_transform.basis * move_inputs
	move_inputs.y = 0.0  # On évite toute inclinaison verticale si la caméra regarde vers le haut/bas
	velocity.x = move_inputs.x * move_speed
	velocity.z = move_inputs.z * move_speed
	move_and_slide()
	return
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		
		# Rotation verticale de la caméra via le pivot
		camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		# Clamp la rotation X pour éviter de faire des tours
		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, max_look_down, max_look_up)
		

func read_move_inputs() -> Vector3:
	var move_inputs : Vector3
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return move_inputs

func take_damage(damage):
	health -= 1
	healthbar.update(health)
	if health <= 0:
		get_tree().reload_current_scene()
	return 

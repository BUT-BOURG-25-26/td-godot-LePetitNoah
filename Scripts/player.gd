extends CharacterBody3D

class_name Player

var healthbar
@export var move_speed:float = 5
@export var health: int = 3

@export var vfx_scene: PackedScene
@export var game_over_scene: PackedScene

@onready var animation_tree : AnimationTree = $characterMedium/AnimationTree

var camera
var screen_pos
var from
var to
var space_state
var query
var result

# Pour une vue FPS
# @export var mouse_sensitivity: float = 0.003
# @export var max_look_up: float = 80.0   # en degrés
# @export var max_look_down: float = -80.0 # en degrés
# @onready var camera_pivot: Node3D = $CameraPivot
# @onready var camera: Camera3D = $CameraPivot/Camera3D

func _ready() -> void:
	healthbar = $SubViewport/HealthBar
	healthbar.max_value = health
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED Pour une vue FPS
	camera = get_tree().get_first_node_in_group("camera")

@warning_ignore("unused_parameter")
func _process(delta:float) -> void:
	return

@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	var move_inputs = read_move_inputs()
	# move_inputs.y = 0.0  Pour une vue FPS
	#velocity.x = move_inputs.x * move_speed
	#velocity.z = move_inputs.z * move_speed
	move_inputs *= move_speed
	velocity = move_inputs
	
	animation_tree.set("parameters/conditions/isIdle", move_inputs == Vector3.ZERO)
	animation_tree.set("parameters/conditions/isRunning", move_inputs != Vector3.ZERO)
	if velocity != Vector3.ZERO:
		var look_at_point = global_position + (move_inputs * 5.0)
		look_at(look_at_point)
	if !is_on_floor():
		velocity.y = get_gravity().y
	move_and_slide()
	attack()
	return
	
# Pour une vue FPS
#func _unhandled_input(event):
	#if event is InputEventMouseMotion:
		#rotate_y(-event.relative.x * mouse_sensitivity)
		#
		## Rotation verticale de la caméra via le pivot
		#camera_pivot.rotate_x(-event.relative.y * mouse_sensitivity)
		## Clamp la rotation X pour éviter de faire des tours
		#camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, max_look_down, max_look_up)

func read_move_inputs() -> Vector3:
	var move_inputs : Vector3
	move_inputs.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_inputs.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	move_inputs = move_inputs.normalized()
	return move_inputs

func attack():
	if Input.is_action_just_pressed("attack"):
		screen_pos = get_viewport().get_mouse_position()
		
		from = camera.project_ray_origin(screen_pos)
		to = from + camera.project_ray_normal(screen_pos) * 10000.0
		
		#DebugDraw3D.draw_line(from, to, Color.AQUA, 5)
		
		space_state = get_world_3d().direct_space_state
		query = PhysicsRayQueryParameters3D.create(from, to, 1)
		
		result = space_state.intersect_ray(query)
		
		if result :
			var vfx : VFX = vfx_scene.instantiate()
			add_child(vfx)
			vfx.global_position = result.position
			vfx.emit()

func take_damage(damage):
	health -= damage
	healthbar.update(health)
	if health <= 0:
		GameManager.display_game_over()
	return 

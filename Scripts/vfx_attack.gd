extends Area3D 

class_name VFX

@onready var flash = $Flash
@onready var sparks = $Sparks
@onready var shockwave = $Shockwave
@onready var flare = $Flare

func emit():
	flash.emitting = true
	flare.emitting = true
	shockwave.emitting = true
	sparks.emitting = true

func _on_shockwave_finished() -> void:
	queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is Enemy :
		var player : Player = get_tree().get_first_node_in_group("player")
		GameManager.increase_score()
		body.queue_free()

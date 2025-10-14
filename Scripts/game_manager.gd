extends Node

class_name Game_manager

var player : Player
var score : int
var score_label : Label

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	score_label = get_tree().get_first_node_in_group("score")

func _process(delta: float) -> void:
	if player:
		score = player.cmpt_kills
		score_label.text = "Nombre de kills : " + str(score)

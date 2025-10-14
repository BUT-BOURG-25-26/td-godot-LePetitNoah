extends Node

var score_label : Label
var score = 0

@onready var start_game: PackedScene = preload("res://Scenes/MainScene.tscn")
@export var main_menu: PackedScene = preload	("res://Scenes/MainMenu.tscn")
@export var game_over: PackedScene = preload("res://Scenes/GameOver.tscn")

func init() -> void :
	score_label = get_tree().get_first_node_in_group("score")
	score_label.text = "Enemy killed : 0"

func start() -> void :
	get_tree().change_scene_to_packed(start_game)

func quit() -> void :
	get_tree().quit()

func restart() -> void :
	get_tree().reload_current_scene()
	score = 0
	Engine.time_scale = 1.0

func display_game_over() -> void:
	var game_over_menu = get_tree().get_first_node_in_group("game_over")
	game_over_menu.visible = true
	Engine.time_scale = 0.0

func increase_score() -> void:
	score += 1
	score_label.text = "Enemies killed : " + str(score)

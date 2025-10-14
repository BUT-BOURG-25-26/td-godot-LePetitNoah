extends Control

var jouer_bouton : Button
var quitter_bouton : Button

@onready var start_game: PackedScene = preload("res://Scenes/MainScene.tscn")

func _ready() -> void:
	jouer_bouton = $jouer
	quitter_bouton = $quitter
	
	jouer_bouton.pressed.connect(_jouer)
	quitter_bouton.pressed.connect(_quitter)
	
func _jouer():
	print("Partie lancée")
	GameManager.start()

func _quitter():
	print("Partie quittée")
	GameManager.quit()

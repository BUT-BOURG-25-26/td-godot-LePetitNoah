extends Control

var rejouer_bouton : Button
var quitter_bouton : Button

func _ready() -> void:
	rejouer_bouton = $rejouer
	quitter_bouton = $quitter
	
	rejouer_bouton.pressed.connect(_rejouer)
	quitter_bouton.pressed.connect(_quitter)
	
func _rejouer():
	print("Partie relancée")
	GameManager.restart()

func _quitter():
	print("Partie quittée")
	GameManager.quit()

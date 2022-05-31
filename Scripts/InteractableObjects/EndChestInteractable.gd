extends Area2D

var active = false
onready var game = get_node("/root/Game")

signal completed_game()

func _input(event):
	if event.is_action_pressed("interact") and active:
		game.hide_interact()
		
		# Interaction
		emit_signal("completed_game")

func _on_body_entered(body):
	game.display_interact()
	if body.name == "Player":
		active = true


func _on_body_exited(body):
	game.hide_interact()
	if body.name == "Player":
		active = false


func _on_ChestArea2D_area_entered(_area):
	game.display_interact()
	active = true


func _on_ChestArea2D_area_exited(_area):
	game.hide_interact()
	active = false

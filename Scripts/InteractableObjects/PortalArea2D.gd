extends Area2D

var active = false

onready var game = get_node("/root/Game")

func _input(event):
	if event.is_action_pressed("interact") and active:
		# Change scene
		get_parent().change_scene("res://Scenes/Crypt.tscn")


func _on_PortalArea2D_area_entered(_area):
	game.display_interact()
	active = true


func _on_PortalArea2D_area_exited(_area):
	game.hide_interact()
	active = false

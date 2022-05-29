extends Area2D

var active = false

func _input(event):
	if event.is_action_pressed("interact") and active:
		# Change scene
		get_parent().change_scene("res://Scenes/Crypt.tscn")


func _on_PortalArea2D_area_entered(_area):
	active = true


func _on_PortalArea2D_area_exited(_area):
	active = false

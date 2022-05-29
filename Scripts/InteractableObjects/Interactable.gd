extends Area2D

var active = false
onready var game = get_node("/root/Game")

func _input(event):
	if event.is_action_pressed("interact") and active:
		game.hide_interact()
		var parent = self.get_parent()
		if parent.has_method("interact"):
			parent.call("interact")

func _on_body_entered(body):
	game.display_interact()
	if body.name == "Player":
		active = true


func _on_body_exited(body):
	game.hide_interact()
	if body.name == "Player":
		active = false


func _on_Area2D_area_entered(area):
	game.display_interact()
	active = true


func _on_Area2D_area_exited(area):
	game.hide_interact()
	active = false

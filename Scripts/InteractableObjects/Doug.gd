extends Area2D


var active = false

func _input(event):
	if event.is_action_pressed("interact") and active:
		print("interacted!")


func _on_Doug_body_entered(body):
	if body.name == "Player":
		active = true


func _on_Doug_body_exited(body):
	if body.name == "Player":
		active = false

extends Area2D

var active = false

func _input(event):
	if event.is_action_pressed("interact") and active:
		var parent = self.get_parent()
		if parent.has_method("interact"):
			parent.call("interact")

func _on_body_entered(body):
	if body.name == "Player":
		active = true


func _on_body_exited(body):
	if body.name == "Player":
		active = false

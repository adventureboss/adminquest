extends KinematicBody2D

onready var in_range = false

func _process(delta):
	if in_range:
		if Input.is_action_just_pressed("interact"):
			print("interacted!")


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		in_range = true


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		in_range = false

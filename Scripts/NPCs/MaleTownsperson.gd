extends "res://Scripts/Dialog/actor.gd"

const doug_dialogue = preload("res://Scripts/Dialog/doug.tres")
onready var in_range = false

func _process(delta):
	if in_range == true:
		if Input.is_action_just_pressed("interact"):
			game_state.show_dialogue(doug_dialogue, "main")

func _on_Area2D_body_entered(body):
		in_range = true

func _on_Area2D_body_exited(body):
		in_range = false


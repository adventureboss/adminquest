extends Area2D

onready var in_range = false

func _on_InsideInteractionZone(body):
	if body.name == "Player":
		in_range = true

func _on_OutsideInteractionZone(body):
	if body.name == "Player":
		in_range = false

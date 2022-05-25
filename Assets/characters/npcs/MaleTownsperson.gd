extends KinematicBody2D

onready var interaction = false

func _on_InteractionSpace_area_entered(area):
	interaction = true

func _on_InteractionSpace_area_exited(area):
	interaction = false

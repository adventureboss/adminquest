extends "Npc.gd"

var dialogue = preload("res://Dialogue/lordgraybeard.tres")


func interact():
	$Sprite.flip_h = true
	GameState.start_dialogue(dialogue, "main")

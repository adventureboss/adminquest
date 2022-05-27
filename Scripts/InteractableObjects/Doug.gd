extends "Npc.gd"

var dialogue = preload("res://Dialogue/Doug.tres")

func interact():
	GameState.start_dialogue(dialogue, "main")

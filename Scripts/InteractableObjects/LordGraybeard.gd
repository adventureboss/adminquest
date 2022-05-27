extends "Npc.gd"

var dialogue = preload("res://Assets/Dialogue/lordgraybeard.tres")

func interact():
	GameState.start_dialogue(dialogue, "main")

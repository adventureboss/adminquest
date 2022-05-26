extends Area2D

export(Resource) var dialogFile
export(String) var entryDialog

func interact():
	GameState.game.display_dialogue(dialogFile, entryDialog)

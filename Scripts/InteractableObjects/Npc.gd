extends Area2D

export(Resource) var dialogFile
export(String) var entryDialog

func interact():
		GameState.start_dialogue(dialogFile, entryDialog)

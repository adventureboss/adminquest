extends Area2D

export(Resource) var dialogFile
export(Resource) var dialogFile_completed
export(String) var entryDialog

func interact():
	if GameState.win_status && is_instance_valid(dialogFile_completed):
		GameState.start_dialogue(dialogFile_completed, entryDialog)
	else:
		GameState.start_dialogue(dialogFile, entryDialog)

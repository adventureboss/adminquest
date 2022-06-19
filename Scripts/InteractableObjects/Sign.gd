extends "res://Scripts/InteractableObjects/Interactable.gd"

export(Resource) var dialogFile
export(String) var entryDialog

func interact():
		GameState.start_dialogue(dialogFile, entryDialog)

extends ColorRect

onready var dialogue = preload("res://Dialogue/introduction.tres")
onready var game_state = get_node("/root/GameState")
export var next_scene = "Sea"
export var scene_path_to_load = "res://Scenes/Game.tscn"


func _ready():
	self.start_dialogue(dialogue, "main")

func start_dialogue(resource, entry) -> void:
	DialogueManager.game_states = [self]
	get_tree().paused = true
	var dialogue = yield(DialogueManager.get_next_dialogue_line(entry, resource), "completed")
	if dialogue != null:
		var balloon = preload("res://Scenes/Dialogue/IntroBalloon.tscn").instance()
		balloon.dialogue = dialogue
		get_tree().current_scene.add_child(balloon)
		start_dialogue(resource, yield(balloon, "actioned"))
	else:
		get_tree().paused = false

		var _game = get_tree().change_scene(scene_path_to_load)
		
		game_state.current_scene_name = next_scene


extends Node2D

export var path_to_load  = "res://Scenes/Sea.tscn"

signal scene_changed(path)

var dialogueName = null
var dialogueSection = null

func _ready():
	add_scene(path_to_load)
	$CanvasLayer/DialogBox.visible = false
	GameState.game = self

func add_scene(path = "res://Scenes/Sea.tscn"):
	var scene = load(path)
	
	emit_signal("scene_changed", path)
	
	if scene == null:
		# no scene, no game...
		var _game = get_tree().change_scene("res://Scenes/title_screen.tscn")

	var instance = scene.instance()
	call_deferred("add_child", instance)

func remove_scene(scene):
	call_deferred("remove_child", scene)

func display_dialogue(_dialogueName, _dialogueSection):
	$CanvasLayer/DialogBox.visible = true

func display_interact():
	$CanvasLayer/InteractTip.show()

func hide_interact():
	$CanvasLayer/InteractTip.hide()

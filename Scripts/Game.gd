extends Node2D

export var path_to_load  = "res://Scenes/World.tscn"

func _ready():
	add_scene(path_to_load)
	
func add_scene(path = "res://Scenes/World.tscn"):
	var scene = load(path)
	if scene == null:
		# no scene, no game...
		get_tree().change_scene("res://Scenes/title_screen.tscn")

	var instance = scene.instance()
	call_deferred("add_child", instance)

func remove_scene(scene):
	remove_child(scene)

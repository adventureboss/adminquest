extends Node2D

onready var game_state = get_node("/root/GameState")



func _ready():
	set_camera_limits()
	game_state.connect("show_dialogue", self, "show_dialogue")

func set_camera_limits():
	var map_limits = $GroundTileMap.get_used_rect()
	var map_cellsize = $GroundTileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func show_dialogue(resource: DialogueResource, title: String) -> void:
	var dialogue = yield(DialogueManager.get_next_dialogue_line(title, resource), "completed")
	if dialogue != null:
		var node = preload("res://Scenes/UI/Dialog.tscn").instance()
		$CanvasLayer/DialogBox.visible = true
		node.dialogue = dialogue
		show_dialogue(resource, yield(node, "actioned"))
	

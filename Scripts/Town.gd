extends Node2D

onready var game_state = get_node("/root/GameState")
onready var game = get_parent()

func _ready():
	game.hide_interact()
	
	set_player_transform()
	set_camera_limits()

func set_player_transform():
	var prev_scene = game_state.current_scene_name
	var position
	if prev_scene == "Graveyard":
		position = $fromGraveyard
		$YSort/Player.position = position.position
	elif prev_scene == "Sea":
		position = $fromSea
		$YSort/Player.position = position.position
	else:
		# error, no entrance there
		pass
	game_state.scene_change("Town")
	
func set_camera_limits():
	var map_limits = $GroundTileMap.get_used_rect()
	var map_cellsize = $GroundTileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func _on_GraveyardArea2D_area_entered(_area):
	# Change to Graveyard scene
	var game = get_node("/root/Game")
	game.add_scene("res://Scenes/Graveyard.tscn")
	game.remove_scene(self)


func _on_DockArea2D_area_entered(_area):
	# Change to seaside scene
	var game = get_node("/root/Game")
	game.add_scene("res://Scenes/Sea.tscn")
	game.remove_scene(self)

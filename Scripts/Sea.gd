extends Node2D

onready var game_state = get_node("/root/GameState")

func _ready():
	set_player_transform()
	set_camera_limits()

func set_player_transform():
	var prev_scene = game_state.current_scene_name
	var position
	if prev_scene == "Town":
		position = $fromTown
		$YSort/Player.position = position.position
	else:
		# error, no entrance there
		pass
	game_state.scene_change("Sea")


func set_camera_limits():
	var map_limits = $ObjectsTileMap.get_used_rect()
	var map_cellsize = $ObjectsTileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y


func _on_TownArea2D_area_entered(_area):
	# Change to town area
	var game = get_node("/root/Game")
	game.remove_scene(self)
	game.add_scene("res://Scenes/Town.tscn")

extends Node2D

onready var game_state = get_node("/root/GameState")

func _ready():
	set_camera_limits()
	
	set_player_transform()
	
func set_player_transform():
	var prev_scene = game_state.current_scene_name
	var position
	if prev_scene == "Crypt":
		position = $fromCrypt
		$YSort/Player.position = position.position
	else:
		# error, no entrance there
		pass
	game_state.scene_change("Graveyard")


func set_camera_limits():
	var map_limits = $GraveyardTileMap.get_used_rect()
	var map_cellsize = $GraveyardTileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y


func _on_TownArea2D_area_entered(_area):
	var game = get_node("/root/Game")
	game.add_scene("res://Scenes/Town.tscn")
	game.remove_scene(self)

func change_scene(path = "res://Scenes/Town.tscn"):
	var game = get_node("/root/Game")
	game.add_scene(path)
	game.remove_scene(self)

extends Node2D

func _ready():
	set_camera_limits()
	set_character()


func set_camera_limits():
	var map_limits = $GraveyardTileMap.get_used_rect()
	var map_cellsize = $GraveyardTileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y

func set_character():
	pass

func _on_GraveyardArea2D_area_entered(_area):
	# Change to Graveyard scene
	print("help")
	var game = get_node("/root/Game")
	game.add_scene("res://Scenes/Graveyard.tscn")
	game.remove_scene(self)

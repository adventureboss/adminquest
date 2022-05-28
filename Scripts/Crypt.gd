extends Node2D

onready var player = get_node("YSort/Player")

func _ready():
	set_camera_limits()
	GameState.scene_change("Crypt")

func set_camera_limits():
	var map_limits = $CryptTileMap.get_used_rect()
	var map_cellsize = $CryptTileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x +1
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x - 1
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y - 1
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y + 1

func move_player(position):
	player.transform = position.transform

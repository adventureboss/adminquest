extends Node2D

func _ready():
	set_camera_limits()


func set_camera_limits():
	var map_limits = $ObjectsTileMap.get_used_rect()
	var map_cellsize = $ObjectsTileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y


func _on_TownArea2D_area_entered(area):
	# Change to town area
	var game = get_node("/root/Game")
	game.add_scene("res://Scenes/Town.tscn")
	game.remove_scene(self)
extends Control

onready var game_state = get_node("/root/GameState")

onready var hoursUI = $HoursLabel

func display_hours(value):
	if hoursUI != null:
		print("thing")
		hoursUI.text = str(value)
	
func _ready():
	print("thing1")
	display_hours(game_state.player_stats.hours)
	game_state.connect("hours_changed", self, "display_hours")

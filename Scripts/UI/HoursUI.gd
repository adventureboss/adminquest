extends Control

onready var game_state = get_node("/root/GameState")

onready var hoursUI = $Hours

func display_hours(value):
	if hoursUI != null:
		hoursUI.text = "Hours = " + value
	
func _ready():
	game_state.connect("hours_changed", self, "display_hours")

extends Control

onready var game_state = get_node("/root/GameState")

onready var fullHeartsUI =  $FullHearts
onready var emptyHeartsUI = $EmptyHearts

func display_health(value):
	if fullHeartsUI != null:
		fullHeartsUI.rect_size.x = value * 12
		
func display_max_health(value):
	if emptyHeartsUI != null:
		emptyHeartsUI.rect_size.x = value * 12
	
func _ready():
	display_max_health(game_state.player_stats.max_health)
	display_health(game_state.player_stats.health)
	game_state.connect("max_health_changed", self, "display_max_health")
	game_state.connect("health_changed", self, "display_health")

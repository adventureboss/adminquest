extends Control

onready var fullHeartsUI =  $FullHeart
onready var emptyHeartsUI = $EmptyHeart

onready var stats = get_node("../../Stats")

func display_health(value):
	if fullHeartsUI != null:
		fullHeartsUI.rect_size.x = value * 12
		
func display_max_health(value):
	if emptyHeartsUI != null:
		emptyHeartsUI.rect_size.x = value * 12

func _ready():
	display_max_health(stats.max_health)
	display_health(stats.health)
	
func _on_Stats_health_changed(value):
	display_health(stats.health)


func _on_Stats_max_health_changed(value):
	display_max_health(stats.max_health)

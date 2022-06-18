extends Node2D

export var path_to_load  = "res://Scenes/Sea.tscn"

signal scene_changed(path)

var dialogueName = null
var dialogueSection = null

func _ready():
	var _status = GameState.connect("no_health", self, "death")
	add_scene(path_to_load)
	$CanvasLayer/DialogBox.visible = false
	GameState.game = self
	
func _process(_delta):
	# display help dialog
	if Input.is_action_just_pressed("ui_cancel"):
		$CanvasLayer/HelpMenu/PopupPanel.popup()


func add_scene(path = "res://Scenes/Sea.tscn"):
	var scene = load(path)
	
	emit_signal("scene_changed", path)
	
	if scene == null:
		# no scene, no game...
		var _game = get_tree().change_scene("res://Scenes/title_screen.tscn")

	var instance = scene.instance()
	call_deferred("add_child", instance)

func remove_scene(scene):
	call_deferred("remove_child", scene)

func display_dialogue(_dialogueName, _dialogueSection):
	$CanvasLayer/DialogBox.visible = true

func display_interact():
	$CanvasLayer/InteractTip.show()

func hide_interact():
	$CanvasLayer/InteractTip.hide()
	
func hide_ui():
	$CanvasLayer/HealthUI.hide()
	$CanvasLayer/HoursUI.hide()
	
func show_ui():
	$CanvasLayer/HealthUI.show()
	$CanvasLayer/HoursUI.show()
	
func death():
	# player died
	$DeathTimer.start(3.0)

func _on_DeathTimer_timeout():
	$FadeIn.show()
	$FadeIn.Fade_in()
	add_scene("res://Scenes/death_screen.tscn")
	if GameState.current_scene_name == "Crypt":
		remove_scene(get_node("Crypt"))
	# anything else
	$FadeIn.hide()

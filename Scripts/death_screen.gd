extends Control

onready var game_state = get_node("/root/GameState")

export var next_scene = "Sea"
var scene_path_to_load

func _ready():
	get_parent().hide_ui()
	$Menu/CenterRow/Buttons/ContinueButton.grab_focus()
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])
		
func _on_Button_pressed(scene_to_load):
	scene_path_to_load = scene_to_load
	$FadeIn.show()
	$FadeIn.Fade_in()

func _on_FadeIn_fade_finished():
	if scene_path_to_load != "res://Scripts/title_screen.gd":
		get_parent().show_ui()
		
	var _game = get_tree().change_scene(scene_path_to_load)
	
	game_state.current_scene_name = next_scene

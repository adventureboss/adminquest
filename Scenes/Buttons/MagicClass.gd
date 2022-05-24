extends "res://Scenes/Buttons/ClassButton.gd"


var wizardm_texture = load("res://Assets/characters/classes/wizardM.png")
var wizardf_texture = load("res://Assets/characters/classes/wizardF.jpg")

func _ready():
	self.set_normal_texture(wizardm_texture)

func _on_M_pressed():
	self.set_normal_texture(wizardm_texture)
	
func _on_F_pressed():
	self.set_normal_texture(wizardf_texture)

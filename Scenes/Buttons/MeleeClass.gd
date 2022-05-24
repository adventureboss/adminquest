extends "res://Scenes/Buttons/ClassButton.gd"


var meleem_texture = load("res://Assets/characters/classes/meleeM.jpg")
var meleef_texture = load("res://Assets/characters/classes/meleeF.jpg")

func _ready():
	self.set_normal_texture(meleem_texture)

func _on_M_pressed():
	self.set_normal_texture(meleem_texture)
	
func _on_F_pressed():
	self.set_normal_texture(meleef_texture)

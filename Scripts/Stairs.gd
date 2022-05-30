extends Node2D

# Crypt reference
onready var crypt = get_parent()

func _ready():
	$Stair21.call_deferred("disabeled", true)
	
# Not the cleanest way to do this, but it allows for easy specification for each collision
func _on_Stair1_area_entered(_area):
	crypt.move_player($Position2)
	
func _on_Stair2_area_entered(_area):
	crypt.move_player($Position1)


func _on_Stair3_area_entered(_area):
	crypt.move_player($Position4)
	print("stair3")

func _on_Stair4_area_entered(_area):
	crypt.move_player($Position3)

func _on_Stair5_area_entered(_area):
	crypt.move_player($Position6)
	
func _on_Stair6_area_entered(_area):
	crypt.move_player($Position5)


func _on_Stair7_area_entered(_area):
	crypt.move_player($Position8)

func _on_Stair8_area_entered(_area):
	crypt.move_player($Position7)


func _on_Stair9_area_entered(_area):
	crypt.move_player($Position10)


func _on_Stair10_area_entered(_area):
	crypt.move_player($Position9)


func _on_Stair11_area_entered(_area):
	crypt.move_player($Position16)

func _on_Stair12_area_entered(_area):
	crypt.move_player($Position17)


func _on_Stair13_area_entered(_area):
	crypt.move_player($Position15)


func _on_Stair14_area_entered(_area):
	crypt.move_player($Position15)

func _on_Stair15_area_entered(_area):
	crypt.move_player($Position13)

func _on_Stair16_area_entered(_area):
	crypt.move_player($Position14)

func _on_Stair17_area_entered(_area):
	crypt.move_player($Position21)

func _on_Stair18_area_entered(_area):
	crypt.move_player($Position5)

func _on_Stair19_area_entered(_area):
	crypt.move_player($Position20)

func _on_Stair20_area_entered(_area):
	crypt.move_player($Position4)
	print("stair20")
	
func _on_Stair21_area_entered(_area):
	crypt.move_player($Position12)

func allow_enter_stair21():
	$Stair21.call_deferred("diabled", false)

extends "../Enemy.gd"

signal rip_vlog
signal display_evil_health
	
func _on_Stats_no_health():
	emit_signal("rip_vlog")

	$Timer.start(3.0)
	
	._on_Stats_no_health()

func _on_BossArea2D_area_entered(_area):
	# add whatever code to make dialog start
	# add hearts to screen
	emit_signal("display_evil_health")

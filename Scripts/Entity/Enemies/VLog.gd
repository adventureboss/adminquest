extends "../Enemy.gd"

signal rip_vlog

func _on_Stats_no_health():
	emit_signal("rip_vlog")
	._on_Stats_no_health()

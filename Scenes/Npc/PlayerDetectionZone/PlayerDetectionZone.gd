extends Area2D

var player = null

func canSeePlayer():
	return player != null

func onInsideDetectedZone(body):
	player = body

func onOutsideDetectedZone(body):
	if player == body:
		player = null

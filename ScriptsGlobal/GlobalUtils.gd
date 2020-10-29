extends Node

var EndTutorial01 = false
var ScorePlayer = 0
var StartOn = false

#Follow Magnetic
var Follow = false
var followTimer = 0.0

func _process(delta):
	if Follow:
		followTimer += delta
		get_node("/root/Level/HUD/Timer").text = str(int(followTimer))
		if followTimer > 20:
			Follow = false

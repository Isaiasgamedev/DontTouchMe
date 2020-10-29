extends KinematicBody2D

const TYPE = "CAM"

var velocity = Vector2()
export (int) var speed = 25
export (float) var TimerStart = 0.0
export (bool) var Movecam = false
export (bool) var StopStart = false

func _ready():
	if get_node("/root/Level/HUD/Start").visible == true:
		get_node("/root/Level/HUD/Start").visible = false
	TimerStart = 0

func _process(delta):
	if GlobalUtils.EndTutorial01 == false:
		return
	if get_node("/root/Level/HUD/Start").visible == false:
		get_node("/root/Level/HUD/Start").visible = true
	get_node("/root/Level/HUD/Start").text = str(int(TimerStart))
	if !StopStart:
		TimerStart += delta
		if TimerStart > 6:
			Movecam = true
			TimerStart = 0
			GlobalUtils.StartOn = true
			StopStart = true
	if Movecam:
		get_node("/root/Level/HUD/Start").visible = false
		move_and_slide(velocity)
		velocity.y = -speed

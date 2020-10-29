extends Node2D

func _ready():
	if $HUD/Button.visible == true:
		$HUD/Button.visible = false

func _process(delta):
	if GlobalUtils.StartOn:
		$HUD/Button.visible = true
		$HUD/Animhud.play("Start")
		yield($HUD/Animhud, "animation_finished")
		GlobalUtils.StartOn = false
		

func _on_exit_body_entered(body):
	if body.TYPE == "PLAYER":
		GlobalUtils.ScorePlayer = body.Score
		GlobalUtils.EndTutorial01 = false
		$Map/Exit/AnimExit.play("Exit")
		get_node("/root/Level/Player/anim").play("MoveDown")
		yield($Map/Exit/AnimExit, "animation_finished")
		get_tree().change_scene("res://Levels/Scenes/Level04.tscn")

func _on_Final_body_entered(body):
	if body.TYPE == "CAM":
		body.speed = 0

func _on_GameOver_body_entered(body):
	if body.TYPE == "PLAYER":
		GlobalUtils.EndTutorial01 = false
		body.queue_free()
		get_tree().change_scene("res://Levels/Scenes/Level03.tscn")

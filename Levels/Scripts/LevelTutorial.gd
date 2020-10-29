extends Node2D

func _process(delta):
	if GlobalUtils.StartOn:
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
		get_tree().change_scene("res://Levels/Scenes/Level02.tscn")

func _on_Final_body_entered(body):
	if body.TYPE == "CAM":
		body.speed = 0

func _on_GameOver_body_entered(body):
	if body.TYPE == "PLAYER":
		body.queue_free()
		get_tree().change_scene("res://Levels/Scenes/Level01.tscn")


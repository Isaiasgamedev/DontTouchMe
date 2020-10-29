extends Node2D

func _on_Final_body_entered(body):
	if body.TYPE == "CAM":
		body.speed = 0


func _on_GameOver_body_entered(body):
	if body.TYPE == "PLAYER":
		body.queue_free()
		get_tree().change_scene("res://Levels/Scenes/LevelTeste.tscn")


func _on_exit_body_entered(body):
	if body.TYPE == "PLAYER":
		GlobalUtils.ScorePlayer += body.Score
		get_tree().change_scene("res://Levels/Scenes/LevelTeste.tscn")

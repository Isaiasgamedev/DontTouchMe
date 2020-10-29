extends Node2D


func _on_start_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		get_tree().change_scene("res://Main/Scenes/LevelSelect.tscn")

extends Area2D

export (int) var Level




func _on_level_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
		get_tree().change_scene("res://Levels/Scenes/Level0" + str(Level) + ".tscn")

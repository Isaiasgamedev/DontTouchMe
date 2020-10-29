extends Area2D


var timerBomb = 0.0
var timerBool = false
var bodys 

func _process(delta):
	timerBomb += delta
	if timerBomb > 3:
		if bodys != null:
			bodys.queue_free()
		queue_free()


func _on_Bomb_body_entered(body):
	if body.TYPE == "ENEMY":
		bodys = body


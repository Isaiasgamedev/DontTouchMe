extends Area2D

export (float) var speed = 8
var velocity = Vector2()
var alvo 
var followOn = false



func _process(delta):
	if followOn:
		alvo = get_node("/root/Level/Player")
		velocity = (alvo.global_position - $".".global_position) * (delta / 2) * speed 
		translate(velocity)
		

func _on_Treasure_body_entered(body):
	if body.TYPE == "PLAYER":
		body.Score += 10
		$anim.play("get")


func _on_Follow_body_entered(body):
	if body.TYPE == "PLAYER":
		if body.MagneticOn:
			followOn = true

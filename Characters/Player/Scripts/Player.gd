extends KinematicBody2D
const TYPE = "PLAYER"

export (int) var speed = 200
export (bool) var HurtOn = false
export (int) var Score = 0
var target = Vector2()
var velocity = Vector2()
export (bool) var move = false
var actioncount = 0
var timerTarget = 0.0
var timerBool = false

var getScore = false

#SWIPE

var swipe_start = null
var minimum_drag = 200

#SKILLS
export (int) var weaponControl = 0
export (bool) var skillOn = false
export (bool) var skillActive = false

#MAGNETIC
export (bool) var MagneticOn = false
export (int) var MagneticCount = 2
export (float) var MagneticTimer = 0.0

#GHOST
export (bool) var GhostOn = false
export (float) var GhostTime = 0.0
export (int) var GhostCount = 10

#MINE
export (bool) var MineOn = false
export (int) var MineCount = 10
export (float) var MineTimer = 0.0
export (bool) var MineOnTimer = false


#TESTE
export (bool) var teste = false



func _ready():
	target = $".".global_position
	Score = GlobalUtils.ScorePlayer


func _input(event):
	if !move:
		if !HurtOn:
			if event.is_action_pressed('ui_click'):
				target = get_global_mouse_position()
				_ControlAnimate()


func _physics_process(delta):
	GlobalUtils.EndTutorial01 = teste
	if GlobalUtils.EndTutorial01 == false:
		return
	
	_ControlUIComplete(delta)
	if timerBool:
		timerTarget += delta
		if timerTarget > 0.5:
			move = false
			timerBool = false
			timerTarget = 0
			target = $".".global_position
			
	if MineOnTimer:
		MineTimer += delta
		if MineTimer > 0.5:
			MineOn = true

func _MovePlayer():
	if !move:
		get_node("/root/Level/HUD/Score").text = str(int(Score))
		velocity = position.direction_to(target) * speed
		#look_at(target)
		if position.distance_to(target) > 5:
			velocity = move_and_slide(velocity)

func _ControlAnimate():
	if target.x - global_position.x > 50 && target.y - global_position.y < 50:
		$anim.play("MoveRight")
	if target.x - global_position.x < -50 && target.y - global_position.y > -50:
		$anim.play("MoveLeft")
	if target.y - global_position.y > 50 && target.y - global_position.x > 50:
		$anim.play("MoveFront")
	if target.y - global_position.y < -50 && target.y - global_position.x > 50:
		$anim.play("MoveDown")

func _DisableHurt():
	HurtOn = false

func _on_Damage_body_entered(body):
	if !GhostOn:
		if body.TYPE != "PLAYER":
			Score -= 50
			get_node("/root/Level/HUD/Animhud").play("Dont")
			HurtOn = true
			$anim.play("HurtFront")

func _on_Button_pressed():
	if !move && !skillActive:
		move = true
		target = $".".global_position
		print("APERTEI")
		get_node("/root/Level/HUD/AnimButton").play("Change")
		weaponControl = 0
	else:
		timerBool = true
		print("APERTEI2")

func _on_OFF_pressed():
	timerBool = true
	skillOn = false
	skillActive = false
	weaponControl = 0
	target = $".".global_position
	MineOn = false
	MineTimer = 0
	get_node("/root/Level/HUD/AnimButton").play_backwards("Change")
	_RestartControl()

func _on_ON_pressed():
	if weaponControl == 0 && MagneticCount <= 0: 
		skillActive = false
		_RestartControl()
		get_node("/root/Level/HUD/AnimButton").play_backwards("Change")
	elif weaponControl == 2 && MineCount > 0:
		skillActive = true 
		skillOn = true
		target = $".".global_position
		MineOnTimer = true
	else:
		skillActive = true
		skillOn = true
		target = $".".global_position
		get_node("/root/Level/HUD/AnimButton").play_backwards("Change")

func _unhandled_input(event):
	if move:
		if event.is_action_pressed("ui_click"):
			swipe_start = event.get_position()
		if event.is_action_released("ui_click"):
			_calculate_swipe(event.get_position())

func _calculate_swipe(swipe_end):
	if !skillActive:
		if swipe_start == null: 
			return
		var swipe = swipe_end - swipe_start
		if abs(swipe.x) > minimum_drag:
			if swipe.x > 0:
				_right()
			else:
				_left()

func _right():
	if weaponControl < 5:
		weaponControl += 1
		print(weaponControl)

func _left():
	if weaponControl > 0:
		weaponControl -= 1
		print(weaponControl)

func _MineWeapon():
	if skillOn:
		if weaponControl == 2:
			if MineCount > 0:
				if MineOn:
					if Input.is_action_just_pressed("ui_click"):
						if MineCount > 0:
							MineCount -= 1
							var a = load("res://Characters/Player/Scenes/Mine.tscn")
							var b = a.instance()
							get_parent().add_child(b)
							b.position = get_global_mouse_position()
						else:
							_RestartControl()

func _SpecialGhostMode(delta):
	if skillOn:
		if weaponControl == 1:
			#print("WP  =  " + str(weaponControl))
			timerBool = true
			if GhostCount > 0:
				#print("GM  =  " + str(GhostModeCount))
				GhostOn = true
				if GhostOn:
					#print("SGM  =  " + str(specialGhostMode))
					$animSpecials.play("GhostModeEnter")
					GhostTime += delta
					get_node("/root/Level/HUD/Timer").text = str(int(GhostTime))
					#print("CONTAGEM =  " + str(int(GhostModeTime)))
					if GhostTime > 20:
						$animSpecials.play("GhostModeOut")
						GhostCount -= 1
						weaponControl = 0
						skillOn = false
						GhostOn = false
						GhostTime = 0
						skillActive = false
						get_node("/root/Level/HUD/Timer").text = str(int(GhostTime))
			else:
				weaponControl = 0
				skillOn = false
				GhostOn = false
				GhostTime = 0
				get_node("/root/Level/HUD/Timer").text = str(int(GhostTime))
				_RestartControl()

func _WeaponAnimControl():
	if weaponControl == 0:
		get_node("/root/Level/HUD/Skill").text = str(int(MagneticCount))
		get_node("/root/Level/HUD/AnimWeapon").play("Wp00")
	elif weaponControl == 1:
		get_node("/root/Level/HUD/Skill").text = str(int(GhostCount))
		get_node("/root/Level/HUD/AnimWeapon").play("Wp01")
	elif weaponControl == 2:
		get_node("/root/Level/HUD/Skill").text = str(int(MineCount))
		get_node("/root/Level/HUD/AnimWeapon").play("Wp02")

func _RestartControl():
	if weaponControl == 0:
		skillOn = false
		timerBool = true
		weaponControl = 0
		get_node("/root/Level/HUD/AnimButton").play_backwards("Change")

func _SpecialMagneticMode(delta):
	if skillOn:
		#print("SK =  " + str(skillOn))
		if weaponControl == 0:
			timerBool = true
			#print("WC  =  " + str(weaponControl))
			if MagneticCount > 0:
				#print("MC  =  " + str(MagneticCount))
				MagneticOn = true
				
				#print("MON  =  " + str(MagneticOn))
				if MagneticOn:
					$animSpecials.play("MagneticModeEnter")
					MagneticTimer += delta
					#timerBool = true
					#print("MON  =  " + str(MagneticOn))
					get_node("/root/Level/HUD/Timer").text = str(int(MagneticTimer))
					if MagneticTimer > 20:
						$animSpecials.play("MagneticModeOut")
						MagneticCount -= 1
						weaponControl = 0
						skillOn = false
						MagneticOn = false
						MagneticTimer = 0
						skillActive = false
						get_node("/root/Level/HUD/Timer").text = str(int(MagneticTimer))

func _ControlUIComplete(delta):
	#print(skillActive)
	#print(weaponControl)
	#print(move)
	_WeaponAnimControl()
	_SpecialGhostMode(delta)
	_SpecialMagneticMode(delta)
	if !move:
		_MovePlayer()
	else:
		_MineWeapon()

func _ControlGlobalChanges():
	if MagneticOn:
		GlobalUtils.Follow = true


func _on_Dont_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.is_pressed():
			move = true
			target = $".".global_position
			print("APERTEI")
			weaponControl = 0
			timerBool = true

extends RichTextLabel

# Variables
var dialog = [
	"HICK:",
	"A PARTIR DE AGORA FIQUE DE OLHO NA CONTAGEM, APOS ELA TERMINAR...",
	"A CAMERA IRA SE MOVER, NAO SE PREOCUPE EU SOU BEM RAPIDO, MAS...", 
	"SE FICARMOS PARA TRAS DELA BEM... AI AMIGO E GAME OVER, POR ISSO...", 
	"VAMOS SEGUIR CAMINHO ATE ENCONTRAMOS A SAIDA OK???",
	"......................................................."
	]
var page = 0

# Functions
func _ready():

	#$".".selection_color = Color(178, 0, 0, 1)
	set_process_input(true)
	set_bbcode(dialog[page])
	set_visible_characters(0)

func _process(delta):
	if page >= 5:
		GlobalUtils.EndTutorial01 = true
		get_parent().queue_free()

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1)
	

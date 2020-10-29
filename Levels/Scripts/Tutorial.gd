extends RichTextLabel

# Variables
var dialog = [
	"HICK:",
	"OLA EU SOU HICK, E NAO GOSTO NADA MESMO QUE ME TOQUEM...",
	"TENHO AVERSAO A SER TOCADO POR QUALQUER COISA, EXCETO UMA...", 
	"SE QUISER TRABALHAR COMIGO JA FIQUE SABENDO, PODEMOS...", 
	"FICAR RICOS, POR QUE A UNICA COISA QUE PERMITO QUE ME...",
	"TOQUE E A GRANA QUE VAMOS ENCONTRAR EM NOSSA AVENTURA...",
	"PARA ME GUIAR E SIMPLES, TOQUE NA TELA ONDE DESEJA QUE...",
	"EU VA E PRONTO EU IREI ATE LA, MAS CUIDADO PARA NAO ME...",
	"FAZER BATER EM NADA, SE NAO PERDEMOS GRANA, OLHA LA HEIN, CONFIO EM VOCE!!!...",
	"USE ESSE ESPACO PARA TREINAR, QUANDO TERMINAR VA PARA A SAIDA.",
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
	if page >= 10:
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
	

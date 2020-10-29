extends RichTextLabel

# Variables
var dialog = [
	"HICK:",
	"ESTA NA HORA DE FINELMENTE USARMOS MEUS INCRIVEIS PODERES...",
	"COMO VOCE PODE VER NO CANTO INFERIOR DIREITO DA TELA...", 
	"EXISTE UM BOTAO E NO CANTO SUPERIOR DIREITO VOCE...", 
	"VERA O SIMBOLO DO PODER QUE VAMOS USAR ESTE PRIMEIRO...",
	"ME DARA PODERES MAGNETICOS FAZENDO AS MOEDAS SE...",
	"APROXIMAREM DE MIM, APERTE O BOTAO POWER E DEPOIS...",
	"DOIS BOTOES VAO APARECER, (ON) ATIVARA O MEU PODER E UMA...",
	"CONTAGEM SERA INICIADA NO CANTO SUPERIOR NO CENTRO...",
	"AO FINAL DELA MEU PODER SERA DESATIVADO, O NUMERO AO LADO...",
	"DO PODER MOSTRA QUANTA VEZES PODEMOS USALO, CASO NAO...",
	"DESEJE USAR NENHUM PODER APERTE (OFF)...",
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
	if page >= 12:
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
	

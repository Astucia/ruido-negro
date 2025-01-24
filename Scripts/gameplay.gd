extends Node2D

var infoTimeCooldown = 1.0;
var bInfoText = false;
var clickCounter = 0;
var textCounter = 0;

var texto: Array[String] = [];
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_texto();
	$Panel/HistoriaRichTextLabel.text = texto[textCounter];
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Panel/DebugLabel.text = "Clics: %s" % [clickCounter];
	pass


func _on_info_timer_timeout() -> void:
	
	if(!bInfoText):
		$Panel/ScreenButton.text = ">>  <<"
		bInfoText = true;
	else:
		$Panel/ScreenButton.text = ">> <<"
		bInfoText = false;
	
	#$Panel/ScreenButton/InfoTimer.start(infoTimeCooldown);
	pass # Replace with function body.


func _on_screen_button_pressed() -> void:
	clickCounter += 1;
	
	pass # Replace with function body.

func _set_texto():
	texto.resize(42);
	texto[0] = "Ruido Negro"
	texto[1] = "[FX] Sonido de alarma de guerra nuclear en fade in hasta volverse muy fuerte (Escala de audio 8/10)"
	texto[2] = "[FX] Estática en fade in hasta volverse muy fuerte (8/10) - Reemplaza al sonido de la alarma - La alarma en fade out"
	texto[3] = "[FX] Disminuye el volumen de Estática (4/10) - Se mantiene de fondo"
	texto[4] = "[Voz - Actor 1 - Intención formal tipo noticiero] Se han confirmado ataques en decenas de ciudades alrededor del mundo por objetos de origen desconocido que han aparecido desde hace algunas semanas"
	texto[5] = "[FX] Fade out del sonido de la estática"
	texto[6] = "[FX] Sonido de pasos corriendo (2 personas) - Duración 5 segundos - Se detiene"
	texto[7] = "[Voz - Actriz 1 - Tono Angustia/Preocupación] “Debemos seguir corriendo, ya estamos cerca del refugio. ¿Viste sus armas? Son como burbujas de sonido. Esas cosas atacan con una especie de arma hecha de sonido, tenemos que ponernos a salvo. Presiona la pantalla para seguir corriendo”."
	texto[8] = "Ah maldita sea, tus piernas están fallando, pica la pantalla en tu celular para mandar la señal a tus piernas, date prisa."
	texto[9] = ""
	texto[10] = "- Si el jugador presiona la pantalla, entonces se escuchará el sonido de las pisadas, de lo contrario sólo se escuchará el sonido de la respiración agitada de una persona."
	texto[11] = ""
	texto[12] = "- Si el jugador no presiona la pantalla, a los 5 segundos entonces se escuchará el audio “¿Qué esperas? Presiona la pantalla para que podamos correr y llegar al refugio”."
	texto[13] = "[FX] Sonido de pisadas corriendo - Duración: 7 segundos"
	texto[14] = "[FX] Sonido de alguien tropezando [Si los pasos no son acompasados, o son muy rápidos y frenéticos, caerá]"
	texto[15] = "[Voz - Actriz 1 - Intención Desesperación] “¡Noooo! ¡Levántate por favor! ¡El refugio está cerca! ]La gente que viene detrás de nosotros se quedará con todos los lugares y no podremos entrar!"
	texto[16] = "[FX Sonido de muchedumbre acercándose]"
	texto[17] = ""
	texto[18] = "- Si el jugador presiona la pantalla, entonces se escuchará el sonido de esfuerzo para levantarse."
	texto[19] = ""
	texto[20] = "- Si pasan más de 3 segundos y no puede levantarse (12 clicks en 3 segundos)"
	texto[21] = "[Voz - Actriz 1 - Intención Desesperación] ¡¡¡Por favor!!! ¡¡¡Levántate!!! ¡¡¡No quiero abandonarte!!! ¡¡¡Presiona la pantalla rápidovarias veces para que te pongas de pie!!!¡¡¡Presiona la pantalla rápidovarias veces para que te pongas de pie!!!"
	texto[22] = ""
	texto[23] = "- Reinicia el contador"
	texto[24] = ""
	texto[25] = "[FX Sonido de la muchedumbre aún más intenso - Volumen 7/10 - Duración 4 segundos]"
	texto[26] = "[FX - Todos los sonidos se detienen - Se escucha un zumbido de baja frecuencia - Volumen 5/10]"
	texto[27] = "[FX - Latido de un corazón - Volumen 3/10 - Se mantiene en loop junto con el zumbido]"
	texto[28] = "[Voz - Actriz 1 - Intención Curiosidad/Miedo - Voz amortiguada como si estuviera hablando a través de una pared] Tartamudeo Allá, sobre ese edificio ¿Qué es eso? ¡¡¡Está flotando!!! ¡¡¡Ya!!! ¡¡¡Presiona la pantalla para que te puedas levantaaaaaaar!!!"
	texto[29] = ""
	texto[30] = "Si el usuario no presiona la pantalla"
	texto[31] = ""
	texto[32] = "[FX - Se mantienen todos los efectos anteriores]"
	texto[33] = "[Voz - Actriz 1 - Intención Miedo/Desesperación] ¡¡¡Por favor levántate!!! ¡¡¡Esa cosa está empezando a brillar!!! ¡¡¡Va a hacer algo!!!"
	texto[34] = "[Repetir cada 4 segundos hasta que el usuario presione la pantalla]"
	texto[35] = ""
	texto[36] = "Si el usuario presiona la pantalla"
	texto[37] = ""
	texto[38] = "[Voz - Actriz 1 - Intención Pánico] - ¡¡¡¿¿¿QUÉ ES ESO???!!! ¡¡¡ESE DESTELLO!!! ¡¡¡NO PUEDO VEEEEEER!!!"
	texto[39] = "[FX - Sonido de succión - Silencio por 3 segundos - Estallido al menos 5 segundos]"
	texto[40] = ""
	texto[41] = "FIN"
	
	pass


func _on_text_timer_timeout() -> void:
	$Panel/HistoriaRichTextLabel.text = texto[textCounter];
	textCounter += 1;
	pass # Replace with function body.

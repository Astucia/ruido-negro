extends Node2D

var infoTimeCooldown = 1.0;
var bInfoText = false;
var clickCounter = 0;
var textCounter = 0;
@export var AudioTracks: Array[AudioStream];
@export var HintsSystemAudioTracks: Array[AudioStream];
@export var SystemActionsAudioTracks: Array[AudioStream];
@export var Scenes: Array[PackedScene];

enum EMenuStatus {
	MenuInactive,
	MenuActionActive,
	UpperMenuActive,
	LowerMenuActive,
	LeftMenuActive,
	RightMenuActive,
	CentralMenuActive,
}
enum EAction {
	NOONE,
	EXIT,
	PLAY,
	CONTINUE,
	LEFT_ACTION,
	RIGHT_ACTION,
	BACKWARD,
	FOWARD,
	PAUSE,
	STOP,
	FFOWARD,
	FBACKWARD,
	SKIP,
	MENU,
	MECANICA
}
enum ESideHint{
	LEFT,
	RIGHT,
}
enum EAudioStatus{
	IDLE,
	PLAYING,
	WAITING,
	FINISH,
}

var MenuStatus = EMenuStatus.MenuInactive;
var SystemAction = EAction.NOONE;
var IsMouseExit = true;
var IsMouseDown = false;
var MouseLastPosition = Vector2();
var MouseNewPosition = Vector2();
var PressedTimer = 0.0;
var ActionDelta = 0.0;

var AudioActualPosition = 0;
var StoryArray;
var HintIzq;
var HintDer;
var AudioStatus = EAudioStatus.IDLE;
var ShowHints = false;


var texto: Array[String] = [];
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_set_texto();
	$Panel/ImagesPanel/GloboNeutro/MessageLabel.text = texto[textCounter];
	StoryArray = $obj_JSON_Manager._get_json_info();
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
	
	if(AudioStatus != EAudioStatus.IDLE && SystemAction != EAction.NOONE):
		return;
		
	_play_next_dialog();
	
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
	_play_next_dialog();
		
	pass # Replace with function body.
	
func _play_next_dialog():
	
	_read_audio_script();
	#$Panel/ImagesPanel/GloboNeutro/MessageLabel.text = texto[textCounter];
	#textCounter += 1;
	AudioActualPosition += 1;
	
	if(AudioActualPosition >= StoryArray.size()):
		AudioStatus = EAudioStatus.FINISH;
		AudioActualPosition = 0;
	
	if(textCounter >= texto.size()):
		textCounter = 0;
	pass


func _get_audio(IsHint: bool, nombre: String):
	if(IsHint):
		for itm in HintsSystemAudioTracks:
			if(itm.resource_path.contains(nombre)):
				return itm;
	else:
		for itm in AudioTracks:
			if(itm.resource_path.contains(nombre)):
				return itm;
				
	return null;
	pass
	
func _get_story_itm_by_id(_id: int):
	for itm in StoryArray:
		if(itm.get("ID") == _id):
			print(itm);
			return itm;
			
	return null;
	pass
	
func _read_audio_script():

	var itm = _get_story_itm_by_id(AudioActualPosition);
	print(itm);	
	
	var itmID = itm.get("ID");
	var itmTipo = itm.get("Tipo");
	var itmSalto = itm.get("Salto");
	var itmDuracion = itm.get("Duracion");
	var itmTexto = itm.get("Texto");
	var itmArchivo = itm.get("Archivo");
	var itmGlobo = itm.get("Globo");
	var itmImagen = itm.get("Imagen");
	
	if(itmTipo != null):
		match itmTipo:
			"MECANICA":
				_mecanica_pasos();
			_:
				$Panel/ImagesPanel/GloboNeutro/MessageLabel.text = itm.get("Texto");
				
				if(itmDuracion != null):
					$TextTimer.wait_time = itmDuracion; #float(itm.get("Duracion"));
					$TextTimer.start();
					#AudioStatus = EAudioStatus.PLAYING;
				
				if(itmArchivo != null):
					$GeneralAudioStreamPlayer.stream = _get_audio(false,itmArchivo);
					$GeneralAudioStreamPlayer.play(0.0);
					AudioStatus = EAudioStatus.PLAYING;
					
	pass

func _set_hints(master_element: Dictionary):
	var elementIzq;
	var elementDer;
	
	for itm in StoryArray:
		if(itm.get("ID") == master_element.get("ID_Destino_Izq")):
			HintIzq = itm;
			if(itm.get("Archivo") != null):
				elementIzq = itm.get("Archivo");
				$LeftAudioStreamPlayer2D.stream = _get_audio(true,elementIzq);			
			break;
			
	for itm in StoryArray:
		if(itm.get("ID") == master_element.get("ID_Destino_Der")):
			HintDer = itm;
			if(itm.get("Archivo") != null):
				elementDer = itm.get("Archivo");
				$RightAudioStreamPlayer2D.stream = _get_audio(true,elementDer);
			break;
					
	#$RightAudioStreamPlayer2D.stream = _get_audio(true,element.get("Archivo"));
	#Set_GUI_Options_Text.emit(HintIzq.get("Dialogo_Sonido"),HintDer.get("Dialogo_Sonido"));
	pass

func _get_next_scene(itm: Dictionary):
	
	for _scene in Scenes:
		var scene_name = _scene.resource_name;
		if(_scene.resource_path.contains(itm.get("Pasaje"))):
			get_tree().change_scene_to_packed(_scene);
			break;
	print("Escena no encontrada");
	pass;


func _on_general_audio_stream_player_finished() -> void:
	
	if(AudioStatus == EAudioStatus.PLAYING):
		AudioStatus = EAudioStatus.IDLE;
		#_read_audio_script();
		return;
	
	pass # Replace with function body.

func _mecanica_pasos():
	SystemAction = EAction.MECANICA;
	pass

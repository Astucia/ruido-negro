extends Node

@export_file("*.json") var JSON_Asset;
var json_string;

func _ready() -> void:
	json_string = _get_json_info();
	_get_choices();
	pass;

func _get_json_info(): 
	if(FileAccess.file_exists(JSON_Asset)):
		var dataFile = FileAccess.open(JSON_Asset,FileAccess.READ);
		var parseResult = JSON.parse_string(dataFile.get_as_text());
		
		if(parseResult is Array):
			print(parseResult);
			return	parseResult[0];
		else:
			print("Error reading file.");
			
	else:
		print("File not exist.");
		
	return "";
	pass;
	
func _get_choices():
	var lstChoicesL = Array();
	var lstChoicesR = Array();
	var lstDialoges = Array();
	
	for Itm in json_string:
		if(Itm is Dictionary):
			if(Itm["EsDecision"] == true):
				if(Itm["ID_Destino_Izq"] != null):
					lstChoicesL.append({"ID":Itm["ID"],"Archivo":Itm["Archivo"],"Destino":Itm["ID_Destino_Izq"]});
				else:
					if(Itm["ID_Destino_Der"] != null):
						lstChoicesR.append({"ID":Itm["ID"],"Archivo":Itm["Archivo"],"Destino":Itm["ID_Destino_Der"]});
			else:
				lstDialoges.append(Itm);
	pass

 

function ResumeGame() {
	myState = PlayerState.moving;
	image_speed = 1;
	//Destroy the sequences
	for(var i = 0; i < array_length(gameMenu); ++i) {
		layer_sequence_destroy(gameMenu[i,1]);
	}
	//Destroy the leftover objects
	instance_destroy(objMenuCircle);
	instance_destroy(objMenuBox);
}

//Saving and Loading Data
#macro FileName "GameData.sav"
#macro PlayerX "XPosition"
#macro PlayerY "YPosition"

function SaveGame() {
	var data = ds_map_create();
	ds_map_replace(data, PlayerX, objPlayer.x);
	ds_map_replace(data, PlayerY, objPlayer.y);
	
	var dataToSave = ds_map_write(data);
	var file = file_text_open_write(FileName);
	file_text_write_string(file, dataToSave);
	file_text_close(file);
	
	ds_map_destroy(data);
	
	ShowMessage("Game Saved.");
}

function LoadGame() {
	var file = file_text_open_read(FileName);
	//No file found
	if (file == -1) {
		ShowMessage("No saved game file found.");
		return;
	}
	//Read the file
	var fileData = file_text_read_string(file);
	file_text_close(file);
	
	//Load a DS map with that data
	var data = ds_map_create();
	ds_map_read(data, fileData);
	
	//Apply values from save file
	objPlayer.x = ds_map_find_value(data, PlayerX);
	objPlayer.y = ds_map_find_value(data, PlayerY);
	
	//Takes care of cleanup and everything
	ResumeGame();
}

function QuitGame() {
	SaveGame();
	game_end();
}
/// @description Dialogue Variables
myMessage = undefined;
currentText = "";
textIndex = 0;
audio_play_sound(sndMessageBox, 1, false);
draw_set_font(fntMessageBox);
width = sprite_width - 16;
lineSeperation = string_height("Aby");
messageSpeed = 0.5;

function ButtonPressed() {
	if (currentText == myMessage) {
		instance_destroy();
	}
	else {
		textIndex += 1000;
	}
}
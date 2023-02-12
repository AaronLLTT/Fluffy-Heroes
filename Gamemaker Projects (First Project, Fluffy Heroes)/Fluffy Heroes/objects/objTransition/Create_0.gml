/// @description Data for moving between rooms
rightFade = 0;
leftFade = 0;
fadeSpeed = 6;
newRoom = undefined;
newX = undefined;
newY = undefined;
oldRoom = room;

//Pick a random color
var r = random(255);
var g = random(255);
var b = random(255);

draw_set_color(make_color_rgb(r, g, b));
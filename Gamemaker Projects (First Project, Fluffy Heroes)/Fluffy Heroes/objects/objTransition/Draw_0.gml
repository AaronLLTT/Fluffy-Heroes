/// @description Draw Swipes and Change Rooms
if (room == oldRoom) {
	draw_rectangle(CameraX(), CameraY(), CameraX() + rightFade, CameraBottomY(), false);
	rightFade += fadeSpeed;
	if (rightFade > camera_get_view_width(view_camera[0])) {
		room_goto(newRoom);
	}
}
else {
	//Move the player
	objPlayer.x = newX;
	objPlayer.y = newY;
	draw_rectangle(CameraX() + leftFade, CameraY(), CameraRightX(), CameraBottomY(), false);
	leftFade += fadeSpeed;
	if (leftFade > camera_get_view_width(view_camera[0])) {
		instance_destroy();
	}
}
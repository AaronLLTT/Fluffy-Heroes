/// @description Return the x position of the camera for this player
function CameraX() {

	return camera_get_view_x(view_camera[0]);
	
}

/// @description Return the y position of the camera for this player
function CameraY() {

	return camera_get_view_y(view_camera[0]);

}

/// @description Return the middle x position of the camera for this player
function CameraMiddleX() {

	return CameraX() + camera_get_view_width(view_camera[0]) / 2;

}

/// @description Return the middle y position of the camera for this player
function CameraMiddleY() {

	return CameraY() + camera_get_view_height(view_camera[0]) / 2;

}

/// @description Return the far right x position for this camera
function CameraRightX() {
	
	return CameraX() + camera_get_view_width(view_camera[0]);
	
}

function CameraBottomY() {
	
	return CameraY() + camera_get_view_height(view_camera[0]);
	
}
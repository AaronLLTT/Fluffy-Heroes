/// @description Smooth Follow

//Get at where the camera is
var cameraX = CameraX();
var cameraY = CameraY();

//Get at where the camera needs to go
var targetX = objPlayer.x - (CameraWidth / 2);
var targetY = objPlayer.y - (CameraHeight / 2);

//Clamp the possible values, keep camera in room
targetX = clamp(targetX, 0, room_width - CameraWidth);
targetY = clamp(targetY, 0, room_height - CameraHeight);

//Get how much to move
cameraX = lerp(cameraX, targetX, CameraSpeed);
cameraY = lerp(cameraY, targetY, CameraSpeed);

//Move the camera
camera_set_view_pos(view_camera[0], cameraX, cameraY);
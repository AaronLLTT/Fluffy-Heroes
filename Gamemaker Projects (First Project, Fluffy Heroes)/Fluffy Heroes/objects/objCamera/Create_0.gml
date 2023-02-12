/// @description Camera Details

window_set_fullscreen(true);

#macro CameraWidth 256
#macro CameraHeight 144
#macro CameraSpeed 0.1

//Enable the views in the room
view_visible[0] = true;
view_enabled[0] = true;

var myCamera = camera_create_view(0, 0, CameraWidth, CameraHeight);

view_set_camera(0, myCamera);
/// @description Enable the camera in every room
//Enable the views in the room
view_visible[0] = true;
view_enabled[0] = true;

var myCamera = camera_create_view(0, 0, CameraWidth, CameraHeight);

view_set_camera(0, myCamera);
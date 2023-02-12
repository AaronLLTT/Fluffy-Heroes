function ShowMessage(message) {
	var messageBox = instance_create_depth(CameraMiddleX(), CameraMiddleY(), depth - 100, objMessageBox);
	messageBox.myMessage = message;
}
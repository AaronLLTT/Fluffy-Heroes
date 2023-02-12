function ChangeRooms(newRoom, newX, newY){
	var transition = instance_create_depth(x, y, depth - 100, objTransition);
	transition.newRoom = newRoom;
	transition.newX = newX;
	transition.newY = newY;
}
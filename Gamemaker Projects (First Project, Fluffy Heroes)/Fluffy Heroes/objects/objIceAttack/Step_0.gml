/// @description Fly and Die
++currentLife;
//Collide or run out of time
if (place_meeting(x, y, objSolidParent) || currentLife >= maxLife) {
	instance_destroy();
}
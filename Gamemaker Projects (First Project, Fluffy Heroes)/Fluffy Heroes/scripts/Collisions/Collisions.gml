function CollideWith(){
	//Vertical Collisions
	if (place_meeting(x, y + ySpeed, objSolidParent) == true) {
		while (place_meeting(x, y + sign(ySpeed), objSolidParent) == false) {
			y += sign(ySpeed);
		}
		ySpeed = 0;
	}

	//Horizontal Collisions
	if (place_meeting(x + xSpeed, y, objSolidParent) == true) {
		while (place_meeting(x + sign(xSpeed), y, objSolidParent) == false) {
			x += sign(xSpeed);
		}
		xSpeed = 0;
	}

	//Diagonal Collisions
	if (place_meeting(x + xSpeed, y + ySpeed, objSolidParent) == true) {
		while (place_meeting(x + sign(xSpeed), y + sign(ySpeed), objSolidParent) == false) {
			x += sign(xSpeed);
			y += sign(ySpeed);
		}
		xSpeed = 0;
		ySpeed = 0;
	}
}

function BounceBack(damageSource) {
	var position = point_direction(x, y, damageSource.x, damageSource.y);
	if (position >= 90 && position <= 270) {
		xSpeed = walkSpeed;
	}
	else {
		xSpeed = -walkSpeed;
	}
	ySpeed = jumpSpeed;
}

function DamageCollisions() {
	//Gravity
	if(!place_meeting(x, y + 1, objSolidParent)) {
		ySpeed += gameGravity;
	}
	//Vertical Collisions
	if (place_meeting(x, y + ySpeed, objSolidParent) == true) {
		while (place_meeting(x, y + sign(ySpeed), objSolidParent) == false) {
			y += sign(ySpeed);
		}
		ySpeed = 0;
	}

	//Horizontal Collisions
	if (place_meeting(x + xSpeed, y, objSolidParent) == true) {
		while (place_meeting(x + sign(xSpeed), y, objSolidParent) == false) {
			x += sign(xSpeed);
		}
		xSpeed *= -.1;
	}

	//Diagonal Collisions
	if (place_meeting(x + xSpeed, y + ySpeed, objSolidParent) == true) {
		while (place_meeting(x + sign(xSpeed), y + sign(ySpeed), objSolidParent) == false) {
			x += sign(xSpeed);
			y += sign(ySpeed);
		}
		xSpeed *= -.1;
		ySpeed = 0;
	}
	
	xSpeed -= xSpeed / 100;
	
	x += xSpeed;
	y += ySpeed;
}
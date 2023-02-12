/// @description Biter's Logic

//Locates nearest solid and gets set there
if (place_meeting(x, y + 1, objSolidParent) == false && myState == EnemyState.idle) {
	var ground = instance_nearest(x, y, objSolidParent);
	x = ground.x;
	y = ground.y - ground.sprite_height / 2 - sprite_height / 2;
}

var atLedge = place_meeting(x + sign(xSpeed) + sprite_width / 2, y + 1, objSolidParent) == false; 
var atSolid = place_meeting(x + sign(xSpeed) * 6, y, objSolidParent) == true;

//Getting Hurt
if (place_meeting(x, y, objIceAttack)) {
	myState = EnemyState.damaged;
	sprite_index = sprBiterHurt;
	image_index = 0;
	instance_destroy(objIceAttack);
	--currentHealth;
}

switch (myState) {
	#region Idle State
	case EnemyState.idle:
		//Reduce timer to change to walking state
		idleTimer -= 1;
		if (idleTimer <= 0) {
			randomize()
			xSpeed = moveSpeed * choose(1, -1);
			myState = EnemyState.walking;
			sprite_index = sprBiterWalk;
			image_xscale = xSpeed + (sign(xSpeed) * 0.25);
			walkTimer = random_range(100, 200);
		}
	break;
	#endregion
	#region Walking State
	case EnemyState.walking:
		//Reduce timer to return to idle state
		walkTimer -= 1;
		if (walkTimer <= 0) {
			myState = EnemyState.idle;
			sprite_index = sprBiterIdle;
			idleTimer = 90;
		}
		
		//Reverse direction when at a ledge or a solid
		if (atLedge || atSolid) {
			xSpeed *= -1;
			image_xscale *= -1;
		}
		
		var canSeePlayer = collision_line(x, y, x + (image_xscale * 60), y, objPlayer, false, true) != noone;
		if (canSeePlayer) {
			myState = EnemyState.charging;
			xSpeed *= 2;
		}
		x += xSpeed;
	break;
	#endregion
	#region Charging State
	case EnemyState.charging:
		if (distance_to_object(objPlayer) <= attackRadius) {
			xSpeed = 0;
			sprite_index = sprBiterAttack;
			image_index = 0;
			myState = EnemyState.attacking;
		}
		if (distance_to_object(objPlayer) > chargeRadius || atLedge || atSolid) {
			myState = EnemyState.walking;
			image_index = 0;
			if (atLedge || atSolid) {
				image_xscale *= -1;
			}
			xSpeed = moveSpeed * image_xscale;
		}
		x += xSpeed;
	break;
	#endregion
	#region Attacking State
	case EnemyState.attacking:
		if (image_index >= image_number) {
			myState = EnemyState.walking;
			image_xscale *= -1;
			xSpeed = moveSpeed * image_xscale;
			image_index = 0;
			sprite_index = sprBiterWalk;
		}
	break;
	#endregion
	#region Damaged State
	case EnemyState.damaged:
		if (currentHealth > 0) {
			if (image_index >= image_number - 1) {
				image_index = 0;
				sprite_index = sprBiterIdle;
				myState = EnemyState.idle;
			}
		}
		else {
			sprite_index = sprBiterExplode;
			image_index = 0;
			myState = EnemyState.dead;
			image_xscale = .5;
			image_yscale = .5;
			y += 5;
			audio_play_sound(sndBiterDeath, 1, false);
		}
	break;
	#endregion
	#region Dead State
	case EnemyState.dead:
		if (image_index >= image_number) {
			instance_destroy();
		}
	break;
	#endregion
}
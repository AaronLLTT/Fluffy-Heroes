/// @description Player Logic

#region Keyboard Input
var left = keyboard_check(vk_left);
var right = keyboard_check(vk_right);
var run = keyboard_check(vk_shift);
var attack = mouse_check_button(mb_left);
#endregion

var onSolid = place_meeting(x, y + 1, objSolidParent) == true;
var gettingHurt = place_meeting(x, y, objEnemyParent) == true;
var isIdle = onSolid && (xSpeed == 0 && ySpeed == 0);

switch(myState) {
	#region Moving State
	case PlayerState.moving:
		#region Walking && Running
		if (left) {
			if (onSolid) {
				sprite_index = sprites[hero][Walk];
			}
			image_xscale = -1;
			xSpeed = -walkSpeed;
		}
		if (right) {
			if (onSolid) {
				sprite_index = sprites[hero][Walk];
			}
			image_xscale = 1;
			xSpeed = walkSpeed;
		}

		//Sprinting
		if (run) {
			image_speed = 1.5;
			if (left) {
				xSpeed = -walkSpeed * 2;
			}
			if (right) {
				xSpeed = walkSpeed * 2;
			}
		}
		if (keyboard_check_released(vk_shift)) {
			image_speed = 1;
		}
		if (!left && !right) {
			if (onSolid) {
				sprite_index = sprites[hero][Idle];
			}
			xSpeed = 0;
			alarm[0] = 1;
		}
		#endregion

		#region Checking if player is on the ground
		if (onSolid) {
			y = round(y); //Prevents hovering or dipping into a solid
			ySpeed = 0;
			jumpBuffer = maxJumpBuffer;
		}
		else { //Applying gravity while player is in the air
			ySpeed += gameGravity;
			jumpBuffer -= 1;
			//Sets the jump sprite when jumping or falling
			if (ySpeed > 0) {
				image_index = 1;
		}
			else {
				image_index = 0;
			}
		}

		if (keyboard_check_pressed(vk_space) && jumpBuffer > 0) {
			image_index = 0;
			sprite_index = sprites[hero][Jump];
			ySpeed = jumpSpeed * jumpPower;
			jumpBuffer = 0;
		}

		#endregion

		#region Rock Collisions
		var rock = instance_nearest(x, y, objRock);

		//Pushing The Rock
		if (place_meeting(x + xSpeed, y, objRock) && (left || right)) {
			rock.xSpeed = sign(xSpeed) / 2;
			sprite_index = sprites[hero][Push];
			xSpeed = sign(xSpeed) / 2;
			rock.angle -= sign(xSpeed);
		}
		else {
			if (rock != noone) {
				rock.xSpeed = 0;
			}
		}

		CollideWith();

		//Pull The Rock
		if (place_meeting(x + (6 * -image_xscale), y, objRock) && keyboard_check(vk_tab)) {
			sprite_index = sprites[hero][Push];
			if (left || right) {
				xSpeed = sign(xSpeed) / 2;
				rock.xSpeed = sign(xSpeed) / 2;
				rock.angle -= sign(xSpeed);
			}
			if (left) {
				image_xscale = 1;
			}
			else if (right) {
				image_xscale = -1;
			}
			//Prevent weird warping when pulling rock when it's up against a wall
			if (place_meeting(x, y, objRock)) {
				x += sign(xSpeed);
			}
		}

		#endregion

		CollideWith();
		
		/*INTO AND OUT OF MOVE STATE*/
		if (gettingHurt) {
			currentHealth -= 1;
			audio_play_sound(sndHurt, 10, false);
			if (currentHealth > 0) {
				myState = PlayerState.damaged;
				var damageSource = instance_place(x, y, objEnemyParent);
				BounceBack(damageSource);
				sprite_index = sprites[hero][Hurt];
			}
			else {
				myState = PlayerState.dead;
				sprite_index = sprites[hero][Dead];
				image_index = 0;
				var gameOver = audio_play_sound(sndGameOverMusic, 100, false);
				audio_sound_set_track_position(gameOver, 4);
			}
		}
		
		//Attacking
		if (attack) {
			myState = PlayerState.attacking;
			if (onSolid) {
				xSpeed = 0;
			}
			sprite_index = sprites[hero][Attack];
			image_index = 0;
			var iceAttack = instance_create_depth(x + image_xscale * 15, y + 5, depth - 1, objIceAttack);
			if (image_xscale == 1) {
				iceAttack.direction = 0;
			}
			else {
				iceAttack.direction = 180;
			}
			iceAttack.image_angle = iceAttack.direction;
		}
		
		//Dialogue
		if (instance_exists(objMessageBox)) {
			myState = PlayerState.dialogue;
			image_speed = 0;
		}
		
		//In-Game Menu
		if (isIdle && keyboard_check(vk_escape)) {
			myState = PlayerState.gameMenu;
			image_speed = 0;
			//Create the sequences, assign their image, text, and script
			for(var i = 0; i < array_length(gameMenu); ++i) {
				
				//Create the sequence, pause it, and save the sequence struct in a local variable
				gameMenu[i,1] = layer_sequence_create("Instances", CameraMiddleX(), CameraY() + 20 + i * 35, seqMenuAnimation);
				layer_sequence_pause(gameMenu[i,1]);
				var seqStruct = layer_sequence_get_instance(gameMenu[i,1]);
				
				//Create the circle part of the menu and assign its specific data
				var circle = instance_create_depth(-100, -100, depth - 1, objMenuCircle);
				circle.sprite_index = gameMenu[i,3]
				sequence_instance_override_object(seqStruct, objMenuCircle, circle);
				
				//Create the box and assign its text
				var box = instance_create_depth(-100, -100, depth - 1, objMenuBox);
				box.myText = gameMenu[i,0];
				sequence_instance_override_object(seqStruct, objMenuBox, box);
			}
			//Play the first menu option
			layer_sequence_play(gameMenu[0,1]);
		}
		
		//Changing Rooms
		if (place_meeting(x, y, objWarp)) {
			myState = PlayerState.changingRooms;
			sprite_index = sprites[hero][Idle];
			image_speed = 1;
			xSpeed = 0;
			ySpeed = 0;
			
			var warp = instance_place(x, y, objWarp);
			ChangeRooms(warp.newRoom, warp.newX, warp.newY);
		}
		
		x += xSpeed;
		y += ySpeed;
	break;
	#endregion
	#region Attacking State
	case PlayerState.attacking:
		if (image_index >= image_number - 1) {
			image_index = 0;
			sprite_index = sprites[hero][Idle];
			myState = PlayerState.moving;
		}
		//Control Movement & Falling
		if (onSolid == false) {
			ySpeed += gameGravity;
			jumpBuffer -= 1;
		}
		else {
			ySpeed = 0;
			jumpBuffer = maxJumpBuffer;
		}
		
		CollideWith();
		
		x += xSpeed;
		y += ySpeed;
	break;
	#endregion
	#region Damaged State
	case PlayerState.damaged:
		if (onSolid) {
			myState = PlayerState.moving;
			xSpeed = 0;
		}
		else if(gettingHurt) {
			BounceBack(instance_place(x, y, objEnemyParent));
		}
		DamageCollisions();
	break;
	#endregion
	#region Dead State
	case PlayerState.dead:
		if (image_index >= image_number) {
			image_speed = 0;
		}
		if (audio_is_playing(sndGameOverMusic) == false) {
			game_restart();
		}
	break;
	#endregion
	#region Dialogue State
	case PlayerState.dialogue:
		//Return to walking when message box is no more
		if (instance_exists(objMessageBox) == false) {
			myState = PlayerState.moving;
			image_speed = 1;
		}
		//Speed up or destroy message box
		if (keyboard_check_pressed(vk_anykey) || mouse_check_button_pressed(mb_any)) {
			objMessageBox.ButtonPressed();
		}
	break;
	#endregion
	#region Changing Rooms State
	case PlayerState.changingRooms:
		if (instance_exists(objTransition) == false) {
			myState = PlayerState.moving;
		}
	break;
	#endregion
	#region Main Menu State
	case PlayerState.mainMenu:
	
	break;
	#endregion
	#region Game Menu State
	case PlayerState.gameMenu:
		//Destroy the confirm boxes that appear when saving and loading
		if (instance_exists(objMessageBox)) {
			if (keyboard_check_pressed(vk_anykey)) {
				with(objMessageBox) {
					event_perform(ev_other, ev_user0);
				}
			}
		}
		else {
			//Move down the menu
			if (keyboard_check_pressed(vk_down)) {
				//Play the sequence in reverse of our current menu item
				layer_sequence_headdir(gameMenu[menuChoice,1], seqdir_left);
				layer_sequence_play(gameMenu[menuChoice,1]);
			
				++menuChoice;
				if (menuChoice >= array_length(gameMenu)) {
					menuChoice = 0;
				}
			
				//Set the direction of the new item to normal and play
				layer_sequence_headdir(gameMenu[menuChoice,1], seqdir_right);
				layer_sequence_play(gameMenu[menuChoice,1]);
			}
			//Move up the menu
			if (keyboard_check_pressed(vk_space)) { //This must be space because we've mapped vk_up to space
				//Play the sequence in reverse of our current menu item
				layer_sequence_headdir(gameMenu[menuChoice,1], seqdir_left);
				layer_sequence_play(gameMenu[menuChoice,1]);
			
				--menuChoice;
				if (menuChoice < 0) {
					menuChoice = array_length(gameMenu) - 1;
				}
			
				//Set the direction of the new item to normal and play
				layer_sequence_headdir(gameMenu[menuChoice,1], seqdir_right);
				layer_sequence_play(gameMenu[menuChoice,1]);	
			}
			//Run a function
			if (keyboard_check_pressed(vk_enter)) {
				gameMenu[menuChoice,2]();
			}
		}
	break;
	#endregion
}
#region Change Heroes
if (keyboard_check(ord("1"))) {
	hero = 0;
}
else if (keyboard_check(ord("2"))) {
	hero = 1;
}
else if (keyboard_check(ord("3"))) {
	hero = 2;
}
#endregion
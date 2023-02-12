/// @description Pinky's Data
xSpeed = 0;
walkSpeed = 2;
gameGravity = 0.25;
jumpSpeed = -4;
ySpeed = 0;
maxJumpBuffer = 5;
jumpBuffer = maxJumpBuffer;
jumpPower = 1;
hero = 0;

maxHealth = 5;
currentHealth = maxHealth;

myState = PlayerState.moving;

#region Keyboard Customization
keyboard_set_map(vk_up, vk_space);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("W"), vk_space);
#endregion
#region Sprite Animation Array
sprites[Pinky][Walk] = sprPinkyWalk;
sprites[Pinky][Idle] = sprPinkyIdle;
sprites[Pinky][Push] = sprPinkyPush;
sprites[Pinky][Jump] = sprPinkyJump;
sprites[Pinky][Hurt] = sprPinkyHurt;
sprites[Pinky][Dead] = sprPinkyDeath;
sprites[Pinky][Attack] = sprPinkyAttack;

sprites[Dude][Walk] = sprDudeWalk;
sprites[Dude][Idle] = sprDudeIdle;
sprites[Dude][Push] = sprDudePush;
sprites[Dude][Jump] = sprDudeJump;
sprites[Dude][Hurt] = sprDudeHurt;
sprites[Dude][Dead] = sprDudeDeath;
sprites[Dude][Attack] = sprDudeAttack;

sprites[Owlet][Walk] = sprOwletWalk;
sprites[Owlet][Idle] = sprOwletIdle;
sprites[Owlet][Push] = sprOwletPush;
sprites[Owlet][Jump] = sprOwletJump; 
sprites[Owlet][Hurt] = sprOwletHurt;
sprites[Owlet][Dead] = sprOwletDeath;
sprites[Owlet][Attack] = sprOwletAttack;
#endregion

//Set the hearts to display at a good looking size
display_set_gui_size(256 * 2, 144 * 2);

//Menu data
menuChoice = 0;

//The string to be displayed
gameMenu[0,0] = "Resume";
gameMenu[1,0] = "Save";
gameMenu[2,0] = "Load";
gameMenu[3,0] = "Quit";
//Sequence ID, starts out undefined
gameMenu[0,1] = undefined;
gameMenu[1,1] = undefined;
gameMenu[2,1] = undefined;
gameMenu[3,1] = undefined;
//The script to execute
gameMenu[0,2] = ResumeGame;
gameMenu[1,2] = SaveGame;
gameMenu[2,2] = LoadGame;
gameMenu[3,2] = QuitGame;
//The sprite to display
gameMenu[0,3] = sprPlay;
gameMenu[1,3] = sprOptions;
gameMenu[2,3] = sprOptions;
gameMenu[3,3] = sprCancel;
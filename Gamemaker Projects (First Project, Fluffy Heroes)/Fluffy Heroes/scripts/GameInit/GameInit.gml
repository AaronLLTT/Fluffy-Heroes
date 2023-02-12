#macro Pinky 0
#macro Dude 1
#macro Owlet 2

#macro Walk 0
#macro Idle 1
#macro Push 2
#macro Jump 3
#macro Hurt 4
#macro Dead 5
#macro Attack 6

enum EnemyState {
	idle,
	walking,
	charging,
	attacking,
	damaged,
	dead
}

enum PlayerState {
	moving,
	attacking,
	damaged,
	dead,
	dialogue,
	changingRooms,
	mainMenu,
	gameMenu
}
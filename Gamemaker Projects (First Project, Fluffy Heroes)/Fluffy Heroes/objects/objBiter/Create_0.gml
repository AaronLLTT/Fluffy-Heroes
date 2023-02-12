/// @description Biter's Data
moveSpeed = .75;
xSpeed = 0;
idleTimer = 90;
walkTimer = random_range(100, 200);

myState = EnemyState.idle;

chargeRadius = 60;
attackRadius = 4;

maxHealth = 2;
currentHealth = maxHealth;
/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (c) 2008 Jesthony Maquiling [14 Aug]
   (c) 2011 Mj Mendoza IV [15 May]
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
 
Var:Create(
	Bullet, 
		Number x,
		Number y,
		Number imgR,
		Number imgL,
		Boolean used,
		Boolean faceRight
)
Array:New bullets[24]:Bullet;

Var:Create(
	Mummy, 
		Number x,
		Number y,
		Number img,
		Boolean alive,
		Number speed,
		Number state,
		Boolean faceRight
)
Array:New mummies[20]:Mummy;

Array:New WalkingR[13]:Number;
Array:New StandingR[8]:Number;
Array:New WalkingL[13]:Number;
Array:New StandingL[8]:Number;
Array:New JumpL[22]:Number;
Array:New JumpR[22]:Number;
Array:New CallL[24]:Number;
Array:New CallR[24]:Number;
Array:New ShootL[17]:Number;
Array:New SmokeL[17]:Number;
Array:New ShootR[17]:Number;
Array:New SmokeR[17]:Number;
Array:New RobotWalkL[17]:Number;
Array:New RobotWalkR[17]:Number;
Array:New RobotIdleL[5]:Number;
Array:New RobotIdleR[5]:Number;
Array:New RobotAttackL[12]:Number;
Array:New RobotAttackR[12]:Number;
Array:New MummiesR[18]:Number;
Array:New MummiesL[18]:Number;
Array:New AttackR[22]:Number;
Array:New AttackL[22]:Number;
Array:New Dead[19]:Number;
Array:New Burn[44]:Number;

Var:Number ctr, car, playerFaceRight = true, Displacement, playerMapX;
Var:Number i, tmp, shooting_range, Screen2, Points = 0, LogoEnd, LogoMain, BG;

Var:Boolean exit;
Var:Number bulletR;
Var:Number bulletL;

Var:Number tmpLvl;
Var:Number Level = 1;
Var:Number zombieAlive = 3;
Var:Number playerState = 0;

Var:Number robotState  = 0;
Var:Number robotMapX = 640;
Var:Number robotImg = 1;
Var:Number robotFaceRight = 0;

Var:Number STATE_IDLE   = 0;
Var:Number STATE_WALK   = 1;
Var:Number STATE_JUMP   = 2;
Var:Number STATE_ATTACK = 3;
Var:Number STATE_DIE    = 4;
Var:Number STATE_CALL   = 5;

//Var:Boolean Key_W;
Var:Boolean Key_A;
//Var:Boolean Key_S;
Var:Boolean Key_D;
Var:Boolean Key_C;

function initGFX() {
  Screen:Show()
	Image:New(1266, 443, Screen2)
	Image:Load("img\\Map\\BG.png", BG)
	Image:Load("img\\Map\\car.png", car)
	Image:Load("img\\menu\\LogoEnd.png", LogoEnd)
	Image:Load("img\\menu\\LogoMain.png", LogoMain)
	
	Image:Load("img\\bullet\\R.png", bulletR)
	Image:Load("img\\bullet\\L.png", bulletL)
	for (ctr = 1; ctr <= 24; ctr++) {
		bullets[ctr-1].imgR = bulletR;
		bullets[ctr-1].imgL = bulletL;
	}
	
	for (ctr = 1; ctr <= 22; ctr++) {
		Image:Load("img\\Mummy\\Attack\\R (" + ctr + ").png", tmp)
			AttackR[ctr - 1] = tmp;
		Image:Load("img\\Mummy\\Attack\\L (" + ctr + ").png", tmp)
			AttackL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <= 44; ctr++) {
		Image:Load("img\\Mummy\\Burn\\(" + ctr + ").png", tmp)
			Burn[ctr - 1] = tmp;
	}	
	for (ctr = 1; ctr <= 18; ctr++) {
		Image:Load("img\\Player\\Dies\\(" + ctr + ").png", tmp)
			Dead[ctr - 1] = tmp;
		
		Image:Load("img\\Mummy\\Walk\\R (" + ctr + ").png", tmp)
			MummiesR[ctr - 1] = tmp;
		Image:Load("img\\Mummy\\Walk\\L (" + ctr + ").png", tmp)
			MummiesL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <= 17; ctr++){
		Image:Load("img\\Robot\\Walk\\R (" + ctr + ").png", tmp)
			RobotWalkR[ctr - 1] = tmp;
		Image:Load("img\\Robot\\Walk\\L (" + ctr + ").png", tmp)
			RobotWalkL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <=  5; ctr++) {
		Image:Load("img\\Robot\\Idle\\R (" + ctr + ").png", tmp)
			RobotIdleR[ctr - 1] = tmp;
		Image:Load("img\\Robot\\Idle\\L (" + ctr + ").png", tmp)
			RobotIdleL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <=  12; ctr++) {
		Image:Load("img\\Robot\\Shoot\\R (" + ctr + ").png", tmp)
			RobotAttackR[ctr - 1] = tmp;
		Image:Load("img\\Robot\\Shoot\\L (" + ctr + ").png", tmp)
			RobotAttackL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <= 12; ctr++) {
		Image:Load("img\\Player\\Walk\\R (" + ctr + ").png", tmp)
			WalkingR[ctr - 1] = tmp;
		Image:Load("img\\Player\\Walk\\L (" + ctr + ").png", tmp)
			WalkingL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <=  7; ctr++) {
		Image:Load("img\\Player\\Idle\\R (" + ctr + ").png", tmp)
			StandingR[ctr - 1] = tmp;
		Image:Load("img\\Player\\Idle\\L (" + ctr + ").png", tmp)
			StandingL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <= 22; ctr++) {
		Image:Load("img\\Player\\Jump\\R (" + ctr + ").png", tmp)
			JumpR[ctr - 1] = tmp;
		Image:Load("img\\Player\\Jump\\L (" + ctr + ").png", tmp)
			JumpL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <= 24; ctr++) {
		Image:Load("img\\Player\\Call\\R (" + ctr + ").png", tmp)
			CallR[ctr - 1] = tmp;
		Image:Load("img\\Player\\Call\\L (" + ctr + ").png", tmp)
			CallL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <= 16; ctr++) {
		Image:Load("img\\Player\\Shoot\\R (" + ctr + ").png", tmp)
			ShootR[ctr - 1] = tmp;
		Image:Load("img\\Player\\Shoot\\L (" + ctr + ").png", tmp)
			ShootL[ctr - 1] = tmp;
		Image:Load("img\\Smoke\\R (" + ctr + ").png", tmp)
			SmokeR[ctr - 1] = tmp;
		Image:Load("img\\Smoke\\L (" + ctr + ").png", tmp)
			SmokeL[ctr - 1] = tmp;
	}
}

function initIO() {
//	Key:New("w", Key_W)
	Key:New("a", Key_A)
//	Key:New("s", Key_S)
	Key:New("d", Key_D)
	Key:New("c", Key_C)
}

function main() {
	initGFX()
	initIO()
	while (1 == 1) {
		ctr = 1;
		Points = 0;
		exit = false;
		playerMapX = 640;
		playerState = STATE_IDLE;
		robotState = STATE_IDLE;
		
		spawnMummy()
		
		B3 = false;
		while (B3 == false) {
			Screen:CLS()
				Image:TBlit(160, 20, LogoMain, screen)
				Screen:GoToXY(240, 350)
				Screen:PrintString("Press Enter To Play")
			Screen:Render()
		}
		
	//main loop
		while (exit == false) {
			Screen:CLS()
				Image:Blit(0, 0, BG, Screen2)
				Image:TBlit(50, 100, car, Screen2)
				RobotStateMachine()
				MummyStateMachine()
				
				PlayerStateMachine()
				
				RenderBullet()
				
				if ( (300 - playerMapX) > 0) {
					Image:Blit(0, 20, Screen2, screen)
				} else if (300 + playerMapX < 1266 - 48) { //48 is player-walk-image-width: see Player\Walk\L (1).png
					Image:Blit(300 - playerMapX, 20, Screen2, screen)
				} else {
					Image:Blit(600 - 1266 + 48, 20, Screen2, screen) //48 is player-walk-image-width: see Player\Walk\L (1).png
				}
				Screen:PrintString(Points)
			Screen:Render()
		}
	//main loop
	
		B3 = false;
		while (B3 == false) {
			Screen:CLS()
				Screen:GoToXY(10, 30)
				Screen:PrintString("Your Score is " + Points + "\n Thank You for playing. \n Please visit our website at \n http://www.konsolscript.org")
				Image:Blit(50, 100, LogoEnd, screen)
				Screen:GoToXY(80, 220)
				Screen:PrintString("Play Again? Press Enter")
			Screen:Render()
			if (B1 == true) {
				B1 = false;
				Konsol:Message("coded by Toto Maquiling\n      and Mj Mendoza IV", "Metal Slug Kuno")
				Konsol:Exit()
			}
		}
	}
}

function RobotStand() {
	robotImg++;
	if (robotImg >= 5) {
		robotImg = 0;
	}
	
	if (playerFaceRight == true) {
		robotFaceRight = true;
		Image:TBlit(robotMapX, 115, RobotIdleR[robotImg], Screen2)
	} else {
		robotFaceRight = false;
		Image:TBlit(robotMapX, 115, RobotIdleL[robotImg], Screen2)
	}
}

function RobotWalk() {
	robotImg++;
	if (robotImg >= 16) {
		robotImg = 0;
	}
	
	if (robotFaceRight == true) {
		Image:TBlit(robotMapX, 118, RobotWalkR[robotImg], Screen2)
		robotMapX += 3;
	} else {
		Image:TBlit(robotMapX, 118, RobotWalkL[robotImg], Screen2)
		robotMapX -= 3;
	}
}

function spawnBullet(Number p_faceRight) {
	bullets[bulletCtr].used = true;
	bullets[bulletCtr].x = robotMapX - 10;
	Math:Random(0, 5, tmp)
	bullets[bulletCtr].y = tmp;
	bullets[bulletCtr].faceRight = p_faceRight;
	bulletCtr++;
	if (bulletCtr >= 24) {
		bulletCtr = 0;
	}
}

function RobotAttack() {
	robotImg++;
	if (robotImg >= 11) {
		robotState = STATE_IDLE;
	}
	
	if (robotImg == 3) {
		spawnBullet(robotFaceRight)
	} else if (robotImg == 6) {
		spawnBullet(robotFaceRight)
	} else if (robotImg == 9) {
		spawnBullet(robotFaceRight)
	}
	
	if (robotFaceRight == true) {
		Image:TBlit(robotMapX + 2, 119, RobotAttackR[robotImg], Screen2)
	} else {
		Image:TBlit(robotMapX - 30, 119, RobotAttackL[robotImg], Screen2)
	}
}

function RobotStateMachine() {
	Displacement = playerMapX - robotMapX;
	if (Displacement < 0) {
		//negate value
		Displacement = Displacement * -1;
	}
	
	if (robotState == STATE_ATTACK) {
		RobotAttack()
	} else {
		if (3 >= Displacement) {
			robotState = STATE_IDLE;
		} else {
			robotState = STATE_WALK;
		}
		
		if (robotState == STATE_IDLE) {
			RobotStand()
		} else if (robotState == STATE_WALK) {
			RobotWalk()
		}
	}
}

function spawnMummy() {
	for (i = 0; i < 20; i++) {
		initMummy(i, 0)
	}
}

function initMummy(Number index, Number speeddemon) { 
	Math:Random(0, 1266, tmp)
	if (tmp > (playerMapX-100)) {
		if (tmp < (playerMapX + 100)) {
			if (tmp > playerMapX) {
				tmp += 200;
			} else {
				tmp -= 200;
			}
		}
	}
	
	mummies[index].x = tmp; 
	mummies[index].alive = true; 
	if (speeddemon == 0 ) {
		Math:Random(1, 2, tmp)
	} else {
		tmp = speeddemon + 0.1;
	}
	mummies[index].speed = tmp;
	Math:Random(1, 15, tmp)
	mummies[index].img = tmp;
	mummies[index].state = STATE_WALK;
}

function MummyStateMachine() {
	for (i = 0; i < zombieAlive; i++) {
		if (mummies[i].state == STATE_DIE) {
			MummyDie(i)
		} else {
			if (mummies[i].alive == true) {
				MummyAlive(i)
				Draw:RectFill(mummies[i].x, 140, 5, 5, 0xff0000, Screen2)
				if (playerFaceRight == true) {
					if (mummies[i].x < shooting_range) {
						if (mummies[i].x > (playerMapX + 20)) {
							if (playerState == STATE_ATTACK) {
								mummies[i].state = STATE_DIE;
							}
						}
					}
				} else {
					if (mummies[i].x > shooting_range) {
						if (mummies[i].x < playerMapX) {
							if (playerState == STATE_ATTACK) {	
								mummies[i].state = STATE_DIE;
							}
						}
					}
				}
			}
		}
	}
}

function MummyWalk(Number p_index) {
	if (mummies[p_index].img >= 18) {
		mummies[p_index].img = 1;
	}
	if (mummies[p_index].faceRight == true) {
		Image:TBlit(mummies[p_index].x, 137, MummiesR[mummies[p_index].img], Screen2)
		mummies[p_index].x = (mummies[p_index].x + mummies[p_index].speed);
	} else if (mummies[p_index].faceRight == false) {
		Image:TBlit(mummies[p_index].x, 137, MummiesL[mummies[p_index].img], Screen2)
		mummies[p_index].x = (mummies[p_index].x - mummies[p_index].speed);
	}
}

function MummyAttack(Number p_index) {
	if (mummies[p_index].img >= 22) {
		mummies[p_index].img = 1;
	}
	if (mummies[p_index].faceRight == true) {
		if (mummies[p_index].img == 11 ) {
			if (playerMapX >= (mummies[p_index].x + 30)) {
//				if (playerMapX <= (mummies[p_index].x + 10)) {
					MummyTryKillPlayer()
//				}
			}
		}
		Image:TBlit(mummies[p_index].x, 126, AttackR[mummies[p_index].img], Screen2)
//		Draw:RectFill(mummies[p_index].x, 126, (playerMapX - mummies[p_index].x), 5, 0xff0000, Screen2)
	} else {
		if (mummies[p_index].img == 11) {
			if (playerMapX >= (mummies[p_index].x - 30)) {
//				if (playerMapX <= mummies[p_index].x) {
					MummyTryKillPlayer()
//				}
			}
		}
		Image:TBlit(mummies[p_index].x - 50, 126, AttackL[mummies[p_index].img], Screen2)
//		Draw:RectFill(mummies[p_index].x, 126, (playerMapX - mummies[p_index].x), 5, 0x0000ff, Screen2)
	}
}

function MummyTryKillPlayer() {
	if (playerState != STATE_JUMP) {
		if (playerState != STATE_DIE) {
			playerState = STATE_DIE;
			ctr = 0;
		}
	}
}

function MummyAlive(Number p_index) {
	//determine direction
	if (playerMapX >= mummies[p_index].x + 5) {
		mummies[p_index].faceRight = true;
	} else if (playerMapX + 5 <= mummies[p_index].x) {
		mummies[p_index].faceRight = false;
	}
	
	//determine state
	if (playerMapX >= mummies[p_index].x + 50) {
		mummies[p_index].state = STATE_WALK;
	} else if (playerMapX + 50 <= mummies[p_index].x) {
		mummies[p_index].state = STATE_WALK;
	} else {
		mummies[p_index].state = STATE_ATTACK;
		//mummies[p_index].img = 0;
	}
	
	//do state
	mummies[p_index].img = mummies[p_index].img + 1;
	if (mummies[p_index].state == STATE_WALK) {
		MummyWalk(p_index)
	} else if (mummies[p_index].state == STATE_ATTACK) {
		MummyAttack(p_index)
	}
}

function MummyDie(Number p_index) {
	Image:TBlit(mummies[p_index].x - 8, 120, Burn[mummies[p_index].img], Screen2)
	
	Points = Points + mummies[p_index].speed;
	tmpLvl = Points / 1000;
	Math:Round(tmpLvl, 0, tmpLvl)
	Math:Round(Points, 0, Points)
	
	mummies[p_index].img = mummies[p_index].img + 1;
	if (mummies[p_index].img >= 44) {
		if (tmpLvl > Level) {
			Level++;
			zombieAlive++;
			for (tmpLvl = 0; tmpLvl < zombieAlive; tmpLvl++) {
				Math:Random(1, 2, tmp)
				mummies[tmpLvl].speed = tmp;
			}
		}
		mummies[p_index].alive = false;
		initMummy(p_index, mummies[p_index].speed)
	}
}

function PlayerStateMachine() {
	ctr++;
	if (playerState == STATE_WALK) {
		PlayerWalk()
	} else if (playerState == STATE_JUMP) {
		PlayerJump()
	} else if (playerState == STATE_ATTACK) {
		PlayerShoot()
	} else if (playerState == STATE_DIE) {
		PlayerKilled()
	} else if (playerState == STATE_CALL) {
		PlayerCall()
	} else {
		//get user input
		if (B4 == true) {
			if (playerState != STATE_JUMP) {
				playerState = STATE_JUMP;
				ctr = 0;
			}
		} else if (B3 == true) {
			if (playerState != STATE_ATTACK) {
				playerState = STATE_ATTACK;
				ctr = 0;
			}
		} else if (Key_D == true) {
			playerState = STATE_WALK;
			playerFaceRight = true;
		} else if (Key_A == true) {
			playerState = STATE_WALK;
			playerFaceRight = false;
		} else if (Key_C == true) {
			playerState = STATE_CALL;
		} else {
			//play idle animation
			PlayerStand()
		}
	}
	if (playerFaceRight == true) {
		shooting_range = playerMapX + 100;
	} else { //GOD AS: if (playerFaceRight == false) {
		shooting_range = playerMapX - 70;
	}
	Draw:RectFill(playerMapX, 140, 5, 5, 0x0000ff, Screen2)
	Draw:RectFill(shooting_range, 140, 5, 5, 0xff9900, Screen2)
}

function PlayerWalk() {
	if (ctr >= 12) {
		ctr = 0;
	}
	if (playerFaceRight == true) { 
		Image:TBlit(playerMapX, 140, WalkingR[ctr], Screen2)
		playerMapX += 4;
		if (playerMapX > 1266 - 48) {
			playerMapX = 1266 - 48;
		}
		if (Key_D == false) {
			playerState = STATE_IDLE;
		}
	} else {
		Image:TBlit((playerMapX - 10), 140, WalkingL[ctr], Screen2)
		playerMapX -= 4;
		if (playerMapX < 0) {
			playerMapX = 0;
		}
		if (Key_A == false) {
			playerState = STATE_IDLE;
		}
	}
	if (B4 == true) {
		if (playerState != STATE_JUMP) {
			playerState = STATE_JUMP;
			ctr = 0;
		}
	} else if (B3 == true) {
		if (playerState != STATE_ATTACK) {
			playerState = STATE_ATTACK;
			ctr = 0;
		}
	}
}

function PlayerJump() {
	if (ctr >= 21) {
		playerState = STATE_IDLE;
	}
	if (playerFaceRight == true) {
		if (Key_D == true) {
			playerMapX += 5;
			if (playerMapX > 1266 - 48) {
				playerMapX = 1266 - 48;
			}
		} else if (Key_A == true) {
			playerFaceRight = false;
		}
		Image:TBlit(playerMapX, 80, JumpR[ctr], Screen2)
	} else {
		if (Key_A == true) {
			playerMapX -= 5;
			if (playerMapX < 0) {
				playerMapX = 0;
			}
		} else if (Key_D == true) {
			playerFaceRight = true;
		}
		Image:TBlit(playerMapX, 80, JumpL[ctr], Screen2)
	}
}

function PlayerCall() {
	if (ctr >= 23) {
		playerState = STATE_IDLE;
		robotState = STATE_ATTACK;
	}
	if (playerFaceRight == true) {
		Image:TBlit(playerMapX-2, 137, CallR[ctr], Screen2)
	} else {
		Image:TBlit(playerMapX, 137, CallL[ctr], Screen2)
	}
}

function PlayerShoot() {
	if (ctr >= 15) {
		playerState = STATE_IDLE;
	}
	if (playerFaceRight == true) {
		Image:TBlit(playerMapX, 143, ShootR[ctr], Screen2)
		Image:TBlit(playerMapX + 35, 123, SmokeR[ctr], Screen2)
	} else {
		Image:TBlit(playerMapX, 143, ShootL[ctr], Screen2)
		Image:TBlit(playerMapX - 90, 123, SmokeL[ctr], Screen2)
	}
}

function PlayerStand() {
	if (ctr >= 7) {
		ctr = 0;
	}
	
	if (playerFaceRight == true) {
		Image:TBlit(playerMapX, 143, StandingR[ctr], Screen2)
	} else {
		Image:TBlit(playerMapX, 143, StandingL[ctr], Screen2)
	}
}

function PlayerKilled() {
	if (ctr >= 18) {
		playerState = STATE_IDLE;
		exit = true;
		ctr = 0;
	}
	Image:TBlit(playerMapX - 5, 143, Dead[ctr], Screen2)
}

Var:Number bulletCtr;
function RenderBullet() {
	for (i = 0; i < 22; i++) {
		if (bullets[i].used == true) {
			if (bullets[i].faceRight == true) {
				Image:TBlit(bullets[i].x + 100, bullets[i].y + 145, bullets[ctr].imgR, Screen2)
				bullets[i].x = bullets[i].x + 10;
			} else {
				Image:TBlit(bullets[i].x, bullets[i].y + 145, bullets[ctr].imgL, Screen2)
				bullets[i].x = bullets[i].x - 10;
			}
		}
	}
}

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (c) 2008 Jesthony Maquiling [14 Aug]
   (c) 2011 Mj Mendoza IV [12 May]
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
 
Var:Create(
	Mummy, 
		Number x,
		Number y,
		Number img,
		Boolean alive,
		Number speed,
		Number state,
		Boolean faceR
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
Array:New RobotL[17]:Number;
Array:New RobotR[17]:Number;
Array:New RobotIL[5]:Number;
Array:New RobotIR[5]:Number;
Array:New MummiesR[18]:Number;
Array:New MummiesL[18]:Number;
Array:New AttackR[22]:Number;
Array:New AttackL[22]:Number;
Array:New Dead[19]:Number;
Array:New Burn[44]:Number;

Var:Number ctr, car, playerFaceRight = true, rrr = 640, R = 1, RI = 1, RobI = false, Displacement, playerMapX;
Var:Number i, tmp, shooting_range, Screen2, Points = 0, exit, LogoEnd, LogoMain, BG;

Var:Number tmpLvl;
Var:Number Level = 1;
Var:Number zombieAlive = 3;
Var:Number playerState = 0;

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
			RobotR[ctr - 1] = tmp;
		Image:Load("img\\Robot\\Walk\\L (" + ctr + ").png", tmp)
			RobotL[ctr - 1] = tmp;
	}
	for (ctr = 1; ctr <=  5; ctr++) {
		Image:Load("img\\Robot\\Idle\\R (" + ctr + ").png", tmp)
			RobotIR[ctr - 1] = tmp;
		Image:Load("img\\Robot\\Idle\\L (" + ctr + ").png", tmp)
			RobotIL[ctr - 1] = tmp;
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
				Robotic()
				MummyStateMachine()
				
				PlayerStateMachine()
				
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

function MummyStateMachine() {
	for (i = 0; i < zombieAlive; i++) {
		if (mummies[i].state == STATE_DIE) {
			MummyDie(i)
		} else {
			if (mummies[i].alive == true) {
				MummyAlive(i)
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

function Robotic() {
	Displacement = playerMapX - rrr;
	if (Displacement < 0) {
		Displacement = Displacement * -1;
	}
	if (3 >= Displacement) {
		RobI = true;
	} else {
		RobI = false;
	}
		
	if (RobI == true) {
		if (playerFaceRight == true) {
			Image:TBlit(rrr, 115, RobotIR[RI], Screen2)
			RI++;
			if (RI >= 5) {
				RI = 1;
			}
		} else {
			Image:TBlit(rrr, 115, RobotIL[RI], Screen2)
			RI++;
			if (RI >= 5) {
				RI=1;
			}
		}
	} else {
		if (playerMapX >= rrr) {
			Image:TBlit(rrr, 115, RobotR[R], Screen2)
			R++;
			if (R >= 16) {
				R = 1;
			}
			rrr += 3;
		} else {
			Image:TBlit(rrr, 115, RobotL[R], Screen2)
			R++;
			if (R >= 16) {
				R = 1;
			}
			rrr -= 3;
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

function PlayerTryKill() {
	if (playerState != STATE_JUMP) {
		playerState = STATE_DIE;
		ctr = 0;
	}
}
function MummyAlive(Number p_index) {
	//determine direction
	if (playerMapX >= mummies[p_index].x + 5) {
		mummies[p_index].faceR = true;
	} else if (playerMapX + 5 <= mummies[p_index].x) {
		mummies[p_index].faceR = false;
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
		if (mummies[p_index].img >= 18) {
			mummies[p_index].img = 1;
		}
		if (mummies[p_index].faceR == true) {
			Image:TBlit(mummies[p_index].x, 137, MummiesR[mummies[p_index].img], Screen2)
			mummies[p_index].x = (mummies[p_index].x + mummies[p_index].speed);
		} else if (mummies[p_index].faceR == false) {
			Image:TBlit(mummies[p_index].x, 137, MummiesL[mummies[p_index].img], Screen2)
			mummies[p_index].x = (mummies[p_index].x - mummies[p_index].speed);
		}
	} else if (mummies[p_index].state == STATE_ATTACK) {
		if (mummies[p_index].img >= 22) {
			mummies[p_index].img = 1;
		}
		if (mummies[p_index].faceR == true) {
			if (mummies[p_index].img == 11 ) {
				if (playerMapX >= (mummies[p_index].x + 30)) {
					if (playerMapX <= (mummies[p_index].x + 10)) {
						PlayerTryKill()
					}
				}
			}
			Image:TBlit(mummies[p_index].x, 126, AttackR[mummies[p_index].img], Screen2)
		} else {
			if (mummies[p_index].img == 11) {
				if (playerMapX >= (mummies[p_index].x - 30)) {
					if (playerMapX <= mummies[p_index].x) {
						PlayerTryKill()
					}
				}
			}
			Image:TBlit(mummies[p_index].x - 50, 126, AttackL[mummies[p_index].img], Screen2)
		}
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
			shooting_range = playerMapX + 100;
		} else if (Key_A == true) {
			playerState = STATE_WALK;
			playerFaceRight = false;
			shooting_range = playerMapX - 70;
		} else if (Key_C == true) {
			playerState = STATE_CALL;
		} else {
			//play idle animation
			PlayerStand()
		}
	}
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

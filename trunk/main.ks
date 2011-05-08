/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   (c) 2008 Jesthony Maquiling [14 Aug]
   (c) 2011 Mj Mendoza IV [08 May]
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
 
Var:Create(
	Mummy, 
		Number x, 
		Number y, 
		Number img, 
		Number alive, 
		Number speed, 
		Number attack, 
		Number imgdead, 
		Number burning
)
Array:New mummies[20]:Mummy;

Array:New WalkingR[13]:Number;
Array:New StandingR[8]:Number;
Array:New WalkingL[13]:Number;
Array:New StandingL[8]:Number;
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

Var:Number ctr, crt = 1, car, pass, c=1, playerFaceRight = true, d=1, playerIsShooting = false, l = 1, rrr = 640, R = 1, RI = 1, RobI = false, Displacement, PlayermapX, MummyFaceR;
Var:Number asd, tmp, i, MummyFaceL, shooting_range, Screen2, ddd=1, PlayerAlive=true, Points=0, exit, Logo, Logo2, BG;

Var:Number tmpLvl;
Var:Number Level = 1;
Var:Number zombieAlive = 3;

//Var:Boolean Key_W;
Var:Boolean Key_A;
//Var:Boolean Key_S;
Var:Boolean Key_D;

function initGFX() {
  Screen:Show()
	Image:New(1266, 443, Screen2)
	Image:Load("img\\Map\\BG.png", BG)
	Image:Load("img\\Map\\car.png", car)
	Image:Load("img\\menu\\Logo.png", Logo)
	Image:Load("img\\menu\\Logo2.png", Logo2)
	
	for (ctr = 1; ctr <= 22; ctr++) {
		Image:Load("img\\Mummy\\Attack\\R (" + ctr + ").png", pass)
			AttackR[ctr - 1] = pass;
		Image:Load("img\\Mummy\\Attack\\L (" + ctr + ").png", pass)
			AttackL[ctr - 1] = pass;
	}
	for (ctr = 1; ctr <= 44; ctr++) {
		Image:Load("img\\Mummy\\Burn\\(" + ctr + ").png", pass)
			Burn[ctr - 1] = pass;
	}	
	for (ctr = 1; ctr <= 18; ctr++) {
		Image:Load("img\\Player\\Dies\\(" + ctr + ").png", pass)
			Dead[ctr - 1] = pass;
		
		Image:Load("img\\Mummy\\Walk\\R (" + ctr + ").png", pass)
			MummiesR[ctr - 1] = pass;
		Image:Load("img\\Mummy\\Walk\\L (" + ctr + ").png", pass)
			MummiesL[ctr - 1] = pass;
	}
	for (ctr = 1; ctr <= 17; ctr++){
		Image:Load("img\\Robot\\Walk\\R (" + ctr + ").png", pass)
			RobotR[ctr - 1] = pass;
		Image:Load("img\\Robot\\Walk\\L (" + ctr + ").png", pass)
			RobotL[ctr - 1] = pass;
	}
	for (ctr = 1; ctr <=  5; ctr++) {
		Image:Load("img\\Robot\\Idle\\R (" + ctr + ").png", pass)
			RobotIR[ctr - 1] = pass;
		Image:Load("img\\Robot\\Idle\\L (" + ctr + ").png", pass)
			RobotIL[ctr - 1] = pass;
	}
	for (ctr = 1; ctr <= 12; ctr++) {
		Image:Load("img\\Player\\Walk\\R (" + ctr + ").png", pass)
			WalkingR[ctr - 1] = pass;
		Image:Load("img\\Player\\Walk\\L (" + ctr + ").png", pass)
			WalkingL[ctr - 1] = pass;
	}
	for (ctr = 1; ctr <=  7; ctr++) {
		Image:Load("img\\Player\\Idle\\R (" + ctr + ").png", pass)
			StandingR[ctr - 1] = pass;
		Image:Load("img\\Player\\Idle\\L (" + ctr + ").png", pass)
			StandingL[ctr - 1] = pass;
	}
	for (ctr = 1; ctr <= 16; ctr++) {
		Image:Load("img\\Player\\Shoot\\R (" + ctr + ").png", pass)
			ShootR[ctr - 1] = pass;
		Image:Load("img\\Player\\Shoot\\L (" + ctr + ").png", pass)
			ShootL[ctr - 1] = pass;
		Image:Load("img\\Smoke\\R (" + ctr + ").png", pass)
			SmokeR[ctr - 1] = pass;
		Image:Load("img\\Smoke\\L (" + ctr + ").png", pass)
			SmokeL[ctr - 1] = pass;
	}
}

function initIO() {
//	Key:New("w", Key_W)
	Key:New("a", Key_A)
//	Key:New("s", Key_S)
	Key:New("d", Key_D)
}

function main() {
	initGFX()
	initIO()
	while (1 == 1) {
		ctr = 1;
		Points = 0;
		exit = false;
		PlayerAlive = true;
		PlayermapX = 640;
		
		spawnNewMummy()
		
		B3 = false;
		while (B3 == false) {
			Screen:CLS()
				Image:Blit(75, 20, Logo2, screen)
				Screen:GoToXY(90, 200)
				Screen:PrintString("Press Enter To Play")
			Screen:Render()
		}
		
	//main loop
		while (exit == false) {
			Screen:CLS()
				Image:Blit(0, 0, BG, Screen2)
				Image:TBlit(50, 100, car, Screen2)
				Robotic()
				Mummy()
				
				if (PlayerAlive == true) {
					Player_Alive()
				} else {
					Player_Killed()
				}
				
				if ( (300 - PlayermapX) > 0) {
					Image:Blit(0, 20, Screen2, screen)
				} else if (300 + PlayermapX < 1266 - 48) { //48 is player-walk-image-width: see Player\Walk\L (1).png
					Image:Blit(300 - PlayermapX, 20, Screen2, screen)
				} else {
					Image:Blit(600 - 1266 + 48, 20, Screen2, screen) //48 is player-walk-image-width: see Player\Walk\L (1).png
				}
				Screen:PrintString(Points)
			Screen:Render()
		}
	//end main loop
	
		B3 = false;
		while (B3 == false) {
			Screen:CLS()
				Screen:GoToXY(10, 30)
				Screen:PrintString("Your Score is " + Points + "\n Thank You for playing. \n Please visit our website at \n http://www.konsolscript.org")
				Image:Blit(50, 100, Logo, screen)
				Screen:GoToXY(80, 220)
				Screen:PrintString("Play Again? Press Enter")
			Screen:Render()
			if (B3 == true) {
				B3 = true;
			}
		}
		if (B4 == false) {
			B4 = false;
			Screen:Hide()
			Konsol:Message("coded by Toto Maquiling", "Metal Slug Kuno")
			Konsol:Exit()
		}
	}
}

function WalkRight() {
	if (ctr >= 12) {
		ctr = 0;
	}
	
	Image:TBlit(PlayermapX, 140, WalkingR[ctr], Screen2)
	
	PlayermapX += 4;
	if (PlayermapX > 1266 - 48) {
		PlayermapX = 1266 - 48;
	}
}

function WalkLeft() {
	if (ctr >= 12) {
		ctr = 0;
	}
	
	Image:TBlit((PlayermapX-10), 140, WalkingL[ctr], Screen2)
	
	PlayermapX -= 4;
	if (PlayermapX < 0) {
		PlayermapX = 0;
	}
}

function StandingRight() {
	if (ctr >= 7) {
		ctr = 0;
	}
	
	Image:TBlit(PlayermapX, 143, StandingR[ctr], Screen2)
}

function StandingLeft() {
	if (ctr >= 7) {
		ctr = 0;
	}
	
	Image:TBlit(PlayermapX, 143, StandingL[ctr], Screen2)
}

function Player_Movement() {
	ctr++;
	if (playerFaceRight == true) {
		if (BR == true) {
			WalkRight()
		} else if (Key_D == true) {
			WalkRight()
		} else {
			StandingRight()
			if (BL == true) {
				playerFaceRight = false;
			} else if (Key_A == true) {
				playerFaceRight = false;
			}
		}
	} else {
		if (BL == true) {
			WalkLeft()
		} else if (Key_A == true) {
			WalkLeft()
		} else {
			StandingLeft()
			if (BR == true) {
				playerFaceRight = true;
			} else if (Key_D == true) {
				playerFaceRight = true;
			}
		}
	}
}	

function ShootLeft() {
	Image:TBlit(PlayermapX, 143, ShootL[crt], Screen2)
	Image:TBlit(PlayermapX - 90, 123, SmokeL[crt], Screen2)
	if (crt < 16) {
		crt++;
	} else {
		playerIsShooting = false;
	}
}
	
function ShootRight() {
	Image:TBlit(PlayermapX, 143, ShootR[crt], Screen2)
	Image:TBlit(PlayermapX + 35, 123, SmokeR[crt], Screen2)
	if (crt < 16) {
		crt++;
	} else {
		playerIsShooting = false;
	}
}

function Mummy() {
//	Konsol:Delay(100)
//	Konsol:Log("~~~~~")
	for (asd = 0; asd < zombieAlive; asd++) {
//		Konsol:Log("asd " + asd + " burning" + mummies[asd].burning)
		if (mummies[asd].burning == true) {
			MummyAnimateBurning(asd)
		} else {
			if (mummies[asd].alive == true) {
				if (playerFaceRight == true) {
					if (mummies[asd].x < shooting_range) {
						if (mummies[asd].x > (PlayermapX + 20)) {
							if (playerIsShooting == true) {
								mummies[asd].burning = true;
							} else {
								Mummy_AnimateAlive(asd)
							}
						} else {
							Mummy_AnimateAlive(asd)
						}
					} else {
						Mummy_AnimateAlive(asd)
					}
				} else {
					if (mummies[asd].x > shooting_range) {
						if (mummies[asd].x < PlayermapX) {
							if (playerIsShooting == true) {	
								mummies[asd].burning = true;
							} else {
								Mummy_AnimateAlive(asd)
							}
						} else {
							Mummy_AnimateAlive(asd)
						}
					} else {
						Mummy_AnimateAlive(asd)
					}
				}
			}
		}
	}
}

function Robotic() {
	Displacement = PlayermapX - rrr;
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
		if (PlayermapX >= rrr) {
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

function spawnNewMummy() { 
	for (i = 0; i < 20; i++) { 
		initMummy(i, 0)
	}
}

function initMummy(Number index, Number speeddemon) { 
	Math:Random(0, 1266, tmp)
	if (tmp > (PlayermapX-100)) {
		if (tmp < (PlayermapX + 100)) {
			if (tmp > PlayermapX) {
				tmp += 200;
			} else {
				tmp -= 200;
			}
		}
	}
//	Konsol:Log(tmp)
	mummies[index].x = tmp; 
	mummies[index].alive = 1; 
	if (speeddemon == 0 ) {
		Math:Random(1, 2, tmp)
	} else {
		tmp = speeddemon + 0.1;
	}
	mummies[index].speed = tmp;
	Math:Random(1, 15, tmp)
	mummies[index].img = tmp;
	mummies[index].attack = 1;
	mummies[index].imgdead = 1 ;
	mummies[index].burning = false;	
} 

function Mummy_AnimateAlive(Number p_index) {
	if (PlayermapX >= mummies[p_index].x + 50) {
		Image:TBlit(mummies[p_index].x, 137, MummiesR[mummies[p_index].img], Screen2)
		if (mummies[p_index].img < 16) {
			l=mummies[p_index].img + 1;
			mummies[p_index].img = l;
		} else {
			mummies[p_index].img = 1;
		}
		l = mummies[p_index].speed;
		mummies[p_index].x = mummies[p_index].x + l;
		MummyFaceR=true;
		MummyFaceL=false;
		mummies[p_index].attack = 1;
	} else if (PlayermapX + 50 <= mummies[p_index].x) {
		Image:TBlit(mummies[p_index].x, 137, MummiesL[mummies[p_index].img], Screen2)
		if (mummies[p_index].img < 16) {
			l = mummies[p_index].img + 1;
			mummies[p_index].img = l;
		} else {
			mummies[p_index].img = 1;
		}
		l = mummies[p_index].x - mummies[p_index].speed;
		mummies[p_index].x = l;
		MummyFaceL=true;
		MummyFaceR=false;
		mummies[p_index].attack = 1;
	} else {
		if (PlayermapX >= mummies[p_index].x + 5) {
			MummyFaceR=true;
			MummyFaceL=false;
		} else if (PlayermapX + 5 <= mummies[p_index].x) {
			MummyFaceR=false;
			MummyFaceL=true;
		}
		if (MummyFaceR == true) {
			Image:TBlit(mummies[p_index].x, 126, AttackR[mummies[p_index].attack], Screen2)
			if (mummies[p_index].attack < 22) {
				tmp=mummies[p_index].attack + 1;
				mummies[p_index].attack = tmp;
				if (mummies[p_index].attack == 11 ) {
					if (PlayermapX >= (mummies[p_index].x + 50)) {
						if (PlayermapX <= (mummies[p_index].x + 20)) {
							PlayerAlive=false;
						} else {
							PlayerAlive=false;
						}
					}
				}
			} else { 
				mummies[p_index].attack = 1; 
			}
		} else if (MummyFaceL == true) {
			Image:TBlit(mummies[p_index].x-50, 126, AttackL[mummies[p_index].attack], Screen2)
			if (mummies[p_index].attack < 22) {
				tmp=mummies[p_index].attack + 1;
				mummies[p_index].attack = tmp;

				if (mummies[p_index].attack == 11) {
					if (PlayermapX >= (mummies[p_index].x - 30)) {
						if (PlayermapX <= mummies[p_index].x) {
							PlayerAlive=false;
						} else {
							PlayerAlive=false;
						}
					}
				}
			} else { 
				mummies[p_index].attack = 1; 
			}
		}
	}
}

function MummyAnimateBurning(Number p_index) {
	Image:TBlit(mummies[p_index].x - 8, 120, Burn[mummies[p_index].imgdead], Screen2)
	if (mummies[p_index].imgdead < 44) {
		Points = Points + mummies[p_index].speed;
		tmpLvl = Points / 1000;
		Math:Round(tmpLvl, 0, tmpLvl)
		Math:Round(Points, 0, Points)
		
		mummies[p_index].imgdead = mummies[p_index].imgdead + 1;
	} else {
		Points = Points + mummies[p_index].speed;
		tmpLvl = Points / 1000;
		Math:Round(tmpLvl, 0, tmpLvl)
		Math:Round(Points, 0, Points)
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

function Player_Killed() {
	Image:TBlit(PlayermapX - 5, 143, Dead[ddd], Screen2)
	if (ddd < 19) {
		ddd++;
	} else {
		PlayerAlive = false;
		exit=true;
		ddd = 0;
	}
}

function Player_Alive() {
	if (B3 == true) {
		if (playerIsShooting == false) {
			crt = 1;
			playerIsShooting = true;
		}
	}
	if (playerIsShooting == true) {
		if (playerFaceRight == true) {
			ShootRight()
		} else {
			ShootLeft()
		}
	} else {
		Player_Movement()
	}
	
	if (playerFaceRight == true) {
		shooting_range = PlayermapX + 100;
	} else {
		shooting_range = PlayermapX - 70;
	}
}


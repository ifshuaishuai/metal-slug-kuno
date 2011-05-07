/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   author       : Maquiling, Jesthony G.
   created this : 8/14/2008
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
 
Var:Create(
	Zombie,
		Number x,
		Number y,
		Number img,
		Number alive,
		Number speed,
		Number attack,
		Number imgdead,
		Number burning
)
Array:New zombies[20]:Zombie;

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

Var:Number ctr,crt=1,car,pass,c=1,FaceL=false,FaceR=true,d=1,Shooting=false,l=1,rrr=640,R=1,RI=1,RobI=false,Displacement,PlayermapX,MummyFaceR;
Var:Number asd,tmp,i,	MummyFaceL, shooting_range,Screen2,ddd=1,PlayerAlive=true,Points=0,exit,Logo,Logo2,BG;

function initialize() {
  Screen:Show()
	Image:New(1266, 443, Screen2)
	Image:Load("img\\Map\\BG.png", BG)
	Image:Load("img\\Map\\car.png", car)
	Image:Load("img\\menu\\Logo.png", Logo)
	Image:Load("img\\menu\\Logo2.png", Logo2)
	
	for (ctr=1; ctr <= 22; ctr++) {
		Image:Load("img\\Mummy\\Attack\\R (" + ctr + ").png", pass)
		AttackR[ctr] = pass;
		Image:Load("img\\Mummy\\Attack\\L (" + ctr + ").png", pass)
		AttackL[ctr] = pass;
	}
	for (ctr=1; ctr <= 44; ctr++) {
		Image:Load("img\\Mummy\\Burn\\(" + ctr + ").png", pass)
		Burn[ctr] = pass;
	}	
	for (ctr=1; ctr <= 18; ctr++) {
		Image:Load("img\\Player\\Dies\\("+ctr+").png", pass)
		Dead[ctr] = pass;
		
		Image:Load("img\\Mummy\\Walk\\R ("+ctr+").png", pass)
		MummiesR[ctr] = pass;
		Image:Load("img\\Mummy\\Walk\\L ("+ctr+").png", pass)
		MummiesL[ctr] = pass;
	}
	for(ctr=1;ctr<=17;ctr++){
		Image:Load("img\\Robot\\Walk\\R ("+ctr+").png", pass)
		RobotR[ctr] = pass;
		Image:Load("img\\Robot\\Walk\\L ("+ctr+").png", pass)
		RobotL[ctr] = pass;
	}
	for (ctr=1; ctr <= 5; ctr++) {
		Image:Load("img\\Robot\\Idle\\R (" + ctr + ").png", pass)
		RobotIR[ctr] = pass;
		Image:Load("img\\Robot\\Idle\\L ("+ctr+").png", pass)
		RobotIL[ctr] = pass;
	}
	for (ctr=1; ctr <= 12; ctr++) {
		Image:Load("img\\Player\\Walk\\R (" + ctr + ").png", pass)
		WalkingR[ctr] = pass;
		Image:Load("img\\Player\\Walk\\L (" + ctr + ").png", pass)
		WalkingL[ctr] = pass;
	}
	for (ctr=1;ctr <= 7; ctr++) {
		Image:Load("img\\Player\\Idle\\R (" + ctr + ").png", pass)
		StandingR[ctr] = pass;
		Image:Load("img\\Player\\Idle\\L (" + ctr + ").png", pass)
		StandingL[ctr] = pass;
	}
	for (ctr=1; ctr <= 16; ctr++) {
		Image:Load("img\\Player\\Shoot\\R (" + ctr + ").png", pass)
		ShootR[ctr] = pass;
		Image:Load("img\\Player\\Shoot\\L (" + ctr + ").png", pass)
		ShootL[ctr] = pass;
		Image:Load("img\\Smoke\\R (" + ctr + ").png", pass)
		SmokeR[ctr] = pass;
		Image:Load("img\\Smoke\\L (" + ctr + ").png", pass)
		SmokeL[ctr] = pass;
	}
}

function main() {
	initialize()
	while (1 == 1) {
		ctr = 1;
		Points = 0;
		exit = false;
		PlayerAlive = true;
		PlayermapX = 640;
		
		spawnNewZombie()
		
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
			
				if ( (145 - PlayermapX) >= 0) {
					Image:Blit(0, 0, Screen2, screen)
				} else if (160 + PlayermapX <= 1266) {
					Image:Blit(160 - PlayermapX, 0, Screen2, screen)
				} else { 
					Image:Blit(320 - 1266, 0, Screen2, screen)
				}
				Image:TBlit(300, 300, MummiesL[3], screen)
				Screen:PrintString(Points)
			Screen:Render()
		}
	//main loop
	
		B1 = false;
		while (B1 == false) {
			Screen:CLS()
				Screen:GoToXY(10, 30)
				Screen:PrintString("Your Score is "+ Points +"\n Thank You for playing. \n Please visit our website at \n http://konsolscript.sourceforge.net")
				Image:Blit(50, 100, Logo, screen)
				Screen:GoToXY(80, 220)	
				Screen:PrintString("Play Again? Press Space")
			Screen:Render()
			if (B4 == true) {
				B1 = true;
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

function WalkRight(Number p_move) {
	Image:TBlit(PlayermapX, 140, WalkingR[ctr], Screen2)
	ctr++;
	if (ctr >= 12) {
		ctr = 1;
	}
	PlayermapX += p_move;
	PlayermapX += 4;
}

function WalkLeft(Number r_move) {
	Image:TBlit((PlayermapX-10), 140, WalkingL[ctr], Screen2)
	ctr++;
	if (ctr >= 12) {
		ctr = 1;
	}
	PlayermapX -= r_move;
	PlayermapX -= 4;
}

function StandingRight() {
	Image:TBlit(PlayermapX, 143, StandingR[ctr], Screen2)
	
	if (ctr >= 7) {
		ctr = 1;
	}
}

function StandingLeft() {
	Image:TBlit(PlayermapX, 143, StandingL[ctr], Screen2)
	
	if (ctr >= 7) {
		ctr = 1;
	}
}

function MapVSmovement(Number limitL, Number limitR, Number mapLeft, Number mapRight) {
	if (FaceR == true) {
		if (PlayermapX NE limitR) {
			if (BR == true) {
				WalkRight(4)
			} else {
				ctr++;
				StandingRight()
				if (BL == true) {
					FaceR = false;
					FaceL = true;
				}
			}
		} else if (PlayermapX == limitR) {
			if (BR == true) {
				WalkRight(0)
			} else {
				ctr++;
				StandingRight()
				if (BL == true) {
					FaceR = false;
					FaceL = true;
				}
			}
		}
	}
	if(FaceL == true) {
		if (PlayermapX NE limitL) {
			if (BL == true) {
				WalkLeft(4)
			} else {
				ctr++;
				StandingLeft()
				if (BR == true) {
					FaceL = false;
					FaceR = true;
				}
			}
		} else if (PlayermapX == limitL) {
			if (BL == true) {
				WalkLeft(0)
			} else {
				ctr++;
				StandingLeft()
				if (BR == true) {
					FaceL = false;
					FaceR = true;
				}
			}
		}
	}
}	

function ShootLeft() {
	Image:TBlit(PlayermapX, 143, ShootL[crt], Screen2)
	tmp = PlayermapX - 90;
	Image:TBlit(tmp, 123, SmokeL[crt], Screen2)
	if (crt < 16) {
		crt++;
	} else {
		Shooting = false;
	}
	//Konsol:Delay(25)
}
	
function ShootRight() {
	Image:TBlit(PlayermapX, 143, ShootR[crt], Screen2)
	Image:TBlit(PlayermapX + 35, 123, SmokeR[crt], Screen2)
	if (crt < 16) {
		crt++;
	} else {
		Shooting = false;
	}
	//Konsol:Delay(25)
}

function Mummy() {
//	Konsol:Delay(100)
//	Konsol:Log("~~~~~")
	for (asd=1; asd < 20; asd++) {
//		Konsol:Log("asd " + asd + " burning" + zombies[asd].burning)
		if (zombies[asd].burning == true) {
			MummyAnimateBurning()
		} else {
			if (zombies[asd].alive == true) {
				if (FaceL == true) {
					if (zombies[asd].x > shooting_range) {
						if (zombies[asd].x < PlayermapX) {
							if (Shooting == true) {	
								zombies[asd].burning = true;
							} else {
								MummyAnimateAlive()
							}
						} else {
							MummyAnimateAlive()
						}
					} else {
						MummyAnimateAlive()
					}
					//else{MummyAnimateAlive()}
				} else {
					if (zombies[asd].x < shooting_range) {
						if (zombies[asd].x > (PlayermapX + 20)) {
							if (Shooting == true) {
								zombies[asd].burning = true;
							} else {
								MummyAnimateAlive()
							}
						} else {
							MummyAnimateAlive()
						}
					} else {
						MummyAnimateAlive()
					}
					//else{MummyAnimateAlive()}
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
		if (FaceL == true) {
			Image:TBlit(rrr, 115, RobotIL[RI], Screen2)
			RI++;
			if (RI >= 5) {
				RI=1;
			}
		} else {
			Image:TBlit(rrr, 115, RobotIR[RI], Screen2)
			RI++;
			if (RI >= 5) {
				RI = 1;
			}
		}
	} else {
		if (PlayermapX >= rrr) {
			Image:TBlit(rrr,115,RobotR[R],Screen2)
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

function spawnNewZombie() { 
	for (i = 1; i < 20; i++) { 
		initZombie(i, 0)
	}
}

function initZombie(Number index, Number speeddemon) { 
	Math:Random(0, 1266, tmp)
	if (tmp > (PlayermapX-100)) {
		if (tmp < (PlayermapX+100)) {
			if (tmp > PlayermapX) {
				tmp += 200;
			} else {
				tmp -= 200;
			}
		}
	}
//	Konsol:Log(tmp)
	zombies[index].x = tmp; 
	zombies[index].alive = 1; 
	if (speeddemon == 0 ) {
		Math:Random(1,2,tmp)
	} else {
		tmp = speeddemon+1;
	}
	zombies[index].speed = tmp;
	Math:Random(1,15,tmp)
	zombies[index].img = tmp;
	zombies[index].attack = 1;
	zombies[index].imgdead = 1 ;
	zombies[index].burning = false;	
} 

function MummyAnimateAlive() {
//	Konsol:Log("MummyAnimateAlive " + asd)
	if (PlayermapX >= zombies[asd].x+50) {
			Image:TBlit(zombies[asd].x, 137,MummiesR[zombies[asd].img],Screen2)
		if (zombies[asd].img < 16) {
			l=zombies[asd].img + 1;
			zombies[asd].img = l;
		} else {
			zombies[asd].img = 1;
		}
		l = zombies[asd].speed;
		zombies[asd].x = zombies[asd].x + l;
		MummyFaceR=true;
		MummyFaceL=false;
		zombies[asd].attack = 1;
	} else if (PlayermapX+50 <= zombies[asd].x) {
			Image:TBlit(zombies[asd].x,137,MummiesL[zombies[asd].img],Screen2)
		if (zombies[asd].img < 16) {
			l=zombies[asd].img + 1;
			zombies[asd].img = l;
		} else {
			zombies[asd].img = 1;
		}
		l = zombies[asd].x - zombies[asd].speed;
		zombies[asd].x = l;
		MummyFaceL=true;
		MummyFaceR=false;
		zombies[asd].attack = 1;
	} else {
			if (PlayermapX >= zombies[asd].x+5) {
				MummyFaceR=true;
				MummyFaceL=false;
			} else if (PlayermapX+5 <= zombies[asd].x) {
				MummyFaceR=false;
				MummyFaceL=true;
			}
		if (MummyFaceR == true) {
			Image:TBlit(zombies[asd].x, 126,AttackR[zombies[asd].attack],Screen2)
			if (zombies[asd].attack < 22) {
				tmp=zombies[asd].attack + 1;
				zombies[asd].attack = tmp;
				if (zombies[asd].attack == 11 ) {
					if (PlayermapX >= (zombies[asd].x + 50)) {
						if (PlayermapX <= (zombies[asd].x + 20)) {
							PlayerAlive=false;
						} else {
							PlayerAlive=false;
						}
					}
				}
			} else { 
				zombies[asd].attack = 1; 
			}
		} else if (MummyFaceL == true) {
			Image:TBlit(zombies[asd].x-50, 126,AttackL[zombies[asd].attack],Screen2)
			if (zombies[asd].attack < 22) {
				tmp=zombies[asd].attack + 1;
				zombies[asd].attack = tmp;

				if (zombies[asd].attack == 11) {
					if (PlayermapX >= (zombies[asd].x - 30)) {
						if (PlayermapX <= zombies[asd].x) {
							PlayerAlive=false;
						} else {
							PlayerAlive=false;
						}
					}
				}
			} else { 
				zombies[asd].attack = 1; 
			}
		}
	}
}

function MummyAnimateBurning() {
	tmp=zombies[asd].x-8;
	Image:TBlit(tmp,120,Burn[zombies[asd].imgdead], Screen2)
	if (zombies[asd].imgdead < 44) {
		Points = Points + zombies[asd].speed;
		tmp = zombies[asd].imgdead + 1;
		zombies[asd].imgdead = tmp;
	} else {
		zombies[asd].alive = false;
		tmp = zombies[asd].speed;
		initZombie(asd,tmp)
	}
}

function Player_Killed() {
	Image:TBlit(PlayermapX-5, 143, Dead[ddd], Screen2)
	if (ddd < 19) {
		ddd++;
	} else {
		PlayerAlive = false;
		exit=true;
		ddd=0;
	}
}

function Player_Alive() {
	if (B4 == true) {
		if (Shooting == false) {
			crt = 1;
			Shooting=true;
		}
	}
	if (Shooting == true) {
		if (FaceR == true) {
			ShootRight()
		}
		if (FaceL == true) {
			ShootLeft()
		}
	} else {
		if (PlayermapX >= 0) {
			MapVSmovement(0, 160, 0, 4)
		} else if (PlayermapX <= -940) {
			MapVSmovement(100, 292, 4, 0)
		} else {
			MapVSmovement(100, 160, 4, 4)
		}
	}
	if (FaceR == true) {
		shooting_range = PlayermapX + 100;
	}
	if (FaceL == true) {
		shooting_range = PlayermapX - 70;
	}
}








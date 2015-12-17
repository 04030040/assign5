//game state case number
final int gameStart=1, gameWin=2, gameLose=3, gameRun=4;
int gameState=0; 
char gameLevel;

int hpValue;
int treasurePosX, treasurePosY;
int enemy1PosX, enemy1PosY;
int fighterPosX, fighterPosY;
int bg1PosX, bg2PosX;
int enemySpeedX, enemySpeedY;
int treasureSpeedX; 

int strtBnLftBrdrX, strtBnRtBrdrX, strtBnUpBrdrY, strtBnLwBrdrY;
int endBnLftBrdrX, endBnRtBrdrX, endBnUpBrdrY, endBnLwBrdrY;

int fEDis, fTDis;
int enemySize;

PImage backgroundImg1;
PImage backgroundImg2;
PImage fighterimg;
PImage hpImg;
PImage enemyImg;
PImage treasureImg;
PImage startImg1;
PImage startImg2;
PImage endImg1;
PImage endImg2;
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

int [] level1Enemy, level2Enemy, level3Enemy;
int [][] level1Flame, level2Flame, level3Flame;

PImage [] flame;
PImage shoot;
int [][] shootPos;
boolean fireShoot;
int shootXSize;
int shootSpeed;
int score;

int shootWidth;
int shootHeight;
int enemyWidth;
int enemyHeight;
int fighterWidth;
int fighterHeight;
int treasureWidth;
int treasureHeight;

void setup(){
size (640, 480);
frameRate(60);
gameState=gameStart;
gameLevel='1';
hpValue=20;
treasurePosX=floor(random(width-95))+50;
treasurePosY=floor(random(height-95))+50;
//enemyPos acts as a basis of aligning enemy
enemy1PosX=(-enemySize)*2;
enemy1PosY=floor(random(height-120))+50;

fighterPosX=floor(random(width-90))+50;
fighterPosY=floor(random(height-90))+50;

backgroundImg1=loadImage("img/bg1.png");
backgroundImg2=loadImage("img/bg2.png");
fighterimg = loadImage("img/fighter.png");
hpImg=loadImage("img/hp.png");
enemyImg = loadImage("img/enemy.png");
treasureImg = loadImage("img/treasure.png");
startImg1 = loadImage("img/start1.png");
startImg2 = loadImage("img/start2.png");
endImg1 = loadImage("img/end1.png");
endImg2 = loadImage("img/end2.png");
enemy1PosX=0;
enemy1PosY=0;
bg1PosX=0;
bg2PosX=-641;
enemySpeedX=3;
enemySpeedY=3;
treasureSpeedX=3;

// start Button Left Boarder X position 
strtBnLftBrdrX=206;
// start Button Right Boarder X position 
strtBnRtBrdrX=444;
// start Button Upper Boarder Y position 
strtBnUpBrdrY=376;
// start Button Lower Boarder Y position 
strtBnLwBrdrY=413;
// end Button Left Boarder X position 
endBnLftBrdrX=209;
// end Button Right Boarder X position 
endBnRtBrdrX=422;
// end Button Upper Boarder Y position 
endBnUpBrdrY=310;
// end Button Lower Boarder Y position 
endBnLwBrdrY=346;

//distance between fighter and enemy
fEDis=55;
//distance between fighter and treasure
fTDis=45;
//Size of enymy
enemySize=61;

/*
level1Enemy=level2Enemy={
enemy1PosX, enemy1PosY, 
enemy2PosX, enemy2PosY, 
enemy3PosX, enemy3PosY, 
enemy4PosX, enemy4PosY, 
enemy5PosX, enemy5PosY
};

level3Enemy:
  4
 6 2
8   1
 7 3
  5

level3Enemy={
enemy1PosX, enemy1PosY,  
enemy2PosX, enemy2PosY, 
enemy3PosX, enemy3PosY, 
enemy4PosX, enemy4PosY, 
enemy5PosX, enemy5PosY, 
enemy6PosX, enemy6PosY, 
enemy7PosX, enemy7PosY, 
enemy8PosX, enemy8PosY
};
*/

level1Enemy=new int [10];
level2Enemy=new int [10];
level3Enemy=new int [16];

for (int n=0; n<level1Enemy.length/2; n++)
{level1Enemy[n*2]=enemy1PosX-(n*(enemySize+10));
level1Enemy[n*2+1]=enemy1PosY;
}

/*
for every row of levelXFlame: 
frame time, frame count, flame X position, flame Y position
*/

level1Flame=new int [5][4];
level2Flame=new int [5][4];
level3Flame=new int [8][4];

for (int n=0; n<5; n++)
{level1Flame[n][0]=0;
level1Flame[n][1]=0;
level1Flame[n][2]=-2*width;
level1Flame[n][3]=0;

level2Flame[n][0]=0;
level2Flame[n][1]=0;
level2Flame[n][2]=-2*width;
level2Flame[n][3]=0;
}

for (int n=0; n<8; n++)
{level3Flame[n][0]=0;
level3Flame[n][1]=0;
level3Flame[n][2]=-2*width;
level3Flame[n][3]=0;
}

flame=new PImage [5];
flame[0]=loadImage("img/flame1.png");
flame[1]=loadImage("img/flame2.png");
flame[2]=loadImage("img/flame3.png");
flame[3]=loadImage("img/flame4.png");
flame[4]=loadImage("img/flame5.png");

shoot=loadImage("img/shoot.png");
shootPos = new int [5][2];
//set all shoot as loaded
//  shootPos[m][0]=shoot position X, shootPos[m][1]=shoot position Y
for (int m=0; m<5; m++)
{
  shootPos[m][0]=-2*width;
  shootPos[m][1]=0;
}
fireShoot=false;
shootXSize=31;
shootSpeed=3;
score=0;

shootWidth=31;
shootHeight=27;
enemyWidth=61;
enemyHeight=61;
fighterWidth=51;
fighterHeight=51;
treasureWidth=41;
treasureHeight=41;

}

void mousePressed(){
//println("mousePressed");
//println("mouseX, Y =", mouseX, ", ", mouseY);
if (gameState==gameStart &&
// start Button
mouseX>strtBnLftBrdrX&&mouseX<strtBnRtBrdrX&&mouseY>strtBnUpBrdrY&&mouseY<strtBnLwBrdrY
){
  gameState=gameRun;
  hpValue=20;
}
else if (gameState==gameLose &&
//end Button
mouseX>endBnLftBrdrX&&mouseX<endBnRtBrdrX&&mouseY>endBnUpBrdrY&&mouseY<endBnLwBrdrY
){
  gameState=gameRun;
}
else if (gameState==gameWin){gameState=gameStart;}
else{
//println("mousePressed else");
}
}

//fighter position controlled by keyboard
void keyPressed() {
if (key == CODED) {
switch (keyCode) {
case UP:
upPressed = true;
break;
case DOWN:
downPressed = true;
break;
case LEFT:
leftPressed = true;
break;
case RIGHT:
rightPressed = true;
break;
}
}else if(keyCode == ' ')
{
  fireShoot=true;
}
}

void keyReleased() {
if (key == CODED) {
switch (keyCode) {
case UP:
upPressed = false;
break;
case DOWN:
downPressed = false;
break;
case LEFT:
leftPressed = false;
break;
case RIGHT:
rightPressed = false;
break;
}
}else if(keyCode == ' ')
{
  fireShoot=false;
}
}


void draw (){
switch (gameState){

case gameStart:
//println("gameStart");

//start Button
if (mouseX>strtBnLftBrdrX&&mouseX<strtBnRtBrdrX&&mouseY>strtBnUpBrdrY&&mouseY<strtBnLwBrdrY)
{
image (startImg1, 0, 0);
}
else{
image (startImg2, 0, 0);
}
break;

case gameWin:
//println("gameWin");
break;

case gameLose:
//return to level 1
gameLevel='1';
enemy1PosX=(-enemySize)*2;
enemy1PosY=floor(random(height-120))+50;
for (int n=0; n<level1Enemy.length/2; n++)
{level1Enemy[n*2]=enemy1PosX-(n*(enemySize+10));
level1Enemy[n*2+1]=enemy1PosY;
}
treasurePosX=floor(random(width-95))+50;
treasurePosY=floor(random(height-95))+50;
//data clearance
for (int n=0; n<5; n++)
{level1Flame[n][0]=0;
level1Flame[n][1]=0;
level1Flame[n][2]=-2*width;
level1Flame[n][3]=0;

level2Flame[n][0]=0;
level2Flame[n][1]=0;
level2Flame[n][2]=-2*width;
level2Flame[n][3]=0;
}

for (int n=0; n<8; n++)
{level3Flame[n][0]=0;
level3Flame[n][1]=0;
level3Flame[n][2]=-2*width;
level3Flame[n][3]=0;

for (int m=0; m<5; m++)
{
  shootPos[m][0]=-2;
  shootPos[m][1]=0;
}
shootPos[0][0]=-2*width;
fireShoot=false;

}
// end Button
if (mouseX>endBnLftBrdrX&&mouseX<endBnRtBrdrX&&mouseY>endBnUpBrdrY&&mouseY<endBnLwBrdrY){
image (endImg1, 0, 0);
}
else{
image (endImg2, 0, 0);
}
hpValue=100;
//println("gameLose");
break;

case gameRun:
//println("gameRun");
// background run
image (backgroundImg1, bg1PosX++, 0);
image (backgroundImg2, bg2PosX++, 0);
if (bg1PosX>641){bg1PosX=-640;}
if (bg2PosX>641){bg2PosX=-640;}

//fighter position controlled by keyboard
if(upPressed==true && fighterPosY-3>0){fighterPosY-=3;}
if(downPressed==true&&fighterPosY+3<height-51){fighterPosY+=3;}
if(leftPressed==true&&fighterPosX-3>0){fighterPosX-=3;}
if(rightPressed==true&&fighterPosX+3<width-51){fighterPosX+=3;}
image(fighterimg, fighterPosX, fighterPosY);
//println("fighterPosX=", fighterPosX);
//println("fighterPosY=", fighterPosY);

// hp
// hp background
stroke(0,0,50);fill(0,0,50);
rect(21, 15, 190, 20); //full hp == 190 point
// hp itself
//println("hpValue=", hpValue);
stroke(0,0,200);fill(0,0,200);
if (hpValue<40){stroke(250,20,20);fill(250,20,20);}
if(hpValue>0){
rect(21, 15, hpValue*1.9, 20); //full hp == 190 point
}
image(hpImg,10,10);
//hp value <=0
if (hpValue<=0){
gameState=gameLose;
}

/*
//enemy fighter contact
if ((Math.abs(fighterPosX-enemy1PosX)<=fEDis)&&Math.abs(fighterPosY-enemy1PosY)<=fEDis)
{enemy1PosX=0;
enemy1PosY=floor(random(height-90))+50;
hpValue-=20;
}
if (enemy1PosX>width)
{enemy1PosX=0;}
if (fighterPosX-enemy1PosX>fEDis)
{enemy1PosX+=enemySpeedX;}
if (enemy1PosX-fighterPosX>fEDis)
{enemy1PosX+=enemySpeedX;}
if (fighterPosY-enemy1PosY>0)
{enemy1PosY+=enemySpeedY;}
if (enemy1PosY-fighterPosY>0)
{enemy1PosY-=enemySpeedY;}
*/

//switch enemy levels
switch(gameLevel){
case '1':
//    println("gameLevel='1'");
//level 1
if (enemy1PosX<(width+7*(enemySize+10))){
  for (int n=0; n<level1Enemy.length/2; n++)
  {
    image (enemyImg, level1Enemy[n*2], level1Enemy[n*2+1]);
    level1Enemy[n*2]+=enemySpeedX;
    
    //enemy fighter contact
/*
    if ((Math.abs(fighterPosX-level1Enemy[n*2])<=fEDis)&&Math.abs(fighterPosY-level1Enemy[n*2+1])<=fEDis)
*/
if (isHit(fighterPosX, fighterPosY, fighterWidth, fighterHeight,
level1Enemy[n*2], level1Enemy[n*2+1], enemyWidth, enemyHeight))
    {
      hpValue-=20;
      //record the frameCount of the moment
      level1Flame[n][0]=frameCount % (60/10);
      //flame position == enemy position;
      //flame activation
      level1Flame[n][2]=level1Enemy[n*2];
      level1Flame[n][3]=level1Enemy[n*2+1];
      //enemy disapear
      level1Enemy[n*2]=-2*width;
    }
    //enemy shoot contact
    for (int j=0; j<5; j++)
    {
//      println("n="+n+", j="+j);
/*
      if (shootPos[j][0]!=-2*width && (Math.abs(level1Enemy[n*2]+15-shootPos[j][0])<=46)&&(Math.abs(level1Enemy[n*2+1]+17-shootPos[j][1]))<=44)
*/
if (shootPos[j][0]!=-2*width && 
isHit(
shootPos[j][0], shootPos[j][1], shootWidth, shootHeight,
level1Enemy[n*2], level1Enemy[n*2+1], enemyWidth, enemyHeight))
      {
        shootPos[j][0]=-2*width;
        //record the frameCount of the moment
        level1Flame[n][0]=frameCount % (60/10);
        //flame position == enemy position;
        //flame activation
        level1Flame[n][2]=level1Enemy[n*2];
        level1Flame[n][3]=level1Enemy[n*2+1];
        //enemy disapear
        level1Enemy[n*2]=-2*width;
        scoreChange(20);
      }
    }

  //if flame is activated
  if(level1Flame[n][2] != -2*width)
  {
    //flame shows only at certain frameCount
    if (frameCount % (60/10) == level1Flame[n][0])
    {
      image (flame[level1Flame[n][1]], level1Flame[n][2], level1Flame[n][3]);
      level1Flame[n][1]+=1;
      //flame ends
      if (level1Flame[n][1]==5)
      {
        //flame deactivation
        level1Flame[n][2]=-2*width;
        level1Flame[n][1]=0;
      }
    }
  }
}
//fire a shoot
if(fireShoot==true && fighterPosX-shootXSize-1>0
 && 
//no shoot in front of muzzle
(((fighterPosX-shootPos[0][0]<=31*2 && fighterPosX-shootPos[0][0]>0 && Math.abs(fighterPosY+12-shootPos[0][1])<=39) ||
(fighterPosX-shootPos[1][0]<=31*2 && fighterPosX-shootPos[1][0]>0 && Math.abs(fighterPosY+12-shootPos[1][1])<=39) ||
(fighterPosX-shootPos[2][0]<=31*2 && fighterPosX-shootPos[2][0]>0 && Math.abs(fighterPosY+12-shootPos[2][1])<=39) ||
(fighterPosX-shootPos[3][0]<=31*2 && fighterPosX-shootPos[3][0]>0 && Math.abs(fighterPosY+12-shootPos[3][1])<=39) ||
(fighterPosX-shootPos[4][0]<=31*2 && fighterPosX-shootPos[4][0]>0 && Math.abs(fighterPosY+12-shootPos[4][1])<=39))==false)
)
{
  //choose a loaded shoot to fire
  if(shootPos[0][0]==-2*width)
  {
    shootPos[0][0]=fighterPosX-shootXSize-1;
    shootPos[0][1]=fighterPosY+12;
//    println("shoot[0]");
  }else if(shootPos[1][0]==-2*width)
  {
    shootPos[1][0]=fighterPosX-shootXSize-1;
    shootPos[1][1]=fighterPosY+12;
//    println("shoot[1]");
  }else if(shootPos[2][0]==-2*width)
  {
    shootPos[2][0]=fighterPosX-shootXSize-1;
    shootPos[2][1]=fighterPosY+12;
//    println("shoot[2]");
  }else if(shootPos[3][0]==-2*width)
  {
    shootPos[3][0]=fighterPosX-shootXSize-1;
    shootPos[3][1]=fighterPosY+12;
//    println("shoot[3]");
  }else if(shootPos[4][0]==-2*width)
  {
    shootPos[4][0]=fighterPosX-shootXSize-1;
    shootPos[4][1]=fighterPosY+12;
//    println("shoot[4]");
  }else{
//    println("hello");
  }
}
//draw shoot
for(int m=0; m<5; m++)
{
  if(shootPos[m][0]!=-2*width)
  {
    image(shoot, shootPos[m][0], shootPos[m][1]);
    shootPos[m][0]-=shootSpeed;
    if (shootPos[m][0]<0)
    {
      shootPos[m][0]=-2*width;
    }
  }
}
  enemy1PosX+=enemySpeedX;
}else{
//after level 1, go to level 2
gameLevel='2';
enemy1PosX=(-enemySize)*2;
enemy1PosY=floor(random(height-300))+140;
  for (int n=0; n<level2Enemy.length/2; n++)
  {level2Enemy[n*2]=enemy1PosX-(n*(enemySize+10));
    level2Enemy[n*2+1]=enemy1PosY-n*15;
  }
}
break;
  
case '2':
//level 2
//  println("gameLevel='2'");
if (enemy1PosX<(width+7*(enemySize+10))){
  for (int n=0; n<level2Enemy.length/2; n++)
  {
    image (enemyImg, level2Enemy[n*2], level2Enemy[n*2+1]);
    level2Enemy[n*2]+=enemySpeedX;

    //enemy fighter contact
/*
    if ((Math.abs(fighterPosX-level2Enemy[n*2])<=fEDis)&&(Math.abs(fighterPosY-level2Enemy[n*2+1]))<=fEDis)
*/
if (isHit(fighterPosX, fighterPosY, fighterWidth, fighterHeight,
level2Enemy[n*2], level2Enemy[n*2+1], enemyWidth, enemyHeight))
    {
      hpValue-=20;
      //record the frameCount of the moment
      level2Flame[n][0]=frameCount % (60/10);
      //flame position == enemy position;
      //flame activation
      level2Flame[n][2]=level2Enemy[n*2];
      level2Flame[n][3]=level2Enemy[n*2+1];
      //enemy disapear
      level2Enemy[n*2]=-2*width;
    }

    //enemy shoot contact
    for (int j=0; j<5; j++)
    {
/*
      if (shootPos[j][0]!=-2*width && (Math.abs(level2Enemy[n*2]+15-shootPos[j][0])<=46)&&Math.abs(level2Enemy[n*2+1]+17-shootPos[j][1])<=44)
*/
if (shootPos[j][0]!=-2*width && 
isHit(
shootPos[j][0], shootPos[j][1], shootWidth, shootHeight,
level2Enemy[n*2], level2Enemy[n*2+1], enemyWidth, enemyHeight))
      {
        //set the contacted shoot to reload
        shootPos[j][0]=-2*width;
        //record the frameCount of the moment
        level2Flame[n][0]=frameCount % (60/10);
        //flame position == enemy position;
        //flame activation
        level2Flame[n][2]=level2Enemy[n*2];
        level2Flame[n][3]=level2Enemy[n*2+1];
        //enemy disapear
        level2Enemy[n*2]=-2*width;
        scoreChange(20);
      }
    }

    //if flame is activated
    if(level2Flame[n][2] != -2*width)
    {
      //flame shows only at certain frameCount
      if (frameCount % (60/10) == level2Flame[n][0])
        {
        image (flame[level2Flame[n][1]], level2Flame[n][2], level2Flame[n][3]);
        level2Flame[n][1]+=1;
        //flame ends
        if (level2Flame[n][1]==5)
        {
          //flame deactivation
          level2Flame[n][2]=-2*width;
          level2Flame[n][1]=0;
        }
      }
    }
  }
//fire a shoot
if(fireShoot==true && fighterPosX-shootXSize-1>0
 && 
//no shoot in front of muzzle
(((fighterPosX-shootPos[0][0]<=31*2 && fighterPosX-shootPos[0][0]>0 && Math.abs(fighterPosY+12-shootPos[0][1])<=39) ||
(fighterPosX-shootPos[1][0]<=31*2 && fighterPosX-shootPos[1][0]>0 && Math.abs(fighterPosY+12-shootPos[1][1])<=39) ||
(fighterPosX-shootPos[2][0]<=31*2 && fighterPosX-shootPos[2][0]>0 && Math.abs(fighterPosY+12-shootPos[2][1])<=39) ||
(fighterPosX-shootPos[3][0]<=31*2 && fighterPosX-shootPos[3][0]>0 && Math.abs(fighterPosY+12-shootPos[3][1])<=39) ||
(fighterPosX-shootPos[4][0]<=31*2 && fighterPosX-shootPos[4][0]>0 && Math.abs(fighterPosY+12-shootPos[4][1])<=39))==false)
)
{
  //choose a loaded shoot to fire
  if(shootPos[0][0]==-2*width)
  {
    shootPos[0][0]=fighterPosX-shootXSize-1;
    shootPos[0][1]=fighterPosY+12;
//    println("shoot[0]");
  }else if(shootPos[1][0]==-2*width)
  {
    shootPos[1][0]=fighterPosX-shootXSize-1;
    shootPos[1][1]=fighterPosY+12;
//    println("shoot[1]");
  }else if(shootPos[2][0]==-2*width)
  {
    shootPos[2][0]=fighterPosX-shootXSize-1;
    shootPos[2][1]=fighterPosY+12;
//    println("shoot[2]");
  }else if(shootPos[3][0]==-2*width)
  {
    shootPos[3][0]=fighterPosX-shootXSize-1;
    shootPos[3][1]=fighterPosY+12;
//    println("shoot[3]");
  }else if(shootPos[4][0]==-2*width)
  {
    shootPos[4][0]=fighterPosX-shootXSize-1;
    shootPos[4][1]=fighterPosY+12;
//    println("shoot[4]");
  }else{
//    println("hello");
  }
}
//draw shoot
for(int m=0; m<5; m++)
{
  if(shootPos[m][0]!=-2*width)
  {
    image(shoot, shootPos[m][0], shootPos[m][1]);
    shootPos[m][0]-=shootSpeed;
    if (shootPos[m][0]<0)
    {
      shootPos[m][0]=-2*width;
    }
  }
}
  enemy1PosX+=enemySpeedX;
//  i=0;
}else{
//after level 2, go to level 3
gameLevel='3';
enemy1PosX=(-enemySize)*2;
enemy1PosY=floor(random(height-260))+100;

      level3Enemy[0]=enemy1PosX-0*(enemySize+10);
      level3Enemy[2]=enemy1PosX-1*(enemySize+10);
      level3Enemy[4]=enemy1PosX-1*(enemySize+10);
      level3Enemy[6]=enemy1PosX-2*(enemySize+10);
      level3Enemy[8]=enemy1PosX-2*(enemySize+10);
      level3Enemy[10]=enemy1PosX-3*(enemySize+10);
      level3Enemy[12]=enemy1PosX-3*(enemySize+10);
      level3Enemy[14]=enemy1PosX-4*(enemySize+10);
      
      level3Enemy[1]=enemy1PosY-0*40;
      level3Enemy[3]=enemy1PosY-1*40;
      level3Enemy[5]=enemy1PosY+1*40;
      level3Enemy[7]=enemy1PosY-2*40;
      level3Enemy[9]=enemy1PosY+2*40;
      level3Enemy[11]=enemy1PosY-1*40;
      level3Enemy[13]=enemy1PosY+1*40;
      level3Enemy[15]=enemy1PosY-0*40;  
}
  break;
  
  case '3':
  //level 3
//    println("gameLevel='3'");
if (enemy1PosX<(width+7*(enemySize+10)))
{
  for (int n=0; n<level3Enemy.length/2; n++)
  {image (enemyImg, level3Enemy[n*2], level3Enemy[n*2+1]);
  level3Enemy[n*2]+=enemySpeedX;
  
  //enemy fighter contact
/*
  if ((Math.abs(fighterPosX-level3Enemy[n*2])<=fEDis)&&(Math.abs(fighterPosY-level3Enemy[n*2+1]))<=fEDis)
*/
if (isHit(fighterPosX, fighterPosY, fighterWidth, fighterHeight,
level3Enemy[n*2], level3Enemy[n*2+1], enemyWidth, enemyHeight))
  {
    hpValue-=20;
    //record the frameCount of the moment
    level3Flame[n][0]=frameCount % (60/10);
    //flame position == enemy position;
    //flame activation
    level3Flame[n][2]=level3Enemy[n*2];
    level3Flame[n][3]=level3Enemy[n*2+1];
    //enemy disapear
    level3Enemy[n*2]=-2*width;
  }
    //enemy shoot contact
    for (int j=0; j<5; j++)
    {
//      println("n="+n+", j="+j);
/*
      if (shootPos[j][0]!=-2*width && (Math.abs(level3Enemy[n*2]+15-shootPos[j][0])<=46)&&Math.abs(level3Enemy[n*2+1]+17-shootPos[j][1])<=44)
*/
if (shootPos[j][0]!=-2*width && 
isHit(
shootPos[j][0], shootPos[j][1], shootWidth, shootHeight,
level3Enemy[n*2], level3Enemy[n*2+1], enemyWidth, enemyHeight))
      {
        //set the contacted shoot to reload
        shootPos[j][0]=-2*width;
        //record the frameCount of the moment
        level3Flame[n][0]=frameCount % (60/10);
        //flame position == enemy position;
        //flame activation
        level3Flame[n][2]=level3Enemy[n*2];
        level3Flame[n][3]=level3Enemy[n*2+1];
        //enemy disapear
        level3Enemy[n*2]=-2*width;
        scoreChange(20);
      }
    }
  //if flame is activated
  if(level3Flame[n][2] != -2*width)
  {
    //flame shows only at certain frameCount
    if (frameCount % (60/10) == level3Flame[n][0])
    {
      image (flame[level3Flame[n][1]], level3Flame[n][2], level3Flame[n][3]);
      level3Flame[n][1]+=1;
      //flame ends
      if (level3Flame[n][1]==5)
      {
        //flame deactivation
        level3Flame[n][2]=-2*width;
        level3Flame[n][1]=0;
      }
    }
  }
}
//fire a shoot
if(fireShoot==true && fighterPosX-shootXSize-1>0
 && 
//no shoot in front of muzzle
(((fighterPosX-shootPos[0][0]<=31*2 && fighterPosX-shootPos[0][0]>0 && Math.abs(fighterPosY+12-shootPos[0][1])<=39) ||
(fighterPosX-shootPos[1][0]<=31*2 && fighterPosX-shootPos[1][0]>0 && Math.abs(fighterPosY+12-shootPos[1][1])<=39) ||
(fighterPosX-shootPos[2][0]<=31*2 && fighterPosX-shootPos[2][0]>0 && Math.abs(fighterPosY+12-shootPos[2][1])<=39) ||
(fighterPosX-shootPos[3][0]<=31*2 && fighterPosX-shootPos[3][0]>0 && Math.abs(fighterPosY+12-shootPos[3][1])<=39) ||
(fighterPosX-shootPos[4][0]<=31*2 && fighterPosX-shootPos[4][0]>0 && Math.abs(fighterPosY+12-shootPos[4][1])<=39))==false)
)
{
  //choose a loaded shoot to fire
  if(shootPos[0][0]==-2*width)
  {
    shootPos[0][0]=fighterPosX-shootXSize-1;
    shootPos[0][1]=fighterPosY+12;
//    println("shoot[0]");
  }else if(shootPos[1][0]==-2*width)
  {
    shootPos[1][0]=fighterPosX-shootXSize-1;
    shootPos[1][1]=fighterPosY+12;
//    println("shoot[1]");
  }else if(shootPos[2][0]==-2*width)
  {
    shootPos[2][0]=fighterPosX-shootXSize-1;
    shootPos[2][1]=fighterPosY+12;
//    println("shoot[2]");
  }else if(shootPos[3][0]==-2*width)
  {
    shootPos[3][0]=fighterPosX-shootXSize-1;
    shootPos[3][1]=fighterPosY+12;
//    println("shoot[3]");
  }else if(shootPos[4][0]==-2*width)
  {
    shootPos[4][0]=fighterPosX-shootXSize-1;
    shootPos[4][1]=fighterPosY+12;
//    println("shoot[4]");
  }else{
//    println("hello");
  }
}
//draw shoot
for(int m=0; m<5; m++)
{
  if(shootPos[m][0]!=-2*width)
  {
    image(shoot, shootPos[m][0], shootPos[m][1]);
    shootPos[m][0]-=shootSpeed;
    if (shootPos[m][0]<0)
    {
      shootPos[m][0]=-2*width;
    }
  }
}
//    println("enemy1PosX=", enemy1PosX);
//    println("enemy1PosY=", enemy1PosY);
enemy1PosX+=enemySpeedX;
}else{
//after level 3, go to level 1
gameLevel='1';
enemy1PosX=(-enemySize)*2;
enemy1PosY=floor(random(height-120))+50;
for (int n=0; n<level1Enemy.length/2; n++)
{level1Enemy[n*2]=enemy1PosX-(n*(enemySize+10));
level1Enemy[n*2+1]=enemy1PosY;
}
  break;
}
}
//treasure
//treasurePosX+=treasureSpeedX;
//enemy treasure contact
/*
if ((Math.abs(fighterPosX-treasurePosX)<fTDis)&&Math.abs(fighterPosY-treasurePosY)<fTDis)
*/
if (isHit(fighterPosX, fighterPosY, fighterWidth, fighterHeight,
treasurePosX, treasurePosY, treasureWidth, treasureHeight))
{treasurePosX=floor(random(width-95))+50;
  treasurePosY=floor(random(height-95))+50;
  hpValue+=10;
  if (hpValue>100){hpValue=100;}
}
image (treasureImg, treasurePosX, treasurePosY);

//show score
textSize(18);
fill(255);
text("Score: "+score, 10, 460);


break;

}
}

void scoreChange(int a)
{
score=score+a;
}

boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
return(
(Math.abs(ax-bx+(aw-bw)/2)<=(aw+bw)/2) &&
(Math.abs(ay-by+(ah-bh)/2)<=(ah+bh)/2)
);
}

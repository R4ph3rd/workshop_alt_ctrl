ArrayList<Stamp> stamps = new ArrayList<Stamp>();
FBox[] stamps_boxes = new FBox[30];


// FISICA

import fisica.*;
  
FWorld world;
FBlob b;
FPoly obstacle, obstacle2, obstacle3, obstacle4;
FBox stamp_box, side, ground;
int circleCount = 20;
float hole = 200;
float topMargin = 50;
float bottomMargin = 300;
float sideMargin = 50;
float xPos = 0;

float obstacleMargin = 190;
float speed = 2;

boolean debounce = false ;
boolean debounceContact = false ;
PVector[] stampPos = new PVector[2];
PVector[] pos = new PVector[2];
float[] angle = new float[2];

int b_length, b_height ;
int forceStamp = 470 ;

boolean rStampIsOnScreen, lStampIsOnScreen ;
int charge_l, charge_r ;
PVector rechargingStamp = new PVector(0, 0);

ArrayList<TrucPousse> trucs = new ArrayList<TrucPousse>();
ArrayList<AnimBoxes> boxes = new ArrayList<AnimBoxes>();

boolean startGame = true ;
boolean screenLoose = false ;
boolean isDropInScreen = true ;

PFont f;
PFont fbold;
int score, score1, score2;

//two players
PVector selecter, oneplayer, twoplayers ;
boolean players = false ;
color blue, red ;

boolean lastPlayerTouched;
boolean isPlayerGuilty = false ;

void setup() {
  size(3400, 2100);
  smooth();
  noCursor();
 

  for (int i = 0; i < 2; i++) {
    pos[i] = new PVector(-500, -600);
    stampPos[i] = new PVector(-500, - 600);
    angle[i] = 0;
  }
  
  score = 0 ;
  score1 = 0;
  score2 = 0;

  charge_r = 5;
  charge_l = 5;

  rStampIsOnScreen = false;
  lStampIsOnScreen = false;
  
  red = color( 190, 12, 34);
  blue = color(34, 12, 190);
  
  oneplayer = new PVector((height/3) - 400, (width/2) + 100);
  twoplayers = new PVector((height/3) + 580, (width/2) + 100); // putains de coordonnées !
  selecter = new PVector( - height, - width);
  players = true ;

  initColliders();

  b_length = 550;
  b_height = 350;

  f = createFont("AmaticSC-Regular.ttf", 100);
  fbold = createFont("AmaticSC-Bold.ttf", 100);
  textFont(f);
  textAlign(CENTER);

stamps.add(new Stamp( new PVector(height/2, width), 45, false));
stamps.add(new Stamp( new PVector((height/2) + 600, width + 600), -45, true));
stamps.add(new Stamp( new PVector(height/2, width + 2000), 20, false));
stamps.add(new Stamp( new PVector((height/2) + 600, width + 2300), - 10, true));
}

void draw() {

  translate(width/2, height/2);
  rotate(-PI/2);
  translate(-height/2, -width/2);
  background(255, 255, 255);

  if (startGame) {

    for ( int i = 0; i < stamps.size(); i ++) {
      Stamp stamp = stamps.get(i);

      if (stamp.checkEdges()) {
        stamps.remove(i);
      } else {
        stamp.update();
        stamp.display();
      }
    }

    updateCollideAnim();

    world.step();
    world.draw();



    for ( Stamp stamp : stamps) {
      world.remove(stamp.box);
    }

    if (frameCount % 50 == 0) {
      if (speed < 8) speed += .005 ;
      if (b_length > 250){
         b_length -- ;
         b_height -- ;
      }
      score ++ ;
    }

    rechargeStamps();
    displayChargeStamps();
    displayScore();
    checkDrop();

    if (!isDropInScreen) {
      looseGame();
    }
    
    fill(0);
    ellipse(mouseY, mouseX, 50, 50);
  } 
}

void displayScore() {
  
  if (players){
    textFont(fbold);
    textAlign(LEFT);
    fill(0);
    textSize(60);
    text(score1, height/14, 180);
    
    textAlign(RIGHT);
    fill(0);
    textSize(60);
    text(score2, height - (height/14), 180);
    
  } else {
    textFont(fbold);
    textAlign(LEFT);
    fill(0);
    textSize(60);
    text(score, height/14, 180);
  }
}

void looseGame(){
  screenLoose = true ;
  startGame = !startGame ;
  String looseSentence = "";
  int xblue, xred ;
  
  background(255);
  
  if (players){

    if (isPlayerGuilty){
      if(!lastPlayerTouched){
        looseSentence = " Blue player flied up to infinity and beyond...";
        fill(red);
        xred = height/2;
        xblue = height * 10 ;
      } else {
        looseSentence = " Red player flied up to infinity and beyond...";
        fill(blue);
        xblue = height/2;
        xred = height * 10 ;
      }
    } else {
      xblue = height/2 - 300;
      xred = height/2 + 300;
      if (score1 < score2){
        fill(red);
          looseSentence = "Blue player is a looser";
      }
      if (score1 > score2){
        fill(blue);
        looseSentence = "Red player is a looser";
      }
      if ( score1 == score2){
        fill(0);
       looseSentence = "Both of you are loosers"; 
      }
    }
    
    
    textSize(90);
    textAlign(CENTER);
    textFont(f);
    text(looseSentence, height/2, width/2 - 150);
    
    text("Score blue", xblue, width/2 );
    text("Score red", xred, width/2 );
    
    text(score1, xblue, width/2 + 150);
    text(score2, xred, width/2 + 150);
    
  } else {
    fill(0);
    textSize(90);
    textAlign(CENTER);
    textFont(f);
  
    String string1 = "You sprawled out like a Breton in his piss ! Such a boomer..";
    String string2 = "Your rotten score was :";
  
    if (score < 90 && score >= 50) {
      string1 = "You crashed like a cockroach ! Such a looser..";
      string2 = "Your poor score was :" ;
    }
    if (score < 150 && score >= 90) {
      string1 = "You loose ! Ah, would the cowherd try to rise ?";
      string2 = "Your score was :" ;
    }
    if (score >= 150) {
      string1 = "You loose ! Too bad, the butterfly was taking the right path to flight.";
      string2 = "Your score was :" ;
    }
  
  
    text(string1, height/2, width/2 - 90);
    text(string2, height/2, width/2 + 20);
    textFont(fbold);
    text(score, height/2, width/2 + 130);
  }
    
  textFont(f);
  text("Press the button to start", height/2, width/2 + 280);
  noLoop();
}

void checkDrop(){
  //print("getx :");
  //println(b.get);
  //printArray(world.getBodies());
  float yBlob = 0;
  ArrayList <FBody> bodies = world.getBodies();

  for (FBody body : bodies) {
    if (body.getClass().getName().equals("fisica.FCircle")) {
      yBlob = body.getY();
      if (players){
        if (yBlob < - width / 8){
          isDropInScreen = false;
          isPlayerGuilty = true ;
        }
        if (yBlob > width){
          isDropInScreen = false;
        }
      } else {
        if (yBlob > width || yBlob < - width / 8){
          isDropInScreen = false;
        }
      }
      
      if (yBlob < 0){
         fill(210);
         noStroke();
         ellipse(body.getX(), 120, 50, 50);
      }
    }
  }
}
 
 
 void mousePressed(){
   stamps.add(new Stamp( new PVector(mouseY, mouseX), random(360), true));
 }
 
 void keyPressed(){
  if (key == ENTER){
     restart(); 
  }
 }
 
 
void restart(){
  for (int i = 0; i < 2; i++) {
    pos[i] = new PVector(-500, -600);
    stampPos[i] = new PVector(-500, - 600);
    angle[i] = 0;
  }

  charge_r = 5;
  charge_l = 5;

  rStampIsOnScreen = false;
  lStampIsOnScreen = false;
  score = 0;
  score1 = 0;
  score2 = 0;
  speed = 2;
  
  startGame = true ;
  screenLoose = false; 
  isDropInScreen = true ;
  isPlayerGuilty = false ;
  initColliders();
}

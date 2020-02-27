import processing.serial.*;
Serial camPort;
Serial arduinoPort;

// timer
import com.dhchoi.CountdownTimer;
import com.dhchoi.CountdownTimerService;
CountdownTimer timer;
String timerCallbackInfo = "";

// SOUND DESIGN
import ddf.minim.*;
Minim minim;
AudioPlayer plop_1;
AudioPlayer plop_2;
AudioPlayer plop_3;
AudioPlayer plop_4;
AudioPlayer plop_5;
AudioPlayer plop_6;

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
ArrayList<Storage> items = new ArrayList<Storage>();

ArrayList<Stamp> stamps = new ArrayList<Stamp>();
FBox[] stamps_boxes = new FBox[30];

boolean startGame = false ;
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

PImage solo, multi ;

void setup() {
    fullScreen(P3D);
    smooth();
    noCursor();
      
    printArray(Serial.list()); 
    String portName = Serial.list()[1]; 
    String arduinoPortName = Serial.list()[0];
    camPort = new Serial(this, portName, 9600); 
    arduinoPort = new Serial(this, arduinoPortName, 9600);
    camPort.bufferUntil('\n');
    arduinoPort.bufferUntil('\n');
  
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
    
    solo = loadImage("./data/tampon1.png");
    multi = loadImage("./data/tampon2.png");
    solo.resize(0, b_height);
    multi.resize(0, b_height);
  
    initColliders();
    initSounds();
  
    b_length = 550;
    b_height = 350;
  
    f = createFont("AmaticSC-Regular.ttf", 100);
    fbold = createFont("AmaticSC-Bold.ttf", 100);
    textFont(f);
    textAlign(CENTER);
  
  }
  
  void draw() {
  
    translate(width/2, height/2);
    rotate(-PI/2);
    translate(-height/2, -width/2);
    background(255, 255, 255);
  
    if (startGame) {
      updateGhosts();
      displayGhosts();
  
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
  
      if (debounce) {
        playSample(triggerSample(moyenneStorage()));
        debounce = !debounce ;
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
    } else {
        if (screenLoose) {
            displayScreenLoose();
        } else {
          waitingForStart();
        }
    }
  }
  
  
  
  void checkDrop(){
    //print("getx :");
    //println(b.get);
    //printArray(world.getBodies());
    float yBlob = 0;
    ArrayList <FBody> bodies = world.getBodies();
  
    for (FBody body : bodies) {
      if (body.getClass().getName().equals("fisica.FCircle")) {
        //fill(255, 0, 0);
        //ellipse(body.getX(), body.getY(), 50, 50);
        //println(body.getX(), body.getY());
        
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
    
    
  PVector posConverter(float y, float x){
    return new PVector(map(y, 14, 101, 0, height),
                        map(x, 13, 147, 0, width));
  }
   

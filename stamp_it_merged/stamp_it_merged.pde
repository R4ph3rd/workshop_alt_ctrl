import processing.serial.*;
Serial camPort;
Serial contactPort;

PVector pos, stampPos;
float angle = 0 ;

ArrayList<Stamp> stamps = new ArrayList<Stamp>();
FBox[] stamps_boxes = new FBox[30];

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
FPoly obstacle,obstacle2,obstacle3,obstacle4;
FBox stamp_box, side;
int circleCount = 20;
float hole = 200;
float topMargin = 50;
float bottomMargin = 300;
float sideMargin = 50;
float xPos = 0;

float obstacleMargin = 190;
float speed = 2;

boolean debounce = false ;

int b_length, b_height ;

int charge_l, charge_r ;
boolean rechargingStamp = false;

ArrayList<TrucPousse> trucs = new ArrayList<TrucPousse>();
ArrayList<Storage> items = new ArrayList<Storage>();

void setup(){
  size(2300, 1800, P3D);
  smooth();

  printArray(Serial.list()); 
  String portName = Serial.list()[0]; 
  String contactPortName = Serial.list()[1];
  camPort = new Serial(this, portName, 9600); 
  contactPort = new Serial(this, contactPortName, 9600);
  camPort.bufferUntil('\n');
  contactPort.bufferUntil('\n');
  
  pos = new PVector(0, 0);
  stampPos = new PVector(0, 0);
  
  initColliders();
  initSounds();
  
  b_length = 350;
  b_height = 150;
}

void draw(){
  
  background(255, 255, 255);

  stampPos.x = map(pos.x, 0, 100, 0, width);
  stampPos.y = map(pos.y, 0, 100, 0, height);
  
  
  pushMatrix();
  pushStyle();
    translate(stampPos.x, stampPos.y);
    rotate(radians(angle));
    fill(0,50);
    rect(0 - (b_length/2), 0 - (b_height/2), b_length, b_height);
  popStyle();
  popMatrix();

  
  for ( int i = 0 ; i < stamps.size() ; i ++) {
    Stamp stamp = stamps.get(i);
    
    if (stamp.checkEdges()){
      stamps.remove(i);
    } else {
       stamp.update();
       stamp.display();
    }
    
  }
  
  spawnerUpdate();
  

  world.step();
  world.draw();
  
  for ( Stamp stamp : stamps){
     world.remove(stamp.box); 
  }
  
  if (rechargingStamp){
     rechargeStamps(true);
  }
  
  if (debounce){
    playSample(triggerSample(moyenneStorage()));
    debounce = !debounce ;
  }
  
  if (frameCount % 50 == 0 && speed < 8) speed += .005 ;
  
  
}

void serialEvent (Serial thisPort) {
  try { 
    if ( thisPort == camPort){
      while (camPort.available() > 0) {
        String inBuffer = camPort.readString(); 
        if (inBuffer != null) {
          if (inBuffer.substring(0, 1).equals("{")) {
            JSONObject json = parseJSONObject(inBuffer); 
            if (json != null) {
             // println(json);
              
              pos.set(json.getInt("pos_x"), json.getInt("pos_y"));
              angle = json.getFloat("rotation");
              
              println(json);
              
              
            }  
          }
        }
      }
    }
    
    if ( thisPort == contactPort){
      String tt = contactPort.readString() ;
      JSONObject ttjson = parseJSONObject(tt);
      println(ttjson.getInt("contact"));
      
      if ( ttjson.getInt("contact") == 8){
        stamps.add(new Stamp(
                    new PVector(stampPos.x, stampPos.y), angle));
        println(ttjson);
        
        if ( ttjson.getInt("Tag_ID") == 12){
          stamped(true);
        }
        
        if (ttjson.getInt("Tag_ID") == 0){
          stamped(false);
        }
        delay(100);
      }
      
      if ( ttjson.getInt("contact") == 5){
        rechargingStamp = !rechargingStamp ;
        println("recharge 5");
      }
      
      if ( ttjson.getInt("contact") == 6){
        rechargingStamp = !rechargingStamp ;
        println("recharge 6 ");
      }
      
      if (ttjson.getInt("released") == 5){
        rechargingStamp = !rechargingStamp ;
        println("released 5");      
      }
      
      if (ttjson.getInt("released") == 6){
        rechargingStamp = !rechargingStamp ;
        println("released 6");      
      }
    }
    

  }
  catch (Exception e) {
  }

}

void keyPressed(){
  if (key == ENTER){
    stamps.add(new Stamp(
                    new PVector(stampPos.x, stampPos.y), angle));
        delay(100);
        
        println(stamps.size());
  }
}

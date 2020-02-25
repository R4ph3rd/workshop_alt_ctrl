/**
 *  Buttons and bodies
 *
 *  by Ricard Marxer
 *
 *  This example shows how to create a blob.
 */

import fisica.*;

FWorld world;

int circleCount = 20;
float hole = 200;
float topMargin = 50;
float bottomMargin = 300;
float sideMargin = 50;
float xPos = 0;

float obstacleMargin = 190;
float speed = 2;

float obstaclePosTop = 60;
float obstaclePosTop2 = 460;
float obstaclePosTop3 = 260;
float obstaclePosTop4 = 660;

float obstaclePosMouv = 0;
float obstaclePosMouv2 = 0;
float obstaclePosMouv3 = 0;
float obstaclePosMouv4 = 0;

void setup() {
  size(500, 700);
  smooth();

  Fisica.init(this);

  world = new FWorld();
  world.setGravity(0, +250);



  //left side
  FPoly l = new FPoly();
  l.vertex(0+sideMargin, 0);
  l.vertex(0, 0);
  l.vertex(0, height);
  l.vertex(0+sideMargin, height);
  l.vertex(0+sideMargin, height-bottomMargin);
  l.setStatic(true);
  l.setFill(0);
  l.setFriction(1);
  world.add(l);


  //right side
  FPoly r = new FPoly();
  r.vertex(width-sideMargin, 0);
  r.vertex(width, 0);
  r.vertex(width, height);
  r.vertex(width-sideMargin, height);
  r.setStatic(true);
  r.setFill(0);
  r.setFriction(1);
  world.add(r);
  
  
  //Blob popping
  FBlob b = new FBlob();
  b.setAsCircle(width/2, 20, 30, 20); 
  b.setStroke(0);
  b.setStrokeWeight(0);
  b.setFill(0);
  b.setFriction(0.01);
  b.setRestitution(0.01);
  b.setDamping(0);
  b.setDensity(10);
  b.setFrequency(0);
  world.add(b);

  
  
  
  
  
}

void draw() {
  background(255, 255, 255);
  
  FPoly obstacle = new FPoly();
    obstacle.vertex(width-sideMargin, obstaclePosTop+60);
    obstacle.vertex(width-sideMargin-obstacleMargin, obstaclePosTop+60);
    obstacle.vertex(width-sideMargin-obstacleMargin, obstaclePosTop+40);
    obstacle.vertex(width-sideMargin, obstaclePosTop);
    obstacle.setStatic(true);
    obstacle.setFill(0);
    obstacle.setFriction(1);
    obstacle.setRestitution(6);
    world.add(obstacle);
    obstacle.setPosition(0, obstaclePosMouv);
    
    FPoly obstacle2 = new FPoly();
    obstacle2.vertex(width-sideMargin, obstaclePosTop2+60);
    obstacle2.vertex(width-sideMargin-obstacleMargin, obstaclePosTop2+60);
    obstacle2.vertex(width-sideMargin-obstacleMargin, obstaclePosTop2+40);
    obstacle2.vertex(width-sideMargin, obstaclePosTop2);
    obstacle2.setStatic(true);
    obstacle2.setFill(0);
    obstacle2.setFriction(1);
    obstacle2.setRestitution(6);
    world.add(obstacle2);
    obstacle2.setPosition(0, obstaclePosMouv2);
  
  FPoly obstacle3 = new FPoly();
    obstacle3.vertex(0+sideMargin, obstaclePosTop3+60);
    obstacle3.vertex(0+sideMargin+obstacleMargin, obstaclePosTop3+60);
    obstacle3.vertex(0+sideMargin+obstacleMargin, obstaclePosTop3+40);
    obstacle3.vertex(0+sideMargin, obstaclePosTop3);
    obstacle3.setStatic(true);
    obstacle3.setFill(0);
    obstacle3.setFriction(1);
    obstacle3.setRestitution(6);
    world.add(obstacle3);
    obstacle3.setPosition(0, obstaclePosMouv3);
    
    FPoly obstacle4 = new FPoly();
    obstacle4.vertex(0+sideMargin, obstaclePosTop4+60);
    obstacle4.vertex(0+sideMargin+obstacleMargin, obstaclePosTop4+60);
    obstacle4.vertex(0+sideMargin+obstacleMargin, obstaclePosTop4+40);
    obstacle4.vertex(0+sideMargin, obstaclePosTop4);
    obstacle4.setStatic(true);
    obstacle4.setFill(0);
    obstacle4.setFriction(1);
    obstacle4.setRestitution(6);
    world.add(obstacle4);
    obstacle4.setPosition(0, obstaclePosMouv4);
  
  //if((frameCount % 10) == 1){
    obstaclePosMouv = obstaclePosMouv - speed;
    obstaclePosMouv2 = obstaclePosMouv2 - speed;
    obstaclePosMouv3 = obstaclePosMouv3 - speed;
    obstaclePosMouv4 = obstaclePosMouv4 - speed;
    
    if(obstaclePosMouv <= -150){
      obstaclePosMouv = 660;
    }
    
    if(obstaclePosMouv2 <= -520){
      obstaclePosMouv2 = 300;
    }
    
    if(obstaclePosMouv3 <= -340){
      obstaclePosMouv3 = 460;
    }
    
    if(obstaclePosMouv4 <= -720){
      obstaclePosMouv4 = 60;
    }
  //}
  
  world.step();
  world.draw();
  
  world.remove(obstacle);
  world.remove(obstacle2);
  world.remove(obstacle3);
  world.remove(obstacle4);
}

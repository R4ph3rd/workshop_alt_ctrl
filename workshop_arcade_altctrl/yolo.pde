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
float obstacle2Margin = 190;

float obstaclePosTop = 560;
float obstacle2PosTop = 260;

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
  b.setFill(255);
  world.add(b);
  
  
  
}

void draw() {
  background(80, 120, 200);
  
  FPoly obstacle = new FPoly();
  obstacle.vertex(width-sideMargin, obstaclePosTop+60);
  obstacle.vertex(width-sideMargin-obstacleMargin, obstaclePosTop+60);
  obstacle.vertex(width-sideMargin-obstacleMargin, obstaclePosTop+40);
  obstacle.vertex(width-sideMargin, obstaclePosTop);
  obstacle.vertex(width-sideMargin, 0);
  obstacle.vertex(width, 0);
  obstacle.vertex(width, height);
  obstacle.vertex(width-sideMargin, height);
  obstacle.setStatic(true);
  obstacle.setFill(0);
  obstacle.setFriction(1);
  world.add(obstacle);
  
  FPoly obstacle2 = new FPoly();
  obstacle2.vertex(width-sideMargin, obstacle2PosTop+60);
  obstacle2.vertex(width-sideMargin-obstacle2Margin, obstacle2PosTop+60);
  obstacle2.vertex(width-sideMargin-obstacle2Margin, obstacle2PosTop+40);
  obstacle2.vertex(width-sideMargin, obstacle2PosTop);
  obstacle2.vertex(width-sideMargin, 0);
  obstacle2.vertex(width, 0);
  obstacle2.vertex(width, height);
  obstacle2.vertex(width-sideMargin, height);
  obstacle2.setStatic(true);
  obstacle2.setFill(0);
  obstacle2.setFriction(1);
  world.add(obstacle2);
  
  
  if((frameCount % 10) == 1){
    obstaclePosTop = obstaclePosTop - 10;
    obstacle2PosTop = obstacle2PosTop - 10;
  }
  world.step();
  world.draw();
  world.remove(obstacle);
  world.remove(obstacle2);
}
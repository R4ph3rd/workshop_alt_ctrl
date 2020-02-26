void initColliders(){
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
  b = new FBlob();
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
  
  FBox ground = new FBox(width * 2, 30);
  ground.setPosition(0, height - 30);
  ground.setFill(0);
  ground.setRestitution(20);
  ground.setStatic(true);
  world.add(ground);
}


void spawnerUpdate() {
  for (int i = 0; i < trucs.size(); i++) {
      TrucPousse t = trucs.get(i);
      t.display();
      t.ypos -= speed;
      t.size = t.size + t.radius/20;
      t.opa = t.opa - 1;
      if(t.ypos<-50){
        trucs.remove(i);
      }
      if(t.radius>50){
        if (t.size > t.radius) {
          trucs.remove(i);
        }
      }
    }
  }
  
  
void obstacle(){

  obstacle = new FPoly();
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

  obstacle2 = new FPoly();
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

  obstacle3 = new FPoly();
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

  obstacle4 = new FPoly();
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

  if (obstaclePosMouv <= -150) {
    obstaclePosMouv = 660;
  }

  if (obstaclePosMouv2 <= -520) {
    obstaclePosMouv2 = 300;
  }

  if (obstaclePosMouv3 <= -340) {
    obstaclePosMouv3 = 460;
  }

  if (obstaclePosMouv4 <= -720) {
    obstaclePosMouv4 = 60;
  }
 
}

void contactStarted(FContact c) {
  //println(c.getBody1());
  //if (!c.getBody1().isStatic()) {
  //  println("body1", c.getBody1().getX(), c.getBody1().getY());
  //  trucs.add(new TrucPousse(c.getBody1().getX(), c.getBody1().getY()));
  //}
  
  //if (!c.getBody2().isStatic()) {
  //  println("body2", c.getBody2().getX(), c.getBody2().getY());
  //  trucs.add(new TrucPousse(c.getBody2().getX(), c.getBody2().getY()));
  //}
  
  if(c.getSeparation() <0){
    //println((c.getVelocityX() + c.getVelocityY())/2);
    //trucs.add(new TrucPousse(c.getX(), c.getY(), map((c.getVelocityX() + c.getVelocityY())/2,0,1000,0,300)));
  }
}

class TrucPousse {
  float xpos;
  float ypos;
  float radius;
  float size;
  float opa = 100;

  TrucPousse( float xpos, float ypos, float radius) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.radius = radius;
  }

  void display() {
    pushStyle();
    fill(0, 0, 0, opa);
    noStroke();
    ellipse(xpos, ypos, size, size);
    popStyle();
  }
}

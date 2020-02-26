void initColliders(){
  Fisica.init(this);

  world = new FWorld();
  world.setGravity(0, +250);
  
  FBox side_l = new FBox(80, height * 2);
  side_l.setPosition(0, 0);
  side_l.setFill(0);
  side_l.setStatic(true);
  side_l.setFriction(1);
  world.add(side_l);
  
  FBox side_r = new FBox(80, height * 2);
  side_r.setPosition(width, 0);
  side_r.setFill(0);
  side_r.setStatic(true);
  side_r.setFriction(1);
  world.add(side_r);


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
      t.size = t.size + (t.radius/20);
      t.opa --;
      if(t.ypos < -50){
        trucs.remove(i);
      }
      if(t.radius > 50){
        if (t.size > t.radius) {
          trucs.remove(i);
        }
      }
    }
  }


void contactStarted(FContact c) { 
  if(c.getSeparation() < 0){
    //println((c.getVelocityX() + c.getVelocityY())/2);
    float c_size = map((c.getVelocityX() + c.getVelocityY())/2,0,2000,0,300);
    c_size = constrain(c_size, 0, 300.0);
    trucs.add(new TrucPousse(c.getX(), c.getY(), c_size));
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

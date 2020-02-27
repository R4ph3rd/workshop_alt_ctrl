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
  
  ground = new FBox(width * 2, 30);
  ground.setPosition(0, height - 90);
  ground.setFill(0);
  ground.setRestitution(20);
  ground.setStatic(true);
  world.add(ground);
}


void updateCollideAnim() {
  for (int i = 0; i < trucs.size(); i++) {
      TrucPousse t = trucs.get(i);
      t.update();
      t.display();
      if(t.ypos < -50){
        trucs.remove(i);
      }
      if(t.radius > 50){
        if (t.size > t.radius) {
          trucs.remove(i);
        }
      }
    }
    
  for (int i = 0 ; i < boxes.size(); i ++){
    AnimBoxes box = boxes.get(i);
    box.update();
    box.display();
    
    if (!box.shouldKeep()) boxes.remove(i);
  }
}


void contactStarted(FContact c) {
  
  // check pos of the drop
  if (!c.getBody1().isStatic() || !c.getBody2().isStatic()) {
    if (c.getBody1().getY() < - 200 || c.getBody1().getY() > height){
      println("oh");
      isDropInScreen = false ;
    }
  }
  
  // tentative for animation by overlaying a rect on the shape which is fucking inaccessible
  if (!c.getBody2().isStatic()) {
   //boxes.add(new AnimBoxes(c.getBody2().getX(), c.getBody2().getX(), c.getBody2().getRotation()));
  }
  
  if(c.getSeparation() < 0.2){
    //println((c.getVelocityX() + c.getVelocityY())/2);
    float c_size = map((c.getVelocityX() + c.getVelocityY())/2,0,2000,0,300);
    c_size = constrain(c_size, 0, 300.0);
    trucs.add(new TrucPousse(c.getX(), c.getY(), c_size));
    
    debounce = true ;  
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
  
  void update(){
    opa -- ;
    ypos -= speed;
    size += radius/20;
  }
  
  void display() {
    pushStyle();
      fill(0, 0, 0, opa);
      noStroke();  
      ellipse(xpos, ypos, size, size);
    popStyle();
  }
}


class AnimBoxes{
 
  float x, y, angle;
  int l, h;
  
  AnimBoxes(float x, float y, float angle){
    this.x = map(x, 20, 90, 0, width);
    this.y = map(y, 20, 90, 0, height);
    this.angle = angle;
    l = 0 ;
    h = 0;
  }
  
  void update(){
    l += 10 ;
    h += 10;
    y -= speed ;
  }
  
  boolean shouldKeep(){
     if (y < - b_length ) return false;
     if ( l == b_length) return false;
     return true;
  }
  
  void display() {
    pushMatrix();
    pushStyle();
      translate(x,y);
      rotate(angle);
      
      noStroke();
      fill(#8FB2FF);
      rect(0 - (b_length/2), 0 - (b_height/2), b_length, b_height);
    
    popMatrix();
    popStyle();
  }
}


// storage to stock values waiting for create a moyenne to set the correct sound

class Storage{
 
  float c_size ;
  
  Storage(float c_size){
    this.c_size = c_size ;
  }
}


float moyenneStorage(){
    float c = 0 ;
    
    for (Storage item : items ){
       c += item.c_size  ;
    }
    
    return c/items.size();
}

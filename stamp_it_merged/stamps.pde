class Stamp {

  PVector pos ;
  float angle ;
  
  FBox box;

  Stamp(PVector pos, float angle) {
    this.pos = pos.copy() ;
    this.angle = angle ;
    this.box = box ;
  }
  
  void update(){
    pos.y -= speed ;
  }
  
  boolean checkEdges(){
    return pos.y < 0 ;
  }

  void display(){
  /*  pushMatrix();
    pushStyle();
      translate(pos.x, pos.y);
      rotate(radians(angle));
      fill(255, 255);
      rect(0, 0, 300, 200);
    popStyle();
    popMatrix();
    */
    
    box = new FBox(b_length,b_height);
    box.setRotation(radians(angle));
    ///box.setPosition(pos.x, pos.y);
    box.setStatic(true);
    box.setFill(0);
    box.setFriction(1);
    box.setRestitution(6);
    world.add(box);
    box.setPosition(pos.x, pos.y);
    
  }
}


void rechargeStamps(boolean stamp){
    //if (stamp){
      charge_r ++ ;
    //} else {
      charge_l ++ ;
    //}
}
  
void stamped(boolean stamp){
  if (stamp){
    charge_r -- ;
  } else {
    charge_l -- ;
  }
}

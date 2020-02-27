class Stamp {

  PVector pos ;
  float angle ;
  boolean player;
  
  FBox box;

  Stamp(PVector pos, float angle, boolean player) {
    this.pos = pos.copy() ;
    this.angle = angle ;
    this.box = box ;
    this.player = player ;
  }
  
  void update(){
    pos.y -= speed ;
  }
  
  boolean checkEdges(){
    return pos.y < (- width / 8) + 100 ;
  }

  void display(){
    box = new FBox(b_length,b_height);
    box.setRotation(radians(angle));
    ///box.setPosition(pos.x, pos.y);
    box.setStatic(true);
    box.setNoStroke();
    box.setFill(0);
    
    if (players){
      if (player) box.setFillColor(red);
      else box.setFillColor(blue);
    }
    
    box.setFriction(1);
    box.setRestitution(6);
    world.add(box);
    box.setPosition(pos.x, pos.y);
    
  }
}


void removeFromScreen(int i){
  pos[i] = new PVector(-500, -600);
  stampPos[i] = new PVector(-500, - 600);
  angle[i] = 0;
}

void displayChargeStamps(){
  // charge left
  pushStyle();
    noStroke();
    fill(220);
    rect(90, width - 410, 70, 220, 8);
    float cl = map(charge_l, 0, 5, 0, 200);
    fill(blue);
    rect(100, width - 400, 50, cl, 8);
  popStyle();
  
  // charge right
  pushStyle();
    noStroke();
    fill(220);
    rect(height - 170, width - 410, 70, 220, 8);
    float cr = map(charge_r, 0, 5, 0, 200);
    fill(red);
    rect(height - 160, width - 400, 50, cr, 8);
  popStyle(); 
}


void rechargeStamps(){
   // println(rechargingStamp.y);
    constrain(charge_r, 0, 5);
    constrain(charge_l, 0, 5);
    if (charge_r < 5  && rechargingStamp.x == 1 && frameCount % 10 == 0){
      charge_r ++;
      //println("charge right increasing", charge_r);
    }
  
    if ( charge_l < 5 && rechargingStamp.y == 1  && frameCount % 10 == 0){
        charge_l ++;
        //println("charge left increasing", charge_l);
    }
  
}
  
void stamped(boolean stamp){
  if (stamp && charge_r > 0){
    charge_r -- ;
  } else if (!stamp && charge_l > 0) {
    charge_l -- ;
  }
}

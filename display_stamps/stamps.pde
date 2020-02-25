class Stamp {

  PVector pos ;
  float angle ;

  Stamp(PVector pos, float angle) {
    this.pos = pos.copy() ;
    this.angle = angle ;
  }

  void display(){
    pushMatrix();
    pushStyle();
      translate(pos.x, pos.y);
      rotate(radians(angle));
      fill(255, 255);
      rect(0, 0, 300, 200);
    popStyle();
    popMatrix();
  }
}

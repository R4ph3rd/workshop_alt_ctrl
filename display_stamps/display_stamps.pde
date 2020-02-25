import processing.serial.*;
Serial myPort;
Serial contactPort;

PVector pos, stampPos;
float angle = 0 ;

ArrayList<Stamp> stamps = new ArrayList<Stamp>();

void setup(){
  size(2300, 1800, P3D);
  printArray(Serial.list()); 
  String portName = Serial.list()[0]; 
  String contactPortName = Serial.list()[2];
  myPort = new Serial(this, portName, 9600); 
  contactPort = new Serial(this, contactPortName, 9600);
  myPort.bufferUntil('\n');
  contactPort.bufferUntil('\n');
  
  pos = new PVector(0, 0);
  stampPos = new PVector(0, 0);
  
}

void draw(){
  
  background(0);

  stampPos.x = map(pos.x, 0, 100, 0, width);stampPos.y = map(pos.y, 0, 100, 0, height);
  
  
  pushMatrix();
  pushStyle();
    translate(stampPos.x, stampPos.y);
    rotate(radians(angle));
    fill(255,50);
    rect(0, 0, 300, 200);
  popStyle();
  popMatrix();

  
  for ( Stamp stamp : stamps ) {
     stamp.display();
  }
  
  
}

void serialEvent (Serial thisPort) {
  try { 
    if ( thisPort == myPort){
      while (myPort.available() > 0) {
        String inBuffer = myPort.readString(); 
        if (inBuffer != null) {
          if (inBuffer.substring(0, 1).equals("{")) {
            JSONObject json = parseJSONObject(inBuffer); 
            if (json != null) {
              println(json);
              
              pos.set(json.getInt("pos_x"), json.getInt("pos_y"));
              angle = json.getFloat("rotation");
              
              
            }  
          }
        }
      }
    }
    
    if ( thisPort == contactPort){
      String tt = contactPort.readString() ;
      JSONObject ttjson = parseJSONObject(tt);
      //println(ttjson.getInt("contact"));
      
      if ( ttjson.getInt("contact") == 1){
        stamps.add(new Stamp(
                    new PVector(stampPos.x, stampPos.y), angle));
        delay(100);
      }
    }
    

  }
  catch (Exception e) {
  }

}

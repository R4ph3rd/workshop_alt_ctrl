void serialEvent (Serial thisPort) {
  try { 
    if ( thisPort == camPort){
      while (camPort.available() > 0) {
        String inBuffer = camPort.readString(); 
        if (inBuffer != null) {
          if (inBuffer.substring(0, 1).equals("{")) {
            JSONObject json = parseJSONObject(inBuffer); 
            if (json != null) { 
              if (json.get("l_pos_x") != null){
                 pos[0].set(json.getInt("l_pos_x"), json.getInt("l_pos_y"));
                 angle[0] = json.getFloat("l_rotation");
                 lStampIsOnScreen = true;
                  //println("left stamp is on screen");
              } else {
                removeFromScreen(0);
                lStampIsOnScreen = false;
              }
              
              if (json.get("r_pos_x") != null){
                 pos[1].set(json.getInt("r_pos_x"), json.getInt("r_pos_y"));
                 angle[1] = json.getFloat("r_rotation");
                 rStampIsOnScreen = true;
                  //println("right stamp is on screen");
              } else {
                  removeFromScreen(1);
                  rStampIsOnScreen = false;
              }
            }  
          } else {
             //println(inBuffer); 
          }
        }
      }
    }
    
    if ( thisPort == arduinoPort){
      String tt = arduinoPort.readString() ;
      JSONObject ttjson = parseJSONObject(tt);
      
  
      // start game
      if (ttjson.get("start") != null){
        if (ttjson.getInt("start") == 1){
          startGame = true ;
          screenLoose = false; 
          timerCallbackInfo = "[finished]";
        }
      }

      // is r stamp stamping on board ?
      if ( ttjson.get("force_l") != null && lStampIsOnScreen && charge_l > 0 ){
        if ( ttjson.getInt("force_l") >= 500){
          stamps.add(new Stamp( new PVector(stampPos[0].x, stampPos[0].y), angle[0]));        
          stamped(false);
        }
      }
      
      // is r stamp stamping on board ?
      if ( ttjson.get("force_r") != null && rStampIsOnScreen && charge_r > 0 ){
        //println("stamping right");
        if ( ttjson.getInt("force_r") >= 700){
          stamps.add(new Stamp( new PVector(stampPos[1].x, stampPos[1].y), angle[1]));        
          stamped(true);
        }
      }
      
      
      // is a stamp recharging ?
      if (ttjson.get("contact") != null){
        if (( ttjson.getInt("contact") == 5 || ttjson.getInt("contact") == 6)){
          rechargingStamp.x = 1 ;
         // println("recharging");
        }
      }
          
      // so now, which stamp is recharging ?
      if (rechargingStamp.x == 1){
        if (ttjson.get("force_l") != null && !lStampIsOnScreen){
          if (ttjson.getFloat("force_l") >= forceStamp){
            rechargingStamp.y = 0; // x == is a stamprecharge in contact w/ stamp, y == which stamp, 0 left
            rechargingStamp.z = ttjson.getFloat("force_l");
            //println("recharging left", ttjson.get("force_l"));
          }
        }
            
          if (ttjson.get("force_r") != null){
            if (ttjson.getFloat("force_r") >= forceStamp && !rStampIsOnScreen){
              rechargingStamp.y = 1; // x == is a stamprecharge in contact w/ stamp, y == which stamp 1 right
              rechargingStamp.z = ttjson.getFloat("force_r");
              //println("recharging right", ttjson.get("force_r"));
            }
          }
        } 
 
        if (ttjson.get("released") != null){
          if ( ttjson.getFloat("released") == 5 || ttjson.getFloat("released") == 6){
            rechargingStamp.set(0, 2, 0) ; // nothing 
            //println("released");
          }
        }
      }
  }
  catch (Exception e) {
  }

}


void onTickEvent(CountdownTimer t, long timeLeftUntilFinish) {
  timerCallbackInfo = "[tick] - timeLeft: " + timeLeftUntilFinish + "ms";
}

void onFinishEvent(CountdownTimer t) {
  timerCallbackInfo = "[finished]";
  screenLoose = false; 
}


// DEBUG
void keyPressed(){
  if (key == TAB){
    isDropInScreen = !isDropInScreen;
  }
}

void selectPlayers(){
  fill(0);
  PVector selecterConverted = posConverter(selecter.y, selecter.x);
  rect(selecterConverted.x, selecterConverted.y, b_length, b_height);
  
  
  if ( dist(oneplayer.x + (b_length / 2), oneplayer.y + (b_height / 2), selecterConverted.x, selecterConverted.y) < b_length){
     println("top");
     players = false ;
     startGame = true ;
  }
  
  if ( dist(twoplayers.x + (b_length / 2), twoplayers.y + (b_height / 2), selecterConverted.x, selecterConverted.y) < b_length){
    println("top"); 
    players = true ; 
    startGame = true ; 
  }
}

void waitingForStart(){
  fill(0);
  textSize(90);
  text("Select player(s) to start", height/2, width/2 - 100); 
  
  fill(0, 20);
  stroke(0,50);
  rect(oneplayer.x, oneplayer.y, b_length, b_height);
  rect(twoplayers.x, twoplayers.y, b_length, b_height);
  
  fill(0, 80);
  PVector selecterConverted = posConverter(selecter.y, selecter.x);
  rect(selecterConverted.x, selecterConverted.y, b_length, b_height);
 

  
  
 
}

void looseGame(){
  screenLoose = true ;
  timer = CountdownTimerService.getNewCountdownTimer(this).configure(100, 10000).start();
  startGame = !startGame ;
}

void displayScore() {
  
  if (players){
    textFont(fbold);
    textAlign(LEFT);
    fill(0);
    textSize(60);
    text(score1, height/14, 180);
    
    textAlign(RIGHT);
    fill(0);
    textSize(60);
    text(score2, height - (height/14), 180);
    
  } else {
    textFont(fbold);
    textAlign(LEFT);
    fill(0);
    textSize(60);
    text(score, height/14, 180);
  }
}

void displayScreenLoose(){
  background(255);
  
  if (players){

    String looseSentence = "";
    if (score1 < score2){
        looseSentence = "Blue player is a looser";
    }
    if (score1 > score2){
      looseSentence = "Red player is a looser";
    }
    if ( score1 == score2){
     looseSentence = "Both of you are loosers"; 
    }
    
    fill(0);
    textSize(90);
    textAlign(CENTER);
    textFont(f);
    text(looseSentence, height/2, width/2 - 150);
    
    text("Score blue", height/2 - 300, width/2 );
    text("Score red", height/2 + 300, width/2 );
    
    text(score1, height/2 - 300, width/2 + 150);
    text(score2, height/2 + 300, width/2 + 150);
    
  } else {
    fill(0);
    textSize(90);
    textAlign(CENTER);
    textFont(f);
  
    String string1 = "You sprawled out like a Breton in his piss ! Such a boomer..";
    String string2 = "Your rotten score was :";
  
    if (score < 90 && score >= 50) {
      string1 = "You crashed like a cockroach ! Such a looser..";
      string2 = "Your poor score was :" ;
    }
    if (score < 150 && score >= 90) {
      string1 = "You loose ! Ah, would the cowherd try to rise ?";
      string2 = "Your score was :" ;
    }
    if (score >= 150) {
      string1 = "You loose ! Too bad, the butterfly was taking the right path to flight.";
      string2 = "Your score was :" ;
    }
  
  
    text(string1, height/2, width/2 - 90);
    text(string2, height/2, width/2 + 20);
    textFont(fbold);
    text(score, height/2, width/2 + 130);
  }
    
        textFont(f);
        text("Press the button to start", height/2, width/2 + 280);
}

 
void restart(){
  for (int i = 0; i < 2; i++) {
    pos[i] = new PVector(-500, -600);
    stampPos[i] = new PVector(-500, - 600);
    angle[i] = 0;
  }

  charge_r = 5;
  charge_l = 5;

  rStampIsOnScreen = false;
  lStampIsOnScreen = false;
  score = 0;
  score1 = 0;
  score2 = 0;
  speed = 2;
  
  startGame = true ;
  screenLoose = false; 
  isDropInScreen = true ;
  timerCallbackInfo = "[finished]";
  initColliders();
  initSounds();
}

void initSounds(){
  minim = new Minim(this);
  plop_1 = minim.loadFile("./sounds/clip1.mp3");
  plop_2 = minim.loadFile("./sounds/clip2.mp3");
  plop_3 = minim.loadFile("./sounds/clip3.mp3");
  plop_4 = minim.loadFile("./sounds/clip4.mp3");
  plop_5 = minim.loadFile("./sounds/clip5.mp3");
  plop_6 = minim.loadFile("./sounds/clip6.mp3");

}

AudioPlayer triggerSample(float c){
  float maxvalue = 20 ;
  
  if ( c < maxvalue / 6) return plop_1 ;
  if ( c < maxvalue / 6) return plop_2 ;
  if ( c < maxvalue / 6) return plop_3 ;
  if ( c < maxvalue / 6) return plop_4 ;
  if ( c < maxvalue / 6) return plop_5 ;
  if ( c < maxvalue / 6) return plop_6 ;
  
  return plop_1 ;
}

void playSample(AudioPlayer sample){
  sample.rewind();
  sample.play();
}

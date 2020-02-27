#include <Wire.h>
#include "Adafruit_MPR121.h"
#include <FastLED.h>

#define stampL 9
#define startButton 7

Adafruit_MPR121 cap = Adafruit_MPR121();

uint16_t lasttouched = 0;
uint16_t currtouched = 0;

// LEDs DE SECOURS
#define NUM_LEDS 30
#define DATA_PIN 6
#define CLOCK_PIN 13
CRGB leds[NUM_LEDS];

const int FSR_PIN_r = A0;
const int FSR_PIN_l = A2;
const float VCC = 4.98;
const float R_DIV = 3230.0;
const float seuil = 500 ;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(stampL, INPUT);
  pinMode(startButton, INPUT);
  pinMode(FSR_PIN_r, INPUT);
  pinMode(FSR_PIN_l, INPUT);

  while (!Serial) { // needed to keep leonardo/micro from starting too fast!
    delay(10);
  }
  
  Serial.println("Adafruit MPR121 Capacitive Touch sensor test"); 
  
  // Default address is 0x5A, if tied to 3.3V its 0x5B
  // If tied to SDA its 0x5C and if SCL then 0x5D
  if (!cap.begin(0x5A)) {
    Serial.println("MPR121 not found, check wiring?");
    while (1);
  }
  Serial.println("MPR121 found!");
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);

  for (int i = 0 ; i < NUM_LEDS ; i ++){
    leds[i] = CRGB(255, 255, 255);
  }
  
  FastLED.show();
}

void loop() {
  currtouched = cap.touched();
  
  if (digitalRead(startButton)){
      Serial.println("{start:1}");
  }
  
  for (uint8_t i = 5 ; i < 9; i++) {
      // it if *is* touched and *wasnt* touched before, alert!
      if ((currtouched & _BV(i)) && !(lasttouched & _BV(i)) ) {
        String json = "{contact:";
        json += i ;
        json += "}";
        Serial.println(json);
  
      }
      // if it *was* touched and now *isnt*, alert!
      if (!(currtouched & _BV(i)) && (lasttouched & _BV(i)) ) {
        String json = "{released:";
        json += i ;
        json += "}";
  
        Serial.println(json);
      }
  }

  // right stamp
  int fsrADC_r = analogRead(FSR_PIN_r);  
  if (fsrADC_r != 0) {
    float force;
    // Break parabolic curve down into two linear slopes:
    if (calculateFSR(fsrADC_r) <= 600) 
      force = (calculateConductance(fsrADC_r) - 0.00075) / 0.00000032639;
    else{
      force =  calculateConductance(fsrADC_r) / 0.000000642857;
      if (force >= seuil + 200){
        Serial.println("{force_r: " + String(force) + "}");
      }
    }
  }

  //left stamp
  int fsrADC_l = analogRead(FSR_PIN_l);
  if (fsrADC_l != 0) {
    float force;
    // Break parabolic curve down into two linear slopes:
    if (calculateFSR(fsrADC_l) <= 600) 
      force = (calculateConductance(fsrADC_l) - 0.00075) / 0.00000032639;
    else{
      force =  calculateConductance(fsrADC_l) / 0.000000642857;
      if (force >= seuil){
        Serial.println("{force_l: " + String(force) + "}");
      }
    }
  }
  
    lasttouched = currtouched; //reset state
    delay(100);

}


float calculateFSR(int valuePin){
  float fsrV = valuePin * VCC / 1023.0; // ADC reading to calculate voltage
  return R_DIV * (VCC / fsrV - 1.0);// calculate FSR
}

float calculateConductance(int valuePin){
  return 1.0 / calculateFSR(valuePin); // Calculate conductance
}

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(4, INPUT);
  pinMode(7, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  //xSerial.println(digitalRead(7));
  String json = "{contact:";
  json += digitalRead(4);
  json += "}";

  Serial.println(json);
  delay(200);
}

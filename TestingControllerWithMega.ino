//Nick and Tristan's code for tqo game controllers and arduino
//Feb 17, 2017

//vars for controller 1
const int up1 = 30;
const int down1 = 24;
const int left1 = 26;
const int right1 = 28;
const int analog1 = A1;

//vars for controller 2

const int up2 = 9;
const int down2 = 8;
const int left2 = 7;
const int right2 = 6;
const int analog2 = A2;

void setup() {
  pinMode(up1, INPUT_PULLUP);
  pinMode(down1, INPUT_PULLUP);
  pinMode(left1, INPUT_PULLUP);
  pinMode(right1, INPUT_PULLUP);

  pinMode(up2, INPUT_PULLUP);
  pinMode(down2, INPUT_PULLUP);
  pinMode(left2, INPUT_PULLUP);
  pinMode(right2, INPUT_PULLUP);

  pinMode(13, OUTPUT);

  Serial.begin(9600);
  Serial.write('h');

}

void loop() {
  byte message[4];

  message[0] = 0b00010000;

  message[0] += (!digitalRead(up1)) << 3;
  message[0] += (!digitalRead(down1)) << 2;
  message[0] += (!digitalRead(left1)) << 1;
  message[0] += (!digitalRead(right1)) << 0;

  message[1] = (analogRead(analog1)) >> 2;

  message[2] = 0b00100000;
  message[3] = 0b00100000;
  //  message[2] += (!digitalRead(up2)) << 3;
  //  message[2] += (!digitalRead(down2)) << 2;
  //  message[2] += (!digitalRead(left2)) << 1;
  //  message[2] += (!digitalRead(right2)) << 0;
  //
  //  message[3] = (analogRead(analog2)) >> 2;

  digitalWrite(13, LOW);
  if (Serial.available()) {
    if (Serial.read() == 'h') {
      digitalWrite(13, HIGH);// to test communication
      Serial.write(message[0]);
      Serial.write(message[1]);
      Serial.write(message[2]);
      Serial.write(message[3]);
    }
  }
  else {
    digitalWrite(13, LOW);
  }
  delay(100);
}

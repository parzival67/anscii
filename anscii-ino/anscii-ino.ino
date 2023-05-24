#define USE_PCA9685_SERVO_EXPANDER  
#define MAX_EASING_SERVOS 17
#include "ServoEasing.hpp"

ServoEasing Servo1AtPCA9685(PCA9685_DEFAULT_ADDRESS);
String txt;
int s[16], r = 0, t= 0;

void blinkLED();
void getAndAttach16ServosToPCA9685Expander(uint8_t aPCA9685I2CAddress);

void setup(){
    Serial.begin(9600);
    
    if (Servo1AtPCA9685.InitializeAndCheckI2CConnection(&Serial)) {
        while (true) {
            blinkLED();
        }
    } else {
        Serial.println(F("Attach servo to port 0 of PCA9685 expander"));
        if (Servo1AtPCA9685.attach(7, 100) == INVALID_SERVO) {
            Serial.println(
                    F("Error attaching servo - maybe MAX_EASING_SERVOS=" STR(MAX_EASING_SERVOS) " is to small to hold all servos"));
            while (true) {
                blinkLED();
            }
        }
    }
    getAndAttach16ServosToPCA9685Expander(PCA9685_DEFAULT_ADDRESS);   
     
    for (uint_fast8_t i = 0; i < PCA9685_MAX_CHANNELS; ++i) {
      ServoEasing::ServoEasingArray[i]->setEasingType(EASE_CIRCULAR_OUT);      
    }
    delay(500);
}

void loop(){
  //Servo1AtPCA9685.setEasingType(EASE_CUBIC_IN_OUT);
  /*ServoEasing::ServoEasingArray[8]->setEasingType(EASE_CUBIC_IN_OUT);
  ServoEasing::ServoEasingArray[8]->startEaseTo(30, 30);
  delay(5000);
  ServoEasing::ServoEasingArray[8]->startEaseTo(130, 30);
  delay(5000);*/
  
  if(Serial.available()){
    txt = Serial.readStringUntil('x');
    r = 2;
    t = 0;
    for (int i=2; i < txt.length(); i++){
    if(txt.charAt(i) == ' '){
        s[t] = txt.substring(r, i).toInt(); 
        //Serial.println(txt.substring(r, i).toInt());
        r=(i+1); 
        t++; 
      }      
    }    
    if(txt.charAt(0) == 'A'){
      for(int i = 0; i <= 15; i++)
        ServoEasing::ServoEasingArray[i+1]->write(s[i]);
    }
    if(txt.charAt(0) == 'B'){
      for(int i = 0; i <= 15; i++)
        ServoEasing::ServoEasingArray[i+1]->startEaseTo(s[i], 40);
    }
  }
}

void blinkLED() {
    digitalWrite(LED_BUILTIN, HIGH);
    delay(100);
    digitalWrite(LED_BUILTIN, LOW);
    delay(100);
}

void getAndAttach16ServosToPCA9685Expander(uint8_t aPCA9685I2CAddress) {
    ServoEasing *tServoEasingObjectPtr;

    Serial.print(F("Get ServoEasing objects and attach servos to PCA9685 expander at address=0x"));
    Serial.println(aPCA9685I2CAddress, HEX);
    for (uint_fast8_t i = 0; i < PCA9685_MAX_CHANNELS; ++i) {
        tServoEasingObjectPtr = new ServoEasing(aPCA9685I2CAddress);
        if (tServoEasingObjectPtr->attach(i) == INVALID_SERVO) {
            Serial.print(F("Address=0x"));
            Serial.print(aPCA9685I2CAddress, HEX);
            Serial.print(F(" i="));
            Serial.print(i);
            Serial.println(
                    F(
                            " Error attaching servo - maybe MAX_EASING_SERVOS=" STR(MAX_EASING_SERVOS) " is to small to hold all servos"));

        }        
    }
}
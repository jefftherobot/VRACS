#include <TimedAction.h>
#include <NewSoftSerial.h>

#define SerInToArdu 2
#define SerOutFrmArdu 9

const int reedPin = 4;    // the pin that the pushbutton is attached to
const int ledPin = 13;       // the pin that the LED is attached to
const int relayPin = 12;

TimedAction fireAction = TimedAction(100,fire);
TimedAction roundCounterAction = TimedAction(25,roundCounter);

// Variables will change:
int roundTotal = 100;   // counter for the number of button presses
int buttonState;         // current state of the button
int lastButtonState = LOW;     // previous state of the button
boolean reload = 0;
char text[] = "   RELOAD    ";

String spacers;

NewSoftSerial mySerialPort(SerInToArdu,SerOutFrmArdu);
//  The above creates the serial channel we will use.

void setup() {
  pinMode(reedPin, INPUT);

  pinMode(ledPin, OUTPUT);
  pinMode (relayPin, OUTPUT);
  
  pinMode(SerOutFrmArdu,OUTPUT);
  pinMode(SerInToArdu,INPUT);
  // initialize serial communication:
  mySerialPort.begin(9600);
  
  Serial.begin(9600);

  
  mySerialPort.print("xxx"+String(roundTotal));
}


void loop() {
  roundCounterAction.check();
  fireAction.check();
 // mySerialPort.print("z");
 // mySerialPort.print(B11111110,BYTE);
  
  //delay(1000);
   //showText();
  // mySerialPort.print("z");
  // mySerialPort.print(B00000000,BYTE);
  
   //mySerialPort.print(B01111111,BYTE);
  //mySerialPort.print(B00000010,BYTE);
   
   //delay(1000);
}

void fire(){
 if (Serial.available()) {
    byte val = Serial.read();
    if (val == 'f') {
     digitalWrite (relayPin, HIGH);
    }
    if (val == 'o') {
      digitalWrite (relayPin, LOW);
    }
 }
   
}

void roundCounter(){
 if(!reload){
    buttonState = digitalRead(reedPin);

    if (buttonState != lastButtonState) {
        if(buttonState == HIGH){
        //Serial.println("on");
        if(roundTotal > 0){
          roundTotal--;
        }else{
         roundTotal=0;
          reload=true;
        }
         if(roundTotal<10){
            spacers = "xxx";
         }else if (roundTotal>=10 && roundTotal<=99){
            spacers = "xx";
         }else{
           spacers = "x";
         }
         mySerialPort.print("v");
         mySerialPort.print(spacers+String(roundTotal));
         Serial.println(String(roundTotal));
       }
        digitalWrite(ledPin, buttonState);
      } 

     lastButtonState = buttonState;
   }else{
     showText(); 
   }
 }

void showText(){
  for (int num = 0; num <= sizeof(text) - 5; num++) {
    mySerialPort.print(text[num]);
    mySerialPort.print(text[num+1]);
    mySerialPort.print(text[num+2]);
    mySerialPort.print(text[num+3]);
    delay(170);
 }
     
} 

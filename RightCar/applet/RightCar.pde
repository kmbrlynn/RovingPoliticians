//Kim Douglas
//Roving politicians - RIGHT CAR
//Spring 2009

//===================================================

int switchPin = 2;                        // switch input
int ledPin = 13;                          // pin for the LED
int leftMotor1 = 3;                       // first pin for left motor
int leftMotor2 = 4;                       // second pin for left motor
int rightMotor1 = 7;                      // first pin for right motor
int rightMotor2 = 8;                      // second pin for right motor
int enablePin = 9;                        // enable pin to turn the motors on via the h-bridge
int irReader = 1;                         // infrared range sensor (analog pin)
int irVal = 0;                            // infrared sensor value

void setup(){
  pinMode(switchPin, INPUT);              // declare switchPin as input
  pinMode(ledPin, OUTPUT);                // declare ledPin as output
  pinMode(leftMotor1, OUTPUT);            // declaring the motor pins as outputs
  pinMode(leftMotor2, OUTPUT);
  pinMode(rightMotor1, OUTPUT);
  pinMode(rightMotor2, OUTPUT);
  pinMode(enablePin, OUTPUT);
  pinMode(irReader, INPUT);                
  digitalWrite(enablePin, HIGH);           // set enablePin on HIGH so that motors can turn on
  digitalWrite(ledPin, HIGH);              // set LED to off position... for LED, high = off and low = on
  Serial.begin(9600);
}

void loop(){
  if (digitalRead(switchPin) == LOW) {    //if the switch is turned on
    irVal = analogRead(irReader);
    Serial.println(irVal);                 // serial monitor for IR sensor
    if (irVal < 205){                      // if the sensor is further than 11 inches from an object, then...
      carForwards();                       // make the car go forwards
    }
    else if (irVal > 205){                 // if sensor is closer than 11 inches to an object, then...                 
      motorStop();                         // do these things... duh
      lightUp();
      carReverse();                         
      motorStop();                         
      carPivot();                            
      motorStop();                           
      carForwards();                          
    }
  }
  else {                                   // if the switch is turned off
    digitalWrite(leftMotor1, HIGH);                 // left motor stop
    digitalWrite(leftMotor2, HIGH);
    digitalWrite(rightMotor1, LOW);               // right motor stop
    digitalWrite(rightMotor2, LOW); 
  }
}

void carForwards(){                        // function that makes the car go forwards
  digitalWrite(leftMotor1, LOW);                   // left motor goes forwards
  digitalWrite(leftMotor2, HIGH);
  digitalWrite(rightMotor1, HIGH);                  // right motor goes forwards
  digitalWrite(rightMotor2, LOW);
}

void motorStop(){                          // function that makes motors pause
  Serial.println("stopped");                       // serial monitor for car stopping
  digitalWrite(leftMotor1, HIGH);               
  digitalWrite(leftMotor2, HIGH);
  digitalWrite(rightMotor1, LOW);    
  digitalWrite(rightMotor2, LOW);
  delay(1000);
}

void carReverse(){                         // function that makes the car reverse
  Serial.println("reverse");                       // serial monitor for car reversing
  digitalWrite(leftMotor1, HIGH);                  // left motor goes backwards
  digitalWrite(leftMotor2, LOW);
  digitalWrite(rightMotor1, LOW);                 // right motor goes backwards
  digitalWrite(rightMotor2, HIGH);
  delay(750);
}

void carPivot(){                           //function that makes the car pivot
  Serial.println("pivot right!");                   // serial monitor for car turning left
  digitalWrite(leftMotor1, LOW);                  // left motor goes forwards
  digitalWrite(leftMotor2, HIGH);
  digitalWrite(rightMotor1, LOW);                  // right motor goes backwards
  digitalWrite(rightMotor2, HIGH);
  delay(1000);
}

void lightUp(){                            //function that turns the LED on for 3 seconds
  Serial.println("light up");                      // serial monitor for LED turning on
  digitalWrite(ledPin, LOW);                       // turn on LED 
  delay(200);   
  digitalWrite(ledPin, HIGH);                      // turn off LED
  delay(200); 
  digitalWrite(ledPin, LOW);                       // turn on LED 
  delay(200);   
  digitalWrite(ledPin, HIGH);                      // turn off LED
  delay(200); 
  digitalWrite(ledPin, LOW);                       // turn on LED 
  delay(3000);   
  digitalWrite(ledPin, HIGH);                      // turn off LED
}

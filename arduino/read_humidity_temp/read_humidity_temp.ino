#include <Wire.h>
#include "SparkFunHTU21D.h"

//Create an instance of the object
HTU21D myHumidity;
bool turnHumidifierOn = false;
const int HUMIDIFIER = 10; 

void setup()
{
  Serial.begin(9600);
  pinMode(HUMIDIFIER, OUTPUT);  
  myHumidity.begin();
}

void loop()
{
  float humd = myHumidity.readHumidity();
  float temp = myHumidity.readTemperature();

  //turn humidifier on to prevent EHR reaching critical 80%
  if (humd > 75){
    digitalWrite(HUMIDIFIER, HIGH);
  } else {
    digitalWrite(HUMIDIFIER, LOW);
  }

  String passString = String(temp) + "," + String(humd);
  Serial.println(passString);
  delay(600000);
  //delay(10000);
}

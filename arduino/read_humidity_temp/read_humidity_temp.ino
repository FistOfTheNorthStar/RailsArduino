#include <Wire.h>
#include "SparkFunHTU21D.h"

//Create an instance of the object
HTU21D myHumidity;

void setup()
{
  Serial.begin(9600);
  
  myHumidity.begin();
}

void loop()
{
  float humd = myHumidity.readHumidity();
  float temp = myHumidity.readTemperature();

  String passString = String(temp) + "," + String(humd);
  Serial.println(passString);
  delay(10000);
}

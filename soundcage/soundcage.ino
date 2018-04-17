#include <Wire.h>
#include <CircularBuffer.h>

// Pin definitions
#define TRIG 13
#define ECHO 12

// Thresholds, data pruning constants
#define DISTANCE_MAX 150
#define DISTANCE_HISTORY 4

/* Example code for the Adafruit TCS34725 breakout library */

/* Connect SCL    to analog 5
   Connect SDA    to analog 4
   Connect VDD    to 3.3V DC
   Connect GROUND to common ground */
   
/* Initialise with default values (int time = 2.4ms, gain = 1x) */
//Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_101MS, TCS34725_GAIN_4X);

/* Initialise with specific int time and gain values */
// Adafruit_TCS34725 tcs = Adafruit_TCS34725(TCS34725_INTEGRATIONTIME_700MS, TCS34725_GAIN_1X);

void setup(void) {
  Serial.begin(9600);
  
//  if (tcs.begin()) {
//    Serial.println("Found sensor");
//  } else {  
//    Serial.println("No TCS34725  found ... check your connections");
//    while (1);
//  }

  pinMode(TRIG, OUTPUT); // Ultrasound output
  pinMode(ECHO, INPUT); // Ultrasound input
  
}

float bufferAverage(CircularBuffer<int,DISTANCE_HISTORY> b, int i1, int i2) {
  float sum = 0.0;
  for(int i = i1; i < i2; i++) {
    sum += b[i];
  }
  return sum / (float)(i2 - i1);
}

/*
 * getCurrentDistance()
 *    Measures the distance from the ultrasound sensor.
 *    Output: sets `distance`
 */
int measuredDistance = 0;
long duration = 0.0;
CircularBuffer<int,DISTANCE_HISTORY> distanceMeasurements;
float getCurrentDistance() {
  digitalWrite(TRIG, LOW); // Turn off ultrasound signal
  delayMicroseconds(2); // Ensure cleared
  digitalWrite(TRIG, HIGH); // Send 10µs of ultrasound signal
  delayMicroseconds(10);
  digitalWrite(TRIG, LOW); // Turn off ultrasound signal
  duration = pulseIn(ECHO, HIGH, 10000); // Reads ultrasound, returns travel time in µs
  if(duration == 0) return DISTANCE_MAX;
  measuredDistance = duration * 0.034 / 2; // Calculating the distance
  if(measuredDistance < DISTANCE_MAX) {
    distanceMeasurements.push(measuredDistance); 
    return measuredDistance;
  }
  else {
    distanceMeasurements.push(DISTANCE_MAX); 
    return DISTANCE_MAX;
  }
}

float currentDistance;
String msg_buffer;
void loop(void) {
  uint16_t r, g, b, c, colorTemp, lux;
  
 // tcs.getRawData(&r, &g, &b, &c);
//  colorTemp = tcs.calculateColorTemperature(r, g, b);
//  lux = tcs.calculateLux(r, g, b);

//  getCurrentDistance();
//  currentDistance = bufferAverage(distanceMeasurements, 0, distanceMeasurements.size());
  while(Serial.available() > 0) {
    char inByte = Serial.read();

    if (inByte != '\n') // If the byte is NOT an ASCII 10 \n character, add it to the buffer.
    {
      msg_buffer += inByte;
    }
    else // ... otherwise, if it is an ASCII 10 \n character, the buffer is full so decode it.
    {
      currentDistance = getCurrentDistance();
//      currentDistance = bufferAverage(distanceMeasurements, 0, distanceMeasurements.size());
      Serial.println(currentDistance);
      msg_buffer = "";
    }
    
  }
  
//  Serial.println(currentDistance);
}

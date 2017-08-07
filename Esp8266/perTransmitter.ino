#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <string>
#include "exponential.h"

#define CONFIG 2

/* DEVICE 1 */
#if CONFIG == 1
char *ssid = "ESPsoftAP_01";
float dBm = 20.5;
unsigned int serverPort = 4210;
unsigned int localPort = 2390;
#endif

/* DEVICE 2 */
#if CONFIG == 2
char *ssid = "ESPsoftAP_02";
float dBm = 20.5;
unsigned int serverPort = 4220;
unsigned int localPort = 2290;
#endif

IPAddress receiverIP(0, 0, 0, 0);
WiFiUDP Udp;

// total # packets to send at the transmitter
// this variable need to be modified when doing the experiment to save time!
unsigned long NUM_PACKETS = 2000000;
////////////////////////////////////

// using different packet size to calculate the WiFi transmission rate
//const int packetSize = 2048;
//const int packetSize = 1024;
const int packetSize = 512;
//const int packetSize = 128;
////////////////////////////////////

// setup exponential random delay class
const double meanDelay = 0;
const int generatorSeed = 123;
const int offset = 10;
ExponentialDist randomNum(meanDelay, generatorSeed, offset); // constrcutor

std::string message(packetSize, 'A');

int num_transmission = 0; // count number of successful transmission
//unsigned int tmp = 0;

unsigned long sendPacket(IPAddress& address) {
  if (!Udp.beginPacket(address, serverPort)) {
    Serial.println("Error in Udp.beginPacket()");
  }
  Udp.write(message.c_str());
  // check whether transmitter successfully transmitted the packets
  if (Udp.endPacket()) {
    ++num_transmission;
  }
}

// attempt to connect to Wifi network:
void connectToServer() {
  //Clear old configuration
  WiFi.softAPdisconnect();
  WiFi.disconnect();
  
  WiFi.mode(WIFI_STA); // STA to AP
  
  WiFi.setOutputPower(dBm);
  delay(300);
  
  Serial.print("Attempting to connect to SSID: ");
  Serial.print(ssid);
  
  WiFi.begin(ssid);
  
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(1000);
  }
  Serial.println("Connected to wifi");
  Serial.println("");
  
  Serial.println("\nStarting connection to server...");
  if (!Udp.begin(localPort)) {
    Serial.println("UDP connection failed");
  }
}

void setup() {
  Serial.begin(115200);
  Serial.println();
  Serial.println();

  Serial.print("Using configuration: ");
  Serial.println(CONFIG);
  
  connectToServer();
}

unsigned long i = 0;                    // count number of sending times

void loop() {

  // if choice true, generate inf packets 
  bool choice = false;
  ///////////////////////////////

  // generate inf packets
  if(choice) {
    sendPacket(receiverIP); // send an packet to server
    // delay(randomNum.generate()); // add random exponential delay
    delayMicroseconds(100);         // us, add constant delay below 1us
    // delay(20);
    ///////////////////////////////

  }
  // generate certain amount of packets
  else {
   if( i < NUM_PACKETS) {
        sendPacket(receiverIP);        // send an packet to access point
        // delay(randomNum.generate()); // exponential random delay
        delayMicroseconds(100);        // constant delay
        // delay(15);
        ++i;
        /////////////////////////////
    }
    else {
      // print how many packets are sent
      Serial.printf("total successful transmission: %d\n", num_transmission);
      delay(1000000);
    }
  }
} // end loop

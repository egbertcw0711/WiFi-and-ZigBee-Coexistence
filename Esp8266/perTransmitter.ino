#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <string>
#include "exponential.h"

#define CONFIG 1

/* DEVICE 1 */
#if CONFIG == 1
char *ssid = "ESPsoftAP_01";
char *pass = "nickkoester_and_egbertcw";
float dBm = 20.5; // add the transmitter power
unsigned int serverPort = 4210;
unsigned int localPort = 2390;
#endif

/* DEVICE 2 */
#if CONFIG == 2
char *ssid = "ESPsoftAP_02";
char *pass = "nickkoester_and_egbertcw";
float dBm = 20.5;
unsigned int serverPort = 4220;
unsigned int localPort = 2290;
#endif

IPAddress receiverIP(0, 0, 0, 0);
WiFiUDP Udp;

//int NUM_PACKETS = 50000;

/* config different packet size for transmission */
//const int packetSize = 1500;
//const int packetSize = 600;
const int packetSize = 1112;

const double arrivalRate = 1;
const int generatorSeed = 1;

std::string message(packetSize, 'A');
ExponentialDist randomNum(arrivalRate, generatorSeed);

unsigned long sendPacket(IPAddress& address) {
  if (!Udp.beginPacket(address, serverPort)) {
    Serial.println("Error in Udp.beginPacket()");
  }
  
  Udp.write(message.c_str());
  
  if (!Udp.endPacket()) {
    Serial.println("Error in Udp.endPacket()");
  }
}

// attempt to connect to Wifi network:
void connectToServer() {
  //Clear old configuration
  WiFi.softAPdisconnect();
  WiFi.disconnect();
  WiFi.mode(WIFI_STA);
  WiFi.setOutputPower(dBm);
  delay(100);
  
  Serial.print("Attempting to connect to SSID: ");
  Serial.print(ssid);
  
  WiFi.begin(ssid, pass);
  
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

void loop() {
  Serial.println("Sending packets...");

  /* Here is used for testing ZigBee Throughput with and without WiFi Interference */
   sendPacket(receiverIP); // send an packet to server
//   delay(randomNum.generate()); // add random exponential delay
   delay(1);                  // add constant delay
  /* ***************************************************************************** */
  
  /* Here is used for testing WiFi Throughput with and without ZigBee Interference */
//  for(int i = 0; i < NUM_PACKETS; ++i) {
//      sendPacket(receiverIP); // send an packet to server
//      delay(randomNum.generate());
//  }
//
//  Serial.println("Done");
//  while(true) {
//    delay(10000);
//  }
  /* **************************************************************************** */

}

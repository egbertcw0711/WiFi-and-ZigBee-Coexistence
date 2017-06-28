#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <string>
#include "exponential.h"

#define CONFIG 1

/* DEVICE 1 */
#if CONFIG == 1
char *ssid = "ESPsoftAP_01";
char *pass = "nickkoester";
float dBm = 20.5;
unsigned int serverPort = 4210;
unsigned int localPort = 2390;
#endif

/* DEVICE 2 */
#if CONFIG == 2
char *ssid = "ESPsoftAP_02";
char *pass = "nickkoester";
float dBm = 20.5;
unsigned int serverPort = 4220;
unsigned int localPort = 2290;
#endif

IPAddress receiverIP(0, 0, 0, 0);
WiFiUDP Udp;

/* TRANSMITTER PARAMETERS */
int NUM_PACKETS = 50000;

/* config different packet size for transmission */
//const int packetSize = 1500;
//const int packetSize = 600;
const int packetSize = 1112;

/* using different packet size to calculate the WiFi transmission rate */
//const int packetSize = 1100;

const double arrivalRate = 1;
const int generatorSeed = 1;

std::string message(packetSize, 'A');
ExponentialDist randomNum(arrivalRate, generatorSeed);

int num_transmission = 0; // count number of successful transmission
unsigned long sendPacket(IPAddress& address) {
  //if (!Udp.beginPacket(address, serverPort)) {
    //Serial.println("Error in Udp.beginPacket()");
  //}
  Udp.beginPacket(address, serverPort);
  Udp.write(message.c_str());
//  Udp.endPacket();
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
  WiFi.mode(WIFI_STA);
  WiFi.setOutputPower(dBm);
  delay(300);
  
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
//  WiFi.printDiag(Serial);
}

void setup() {
  Serial.begin(115200);
  Serial.println();
  Serial.println();

  Serial.print("Using configuration: ");
  Serial.println(CONFIG);
  
//  pinMode(16, OUTPUT);
  connectToServer();
}

int i = 0;                    // count number of sending times

void loop() {
  //Serial.println("Sending packets...");

  /* Here is used for testing ZigBee Throughput with and without WiFi Interference */
////   digitalWrite(16, HIGH);
//   sendPacket(receiverIP); // send an packet to server
////   digitalWrite(16, LOW);
//////   delay(randomNum.generate()); // add random exponential delay
//////   delay(0.3);                      // ms, used for delay above 1ms
//   delayMicroseconds(100);         // us, add constant delay below 1us
  /* ***************************************************************************** */
  
  /* Here is used for testing WiFi Throughput with and without ZigBee Interference */
  if( i < NUM_PACKETS) {
      sendPacket(receiverIP);        // send an packet to access point
//      delay(randomNum.generate()); // exponential random delay
      delayMicroseconds(500);      // constant delay
//      delay(200);
      ++i;
  }
  else {
    // print how many packets are sent
    Serial.printf("total successful transmission: %d\n", num_transmission);
    delay(10000);
  }
  /* **************************************************************************** */
} // end loop

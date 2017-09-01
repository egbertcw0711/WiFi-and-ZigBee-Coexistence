#include <Ticker.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

#define CONFIG 2

/* DEVICE 1 */
#if CONFIG == 1
char *ssid = "ESPsoftAP_01";
int channel = 11;
float dBm = 20.5;
unsigned int localUdpPort = 4210;  // local port to listen on
#endif

/* DEVICE 2 */
#if CONFIG == 2
char *ssid = "ESPsoftAP_02";
int channel = 11;
float dBm = 20.5;
unsigned int localUdpPort = 4220;  // local port to listen on
#endif

WiFiUDP Udp;

// timing 
const double timeInterval = 1;   // unit is seconds
const int MS = 1000;             // used for convert seconds to ms
const int US = 1000000;          // used for convert seconds to us
bool printFlag = false;

// the packet sizes below is using for calculate the WiFi transmission rate 
const int PACKET_SIZE = 1500;
//const int PACKET_SIZE = 1472; // ip header 20 byte, udp header 8 byte
//const int PACKET_SIZE = 472;
//const int PACKET_SIZE = 512;
//const int PACKET_SIZE = 128;

double timestamp = 0;
double packetsReceived = 0;

// use for calculating throughput
double perPktRecvd = 0;
double throughput = 0;

Ticker tick;

// print time, number of received packet and WiFi throughput
void benchOutput() {
  Serial.print(timestamp);
  Serial.print("\t");
  Serial.print(packetsReceived);
  Serial.print("\t");
  Serial.println(throughput); // Kbps
}

// calculate the throughput
void capture() {
  timestamp = micros() / US; // unit in seconds
  throughput = perPktRecvd * PACKET_SIZE * 8.0 / (1000 * timeInterval); // App TMT unit in Kbps 
//  throughput = 500 * perPktRecvd * 8.0 / (1000 * timeInterval); // MAC TMT
  perPktRecvd = 0;
  printFlag = true;
}

void setupAccessPoint() {
  //Clear old configuration
  WiFi.softAPdisconnect();
  WiFi.disconnect();
  WiFi.mode(WIFI_AP); // receiver:AP, STA -> AP
  WiFi.setOutputPower(dBm);
  delay(100);

  Serial.print("Setting soft-AP ... ");
  boolean result = WiFi.softAP(ssid, NULL, channel);
  if(result == true)
  {
    Serial.println("Ready");
  }
  else
  {
    Serial.println("Failed!");
  }
}

void receiveMessage() {
  int packetSize = Udp.parsePacket();

  if(packetSize) {
    packetsReceived++;
    perPktRecvd++;
  }
}

void setup()
{
  Serial.begin(115200);
  Serial.println();
  Serial.println();

  Serial.print("Using configuration: ");
  Serial.println(CONFIG);

  setupAccessPoint();
  WiFi.setPhyMode(WIFI_PHY_MODE_11N);

  WiFi.printDiag(Serial); // summary the settings
  
  Udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);

  tick.attach(timeInterval, capture);
  Serial.println("Starting count...");
}

void loop()
{
  receiveMessage();
  // print info once every 1 second
  if(printFlag) {
    benchOutput();
    printFlag = false;
  }
}

#include <Ticker.h>
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>

#define CONFIG 1

/* DEVICE 1 */
#if CONFIG == 1
char *ssid = "ESPsoftAP_01";
char *pass = "nickkoester";
int channel = 11;
float dBm = 20.5;
unsigned int localUdpPort = 4210;  // local port to listen on
#endif

/* DEVICE 2 */
#if CONFIG == 2
char *ssid = "ESPsoftAP_02";
char *pass = "nickkoester";
int channel = 11;
float dBm = 20.5;
unsigned int localUdpPort = 4220;  // local port to listen on
#endif

/** Server **/
WiFiUDP Udp;

/** Benchmarking **/
const double timeInterval = 1;   // unit is seconds
const int MS = 1000;             // used for convert seconds to ms
const int US = 1000000;          // used for convert seconds to us


//const int PACKET_SIZE = 600; // transmit packet size
const int PACKET_SIZE = 1112;

/* the packet size below is using for calculate the WiFi transmission rate */
//const int PACKET_SIZE = 1100;

double timestamp = 0;
double packetsReceived = 0;

double perPktRecvd = 0;
double throughput = 0;

Ticker tick;
bool printFlag = false;

void benchOutput() {
  Serial.print(timestamp);
  Serial.print("\t");
  Serial.print(packetsReceived);
  Serial.print("\t");
  Serial.println(throughput); // Kbps
}

void capture() {
  timestamp = micros() / US; // unit in seconds
  throughput = perPktRecvd * PACKET_SIZE * 8.0 / (1000 * timeInterval); // unit in Kbps
  perPktRecvd = 0;
  printFlag = true;
}

void setupAccessPoint() {
  //Clear old configuration
  WiFi.softAPdisconnect();
  WiFi.disconnect();
  WiFi.mode(WIFI_AP);
  WiFi.setOutputPower(dBm);
  delay(100);

  Serial.print("Setting soft-AP ... ");
  boolean result = WiFi.softAP(ssid, pass, channel);
  if(result == true)
  {
    Serial.println("Ready");
  }
  else
  {
    Serial.println("Failed!");
  }
//  WiFi.printDiag(Serial);
}

void receiveMessage() {
  int packetSize = Udp.parsePacket();

  if(packetSize == PACKET_SIZE) {
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

  Udp.begin(localUdpPort);
  Serial.printf("Now listening at IP %s, UDP port %d\n", WiFi.localIP().toString().c_str(), localUdpPort);

  tick.attach(timeInterval, capture);
  Serial.println("Starting count...");
}

void loop()
{
  receiveMessage();

  if(printFlag) {
    benchOutput();
    printFlag = false;
  }
}

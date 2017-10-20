#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <string>
#include <Ticker.h> // use for batch experiment
//#include "exponential.h" // use exponential delay

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

// timing
const double TIME_INTERVAL = 5; // in seconds
double timeStamp = 0;
bool printFlag = false;

Ticker tick;

// total # packets to send at the transmitter
//unsigned long NUM_PACKETS = 2000000;

// using different packet size to calculate the WiFi transmission rate
const int packetSize = 1500;

// Delay 50us to 100 ms
double Delay[13] = {50, 100, 200, 300, 500, 1000, 2000, 4000, 8000, 15000, 20000, 50000, 100000};
double currentDelay;

/* setup exponential random delay class
  //const double meanDelay = 50000; // {0, 0.1, 0.2, 0.3, 0.5, 1, ,2 ,4 ,8, 10, 15, 20, 50, 100, 200}
  //const int generatorSeed = 123;
  //const int offset = 0;
  //ExponentialDist randomNum(meanDelay, generatorSeed, offset); // constrcutor
*/

// Initial values
int delaySetting = 0;                    // count number of sending times
unsigned long t2 = 0;
unsigned long t1;
int count = 0;
int count_till_print = 20;
bool experimentDone = false;

std::string message(packetSize, 'A');

int num_transmission = 0; // count # successful transmission

// Function to send packet
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
  WiFi.setPhyMode(WIFI_PHY_MODE_11N); // set WiFi PHY mode

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

//void benchOut() {
//    Serial.println(t1-t2);
//    count += 1;
//    if(count == 200) {
//      count = 0;
//      delaySetting += 1;
//      Serial.println("delay changed ... ");
//      if(delaySetting == 13) {
//       Serial.println("finish the experiment!\n");
//       delay(999999999);
//       }
//      delay(200000);
//    }
//}

void printStatus() {
  Serial.print(timeStamp);
  Serial.print("\t");
  Serial.println(num_transmission);
}

void capture() {
  timeStamp = micros() / 1000000; // change to unit in second
  count_till_print = count_till_print - 1;
}

void setup() {
  Serial.begin(500000);
  Serial.println();
  Serial.println();

  Serial.print("Using configuration: ");
  Serial.println(CONFIG);

  connectToServer();
  // pinMode(16, OUTPUT); // set PIN16 as an output

  
  WiFi.printDiag(Serial);

  // timer interrupt every 5 seconds
  tick.attach(TIME_INTERVAL, capture);
  yield();
  
  Serial.println("Starting transmitting...");
}

void loop() {
  
  while(experimentDone == false){
    // t1 = micros();
    /* test esp delay distribution
      // reduce the serial.println()
      if(t2 % 2000 == 0){
      benchOut(); }  */
    
    sendPacket(receiverIP);                     // send an packet to server
    
    // t2 = micros();

    // Delay transmission
    if ( currentDelay < 1000 ){
      yield();
      delayMicroseconds(Delay[delaySetting]);   // in microseconds
    } else {
      // check that this is accurate time
      delay(currentDelay / 1000);               // in milliseconds
    }

    // Wait for 20 captures (20 * 5 seconds = 100 seconds
    if (count_till_print == 0) {
      count_till_print = 20;
      ++delaySetting;                     // Change delay
      currentDelay = Delay[delaySetting];
      

      // Stop program if we go through all delays
      if (delaySetting == 13) {
        Serial.println("experiment done!");
        experimentDone = true;
        break;
      }
      else{
        Serial.println("Change the delay (us) ...\nFrom");
        Serial.print(Delay[delaySetting-1]); Serial.print(" to ");
        Serial.println(currentDelay);
      }
      
      delay(10000);  // 10 sec delay
    }
    
  } // end while experiment not done

} // end loop

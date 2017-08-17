#include <XBee.h>   // Xbee lib
#include <SoftwareSerial.h>

XBee xbee = XBee();
XBeeResponse response = XBeeResponse();
SoftwareSerial serial(2,3);

// create reusable response objects for responses we expect to handle 
Rx16Response rx16 = Rx16Response();

unsigned long otherError = 0; // other errors
unsigned long pktLoss = 0; // number of packet loss
unsigned long pktRcvd = 0; // number of packets received

// calculating throughput
unsigned perPktRcvd = 0;
unsigned time_elapse = 0;
double throughput = 0;

const unsigned dataLen = 10; // we need to change the data length

// print time, number of received packet and Xbee throughput
void benchOutput() {
  // calculate the throughput
  throughput = perPktRcvd * 1.0 / time_elapse * dataLen * 8.0; // App TMT unit in Kbps 

  Serial.print("time elapse: ");
  Serial.println(time_elapse);
  
  Serial.print("pktRcvd: ");
  Serial.println(pktRcvd);
  
  Serial.print("pktLoss: ");
  Serial.println(pktLoss);
  
  Serial.print("otherError: ");
  Serial.println(otherError);
  
  Serial.print("throughpout: ");
  Serial.println(throughput); // Kbps
}

void setup() {
  // start serial
  Serial.begin(57600);
  serial.begin(57600);
  xbee.setSerial(serial);

  Serial.println("Receiver Setup finished!");
}

// continuously reads packets, looking for RX16
void loop() {
    unsigned long start_time = millis();
    xbee.readPacket();
    
    if (xbee.getResponse().isAvailable()) { // got something
      // got a rx packet  
      if (xbee.getResponse().getApiId() == RX_16_RESPONSE) { // 0x81 = 129
        xbee.getResponse().getRx16Response(rx16);
        pktRcvd += 1;
        perPktRcvd += 1;
      }
      else {
        pktLoss += 1;    
      }
    } 
    else if (xbee.getResponse().isError()) {
      //nss.print("Error reading packet.  Error code: ");  
      //nss.println(xbee.getResponse().getErrorCode());
      // or flash error led
      // otherErrors include: CHECKSUM_FAILURE(1), 
      // PACKET_EXCEEDS_BYTE_ARRAY_LENGTH(2), UNEXPECTED_START_BYTE(3)
//      Serial.print(xbee.getResponse().getErrorCode());
      otherError += 1;
    } 

    time_elapse += millis() - start_time;
    if(time_elapse > 5000) {
      benchOutput();
      time_elapse = 0;
      perPktRcvd = 0;
    }
}

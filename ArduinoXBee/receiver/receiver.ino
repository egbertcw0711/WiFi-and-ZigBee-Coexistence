#include <XBee.h>   // Xbee lib
#include <SoftwareSerial.h>

XBee xbee = XBee();
XBeeResponse response = XBeeResponse();
SoftwareSerial serial(2,3);

// create reusable response objects for responses we expect to handle 
Rx16Response rx16 = Rx16Response();

unsigned int otherError = 0; // other errors
unsigned int pktLoss = 0; // number of packet loss
unsigned int pktRcvd = 0; // number of packets received
unsigned int rest = 0; // the rest

// calculating throughput
unsigned int perPktRcvd = 0;
unsigned long time_elapse = 0;
unsigned long start_time = 0;
unsigned long end_time = 0;

double throughput = 0;

const unsigned dataLen = 10; // we need to change the data length

// print time, number of received packet and Xbee throughput
void benchOutput() {
  // calculate the throughput
  double timing = time_elapse / 1000;
  throughput = perPktRcvd * dataLen * 8.0 / timing; // App TMT unit in Kbps 
  // double avgTrans_time = perPktRcvd * 1000000.0 / time_elapse; // average delay: packet/sec

//  Serial.print("time elapse: ");  
//  Serial.print(timing);
//  Serial.print("\tperPktRcvd: ");
//  Serial.print("\t");
  Serial.print(perPktRcvd);
  
//  Serial.print("pktRcvd: ");
//  Serial.println(pktRcvd);
  
//  Serial.print("pktLoss: ");
  Serial.print("\t");
  Serial.print(pktLoss);
  
//  Serial.print("otherError: ");
//  Serial.println(otherError);

//  Serial.print("rest: ");
//  Serial.println(rest);
  
//  Serial.print("throughpout: ");
  Serial.print("\t");
  Serial.println(throughput); // Kbps
//  Serial.println("\n");

}

void setup() {
  // start serial
  Serial.begin(57600);
  serial.begin(57600);
  xbee.setSerial(serial);

//  pinMode(11, OUTPUT);
  Serial.println("\nReceiver Setup finished!");
}

// continuously reads packets, looking for RX16
void loop() {
    
    start_time = micros();
    
    if(xbee.readPacket(5000)){
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
      // otherErrors include: CHECKSUM_FAILURE(1), 
      // PACKET_EXCEEDS_BYTE_ARRAY_LENGTH(2), UNEXPECTED_START_BYTE(3)
      otherError += 1;
    } 
    else {
      rest += 1;
    }
    
    time_elapse += micros() - start_time;
    if(time_elapse >= 5000000) { // 5000ms
      benchOutput();
      time_elapse = 0;
      perPktRcvd = 0;
    }
}

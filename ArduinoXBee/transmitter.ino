#include <XBee.h>
#include <SoftwareSerial.h>
#include "exponential.h"
/*
This example is for Series 1 XBee
Sends a TX16 request with the value of analogRead(pin5) and checks the status response for success
*/

XBee xbee = XBee();
SoftwareSerial serial(2,3);

// allocate ten bytes
uint8_t payload[] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J' };

// variables to print out
unsigned int pktTransmitted = 0;
unsigned int pktLoss = 0;
unsigned int otherError = 0;

const unsigned long tot_transmission = 3000;
unsigned count = 0;
unsigned long start_time = 0;
unsigned long end_time = 0;
unsigned long run_time = 0;
unsigned long time_elapse = 0; // counting time

// set the exponential delay
const double meanDelay = 10; // 10 ms
const int generatorSeed = 12;
const int offset = 0;
ExponentialDist randomNum(meanDelay, generatorSeed, offset);

// 16-bit addressing: Enter address of remote XBee, typically the coordinator
Tx16Request tx = Tx16Request(0x00, payload, sizeof(payload));

TxStatusResponse txStatus = TxStatusResponse();

unsigned perPeriod = 0;
const unsigned dataLen = 10;
double throughput = 0;

// print time, number of received packet and Xbee throughput
void benchOutput() {
  throughput = perPeriod * dataLen * 8.0 * 1000.0 / time_elapse; // kbps
  //  Serial.print("time elapse: ");
  Serial.print(time_elapse);
  //  Serial.print("throughpout (kbps): ");
  Serial.print("\t");
  Serial.print(throughput); // Kbps
  //  Serial.print("perPeriod: ");
  //  Serial.println(perPeriod);
  Serial.print("\t");
  // Serial.print("pktTransmitted: ")
  Serial.println(pktTransmitted);
//  Serial.print("\t");
//  Serial.print("time elapse: ");
//  Serial.print(time_elapse);
//  Serial.print("\t");
//  Serial.print("pktLoss: ");
//  Serial.print(pktLoss);
//  Serial.print("\t");
//  Serial.print("otherError: ");
//  Serial.println(otherError);
}

void transmissionSummary() {
  Serial.print("total transmission:  ");
  Serial.println(tot_transmission);
  Serial.print("total number of packets transmitted successfully:  ");
  Serial.println(pktTransmitted);
  Serial.print("number of packet loss:  ");
  Serial.println(pktLoss);
  Serial.print("other errors:  ");
  Serial.println(otherError);
  Serial.println("\n");
}

void setup() {
  Serial.begin(57600);
  serial.begin(57600);
  xbee.setSerial(serial);
  
  Serial.println("\n");
  //  Serial.print("size of payload: ");
  //  Serial.println(sizeof(payload));

  //  pinMode(10, OUTPUT); // set PIN10 as output to measure the tranmission time
  Serial.println("Transmitter Setup finished!");
}

void loop() {
  if(count < tot_transmission){
      start_time = micros();
      
      xbee.send(tx);
      
      // after sending a tx request, we expect a status response
      // wait up to 5 seconds for the status response
      if (xbee.readPacket(5000)) {
          // got a response!
    
        // should be a zbnet tx status              
        if (xbee.getResponse().getApiId() == TX_STATUS_RESPONSE) {
           xbee.getResponse().getTxStatusResponse(txStatus);
          
           // get the delivery status, the fifth byte
             if (txStatus.getStatus() == SUCCESS) {
                // success.  time to celebrate
                pktTransmitted += 1;
                perPeriod += 1;
    
             } else {
                // the remote XBee did not receive our packet.
                pktLoss += 1;
             }
          }      
      } else if (xbee.getResponse().isError()) {  
        // otherErrors include: CHECKSUM_FAILURE(1), 
        // PACKET_EXCEEDS_BYTE_ARRAY_LENGTH(2), UNEXPECTED_START_BYTE(3)
          otherError += 1;
      } 
    
      // delay to make XBee tansmit a packet for every 10ms
      run_time = micros() - start_time;
      
      // delayMicroseconds(10000 - run_time); // this is constant delay

      // print the generated number to check whether it is exponential distribution
      Serial.println(randomNum.generate());
      delayMicroseconds(randomNum.generate() - run_time); // expoential random delay
      //////// the above programm takes appro. 10ms ////////
      
       time_elapse += micros() - start_time;
      
      // print the info about the transnitter every 5 second
//      if(time_elapse >= 5000000) {
//        benchOutput();
//        perPeriod = 0;
//        time_elapse = 0;
//      }
//      count += 1;
  }
  else {
    transmissionSummary();
    delay(300000);
  }
}

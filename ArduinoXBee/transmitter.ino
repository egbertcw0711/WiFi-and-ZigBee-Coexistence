#include <XBee.h>
#include <SoftwareSerial.h>

/*
This example is for Series 1 XBee
Sends a TX16 request with the value of analogRead(pin5) and checks the status response for success
*/

XBee xbee = XBee();
SoftwareSerial serial(2,3);

// allocate ten bytes
uint8_t payload[] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J' };

unsigned int pktTransmitted = 0;
unsigned int pktLoss = 0;
unsigned int otherError = 0;

unsigned long start_time = 0;
unsigned long end_time = 0;
unsigned long run_time = 0;
unsigned long time_elapse = 0; // counting time

// 16-bit addressing: Enter address of remote XBee, typically the coordinator
Tx16Request tx = Tx16Request(0x00, payload, sizeof(payload));

TxStatusResponse txStatus = TxStatusResponse();

unsigned perPeriod = 0;
const unsigned dataLen = 10;
double throughput = 0;

// print time, number of received packet and Xbee throughput
void benchOutput() {
  throughput = perPeriod * dataLen * 8.0 * 1000.0 / time_elapse; // kbps

  Serial.print("throughpout: ");
  Serial.println(throughput); // Kbps

  Serial.print("pktTransmitted: ");
  Serial.print(pktTransmitted);
  Serial.print("\t");
  Serial.print("pktLoss: ");
  Serial.print(pktLoss);
  Serial.print("\t");
  Serial.print("otherError: ");
  Serial.println(otherError);
}

void setup() {
  Serial.begin(57600);
  serial.begin(57600);
  xbee.setSerial(serial);
  
  Serial.println("\n");
//  Serial.print("size of payload: ");
//  Serial.println(sizeof(payload));

  pinMode(10, OUTPUT); // set PIN10 as output to measure the tranmission time
  Serial.println("Transmitter Setup finished!");
}

void loop() {
    start_time = micros();
    
    xbee.send(tx);
    
    // after sending a tx request, we expect a status response
    // wait up to 5 seconds for the status response
    if (xbee.readPacket(5000)) {
        // got a response!

      // should be a znet tx status              
      if (xbee.getResponse().getApiId() == TX_STATUS_RESPONSE) {
         xbee.getResponse().getTxStatusResponse(txStatus);
        
         // get the delivery status, the fifth byte
           if (txStatus.getStatus() == SUCCESS) {
              // success.  time to celebrate
              pktTransmitted += 1;
              perPeriod += 1;

           } else {
              // the remote XBee did not receive our packet. is it powered on?
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
    delayMicroseconds(10000 - run_time);
    // the above programm takes appro. 10ms
    
    time_elapse += micros() - start_time;
    // print the info about the transnitter
    if(time_elapse >= 5000000) { // 5000ms
      benchOutput();
      perPeriod = 0;
      time_elapse = 0;
    }
}

#include <XBee.h>
#include <SoftwareSerial.h>

/*
This example is for Series 1 XBee
Sends a TX16 request with the value of analogRead(pin5) and checks the status response for success
Note: In my testing it took about 15 seconds for the XBee to start reporting success, so I've added a startup delay
*/

XBee xbee = XBee();
SoftwareSerial serial(2,3);

// allocate ten bytes
uint8_t payload[] = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J' };

unsigned pktTransmitted = 0;
unsigned pktLoss = 0;
unsigned otherError = 0;

// 16-bit addressing: Enter address of remote XBee, typically the coordinator
Tx16Request tx = Tx16Request(0x00, payload, sizeof(payload));

TxStatusResponse txStatus = TxStatusResponse();

unsigned perPeriod = 0;

// print time, number of received packet and Xbee throughput
void benchOutput() {
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
  Serial.print("size of payload: ");
  Serial.println(sizeof(payload));
  Serial.println("Transmitter Setup finished!");
}

void loop() {

    xbee.send(tx);
  
    // after sending a tx request, we expect a status response
    // wait up to 5 seconds for the status response
    if (xbee.readPacket(500)) {
        // got a response!

        // should be a znet tx status              
      if (xbee.getResponse().getApiId() == TX_STATUS_RESPONSE) {
         xbee.getResponse().getTxStatusResponse(txStatus);
        
         // get the delivery status, the fifth byte
           if (txStatus.getStatus() == SUCCESS) {
              // success.  time to celebrate
              pktTransmitted += 1;

           } else {
              // the remote XBee did not receive our packet. is it powered on?
              pktLoss += 1;
           }
        }      
    } else if (xbee.getResponse().isError()) {
      //nss.print("Error reading packet.  Error code: ");  
      //nss.println(xbee.getResponse().getErrorCode());
      // or flash error led
        otherError += 1;
    } 
    
    delayMicroseconds(500);
    delay(8);
    perPeriod += 1;
    if(perPeriod == 1000) {
      benchOutput();
      perPeriod = 0;
    }
}

/* Conexão dos pinos do xbee ao arduino

   ===========
   Conecte o TX ao D3
   Conecte o RX ao D2
   Conecte Vgg ao 5V
   Conecte GROUND ao GND
*/

/* Conexão dos pinos do sensor BNO055

   ===========
   Conecte o SCL ao A5
   Conecte o SDA ao A4
   Conecte VDD ao 3.3V
   Conecte GROUND ao GND
   Conecte ADR ao GND para o endereço 0x28 (A)
   Conecte ADR ao 3.3V para o endereço 0x29 (B)

*/

#include <SoftwareSerial.h>

SoftwareSerial xbee(2, 3); //Arduino RX, TX
int i = 0;
int k = 0;
char valor[7];

void setup(void)
{
  Serial.begin(9600);

  // set the data rate for the SoftwareSerial port
  xbee.begin(9600);

  delay(100);
}



void loop(void)
{


  if (xbee.available() > 0) {

    byte frame = xbee.read();
    i++;

    //    if(frame == 0xC2) Serial.print("Foi");
    if (i > 15 && frame != 0xC2) {

      char j = (char)frame;
      //Serial.println(frame);
      if (j == ' ' || j == ';') {
        k = 0;
        String str(valor);
        Serial.print(atof(str.c_str()));
        Serial.print("\t");
        valor[0] = '\0'; valor[3] = '\0'; valor[6] = '\0';
        valor[1] = '\0'; valor[4] = '\0';
        valor[2] = '\0'; valor[5] = '\0';

        if (j == ';') {
          Serial.print("\n");
          frame = 0x00;
          i = 0;
        }

      }
      else {
        valor[k] = j;
        k++;
      }
    }
  }
}


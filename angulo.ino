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
#include <Wire.h>
#include <Adafruit_BNO055.h>
#include <Adafruit_Sensor.h>

/* Setando os endereços de cada sensor */
Adafruit_BNO055 bnoA = Adafruit_BNO055(-1, BNO055_ADDRESS_A);
Adafruit_BNO055 bnoB = Adafruit_BNO055(-1, BNO055_ADDRESS_B);

SoftwareSerial xbee(2, 3); //Arduino RX, TX

String dados;

void setup(void)
{
  Serial.begin(9600);
  //
  /* Verificando se o sensor está conectado */
  if (!bnoA.begin()) {
    Serial.print("BNO055(A) GND não encontrado");
    while (1);
  }
  bnoA.setExtCrystalUse(true);

  if (!bnoB.begin()) {
    Serial.print("BNO055(B) VCC não encontrado");
    while (1);
  }
  bnoB.setExtCrystalUse(true);


  // set the data rate for the SoftwareSerial port
  xbee.begin(9600);

  delay(1000);
}

void loop(void)
{
  uint8_t system, gyroA, accelA, magA, gyroB, accelB, magB;
  system = gyroA = gyroB = 0;
  bnoA.getCalibration(&system, &gyroA, &accelA, &magA);
  bnoB.getCalibration(&system, &gyroB, &accelB, &magB);

  //  Serial.print("A: ");
  //  Serial.println(gyroA);
  //  Serial.print("B: ");
  //  Serial.println(gyroB);

  if (gyroA == gyroB && gyroA == 3) {
    imu::Vector<3> euler = bnoA.getVector(Adafruit_BNO055::VECTOR_EULER);
    dados = dados + euler.x() + " " + euler.y() + " "  + euler.z() + " ";

    euler = bnoB.getVector(Adafruit_BNO055::VECTOR_EULER);
    dados = dados + euler.x() + " " + euler.y() + " "  + euler.z() + ";";

    xbee.print(dados);

    Serial.println(dados);

    dados = "";
    xbee.flush();
  }
  delay(100);
}

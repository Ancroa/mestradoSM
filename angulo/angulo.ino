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

SoftwareSerial xbee(2, 3);                //Arduino RX, TX

String dados;

void setup(void)
{
  Serial.begin(9600);

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

  /* Setado o BaudRate do Xbee */
  xbee.begin(9600);

  delay(1000);
}

void loop(void)
{

  /* Verificando se os sensores estão calibrados */
  uint8_t system, gyroA, accelA, magA, gyroB, accelB, magB;
  system = gyroA = gyroB = 0;
  bnoA.getCalibration(&system, &gyroA, &accelA, &magA);
  bnoB.getCalibration(&system, &gyroB, &accelB, &magB);

  //  Serial.print("A: ");
  //  Serial.println(gyroA);
  //  Serial.print("B: ");
  //  Serial.println(gyroB);

  /* Condição de inicialização da leitura dos sensores */
  if (gyroA == gyroB && gyroA == 3) {

    imu::Vector<3> euler = bnoA.getVector(Adafruit_BNO055::VECTOR_EULER);
    dados = dados + euler.x() + " " + euler.y() + " "  + euler.z() + " ";

    euler = bnoB.getVector(Adafruit_BNO055::VECTOR_EULER);
    dados = dados + euler.x() + " " + euler.y() + " "  + euler.z() + ";";

    /* Ex. de organização dos dados */
    /* 50.00 35.14 154.95 0.00 359.51 275.01; */

    /* Envia o dados pelo xbee */
    xbee.print(dados);

    /* Aprensenta na tela o valor enviado */
    Serial.println(dados);

    dados = "";         // Limpa a string dados
    xbee.flush();       //Limpa a serial do xbee
  }
  delay(100);
}

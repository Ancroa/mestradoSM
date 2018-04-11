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

SoftwareSerial xbee(2, 3);                // Arduino RX, TX
int i = 0;                                // Quantidade de dados recebido pelo xbee
int k = 0;                                // Índice do vetor valor
char valor[7];                            // Armazena o valor dos dados recebido

void setup(void)
{
  Serial.begin(9600);                     // BaudRate da Serial
  xbee.begin(9600);                       // BaudRate do xbee

  delay(100);
}



void loop(void)
{
  if (xbee.available() > 0) {             // Verificação de dados recebidos

    byte frame = xbee.read();             // Armazena o primeiro dado do pacote
    i++;                                  // Conta a quantidade de dados recebido do pacote

    if (i > 15 && frame != 0xC2) {        // Condição de inicialização dos dados armazenado no pacote

      char j = (char)frame;               // Converter o dado recebido em char

      if (j == ' ' || j == ';') {         // Verifica a condição para realizar a conversão dos dados para inteiro
        k = 0;                            // Zera o índice do vetor de caracter
        String str(valor);                // Converter o vetor de caracter em string ... Ex. [1] [0] [0] [.] [5] [2] - > 100.52
        Serial.print(atof(str.c_str()));  // Converte a String em número
        Serial.print("\t");
         
         // Limpa o vetor de caracter
        valor[0] = '\0'; valor[3] = '\0'; valor[6] = '\0';  
        valor[1] = '\0'; valor[4] = '\0';
        valor[2] = '\0'; valor[5] = '\0';

        if (j == ';') {                   // Condição para receber um novo pacote
          Serial.print("\n");
          frame = 0x00;                   // Limpa o frame
          i = 0;                          // Zera a quantidade de dados do pacote recebido
        }

      }
      else {                              // Caso a condição não seja verdadeira, armazena o caracter no vetor
        valor[k] = j;                     // Guarda o caracter no vetor de caracteres
        k++;                              // Incrementa o índice do vetor
      }
    }
  }
}


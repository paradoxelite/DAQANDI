#include<osa.h>
#define ch1 RC0_bit
#define ch2 RC1_bit
#define ch3 RC2_bit
#define ch4 RC6_bit
#define ch5 RC7_bit

unsigned char readbuff[64] absolute 0x500;   // Buffer de 64 bytes
unsigned char writebuff[64] absolute 0x540;  // Buffer de 64 bytes

void InitTimer0(){
    T0CON = 0xC2;
    TMR0L = 0x6A;
    GIE_bit = 1;
    TMR0IE_bit = 1;
}

void Interrupt(){
    if (TMR0IF_bit){
        TMR0IF_bit = 0;
        TMR0L = 0x6A;
        OS_Timer();
    }
}
#pragma funcall main Thread1
void Thread1(void)
{
    while(1)
    {
        USB_Polling_Proc();
        OS_Delay(1);
    }
}

#pragma funcall main Thread2
void Thread2(void)
{
    while(1)
    {
        // Preparar datos para enviar
        writebuff[0] = 0x01;  // Report ID debe ser 1
        writebuff[1] = ADC_Get_Sample(5) >> 2;
        writebuff[2] = ADC_Get_Sample(2) >> 2;
        writebuff[3] = ADC_Get_Sample(4) >> 2;
        writebuff[4] = ADC_Get_Sample(7) >> 2;
        writebuff[5] = ADC_Get_Sample(6) >> 2;
        writebuff[6] = PORTB;

        // Enviar datos
        if(HID_Write(&writebuff, 64) == 0) {  // 0 significa éxito
            ch4 = 0;  // Indicador de éxito
        } else {
            ch4 = 1;  // Indicador de error
        }
        OS_Delay(1);
    }
}

#pragma funcall main Thread3
void Thread3(void)
{
    while(1)
    {
        // Leer datos
        if(HID_Read() == 0) {  // 0 significa éxito
            ch4 = 1;  // Indicador de éxito
        } else {
            ch4 = 0;  // Indicador de error
        }

        // Multiplexación de canales
        ch1 = 0; ch2 = 0; ch3 = 0;
        PORTD = readbuff[1];  // Valor digital en byte 5
        OS_Delay(1);
        ch3 = 1;

        ch1 = 0; ch2 = 1; ch3 = 0;
        PORTD = readbuff[2];  // Mantener el valor digital
        OS_Delay(1);
        ch3 = 1;

        ch1 = 1; ch2 = 0; ch3 = 0;
        PORTD = readbuff[3];  // Mantener el valor digital
        OS_Delay(1);
        ch3 = 1;

        ch1 = 1; ch2 = 1; ch3 = 0;
        PORTD = readbuff[4];  // Mantener el valor digital
        OS_Delay(1);
        ch3 = 1;

        PORTD = readbuff[5];  // Mantener el valor digital
        ch5 = 1;
        OS_Delay(1);
        ch5 = 0;
    }
}

void main() {
    HID_Enable(&readbuff, &writebuff);

    // Configuración de puertos
    ADCON1 = 0x07;
    ADFM_bit = 0;
    TRISB = 0xFF;
    TRISC = 0;
    TRISE = 0xFF;
    TRISA = 0xFF;
    TRISD = 0;
    PORTD = 0;  // Inicializar PORTD a 0

    // Inicialización
    ADC_Init();
    OS_Init();

    // Crear tareas
    OS_Task_Create(0, Thread3);
    OS_Task_Create(1, Thread2);
    OS_Task_Create(2, Thread1);

    // Inicializar Timer0
    InitTimer0();

    // Iniciar sistema operativo
    OS_Run();
}

_InitTimer0:

;MyProject.c,11 :: 		void InitTimer0(){
;MyProject.c,12 :: 		T0CON = 0xC2;
	MOVLW       194
	MOVWF       T0CON+0 
;MyProject.c,13 :: 		TMR0L = 0x6A;
	MOVLW       106
	MOVWF       TMR0L+0 
;MyProject.c,14 :: 		GIE_bit = 1;
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
;MyProject.c,15 :: 		TMR0IE_bit = 1;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;MyProject.c,16 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_Interrupt:

;MyProject.c,18 :: 		void Interrupt(){
;MyProject.c,19 :: 		if (TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_Interrupt0
;MyProject.c,20 :: 		TMR0IF_bit = 0;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;MyProject.c,21 :: 		TMR0L = 0x6A;
	MOVLW       106
	MOVWF       TMR0L+0 
;MyProject.c,22 :: 		OS_Timer();
	CALL        _OS_Timer+0, 0
;MyProject.c,23 :: 		}
L_Interrupt0:
;MyProject.c,24 :: 		}
L_end_Interrupt:
L__Interrupt50:
	RETFIE      1
; end of _Interrupt

_Thread1:

;MyProject.c,26 :: 		void Thread1(void)
;MyProject.c,28 :: 		while(1)
L_Thread11:
;MyProject.c,30 :: 		USB_Polling_Proc();
	CALL        _USB_Polling_Proc+0, 0
;MyProject.c,31 :: 		OS_Delay(1);
	MOVLW       1
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVLW       0
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVWF       FARG__OS_InitDelay_Delay+3 
	CALL        __OS_InitDelay+0, 0
	CALL        __OS_ReturnSave+0, 0
	NOP
;MyProject.c,32 :: 		}
	GOTO        L_Thread11
;MyProject.c,33 :: 		}
L_end_Thread1:
	RETURN      0
; end of _Thread1

_Thread2:

;MyProject.c,36 :: 		void Thread2(void)
;MyProject.c,38 :: 		while(1)
L_Thread23:
;MyProject.c,41 :: 		writebuff[0] = 0x01;  // Report ID debe ser 1
	MOVLW       1
	MOVWF       1344 
;MyProject.c,42 :: 		writebuff[1] = ADC_Get_Sample(5) >> 2;
	MOVLW       5
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       1345 
;MyProject.c,43 :: 		writebuff[2] = ADC_Get_Sample(2) >> 2;
	MOVLW       2
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       1346 
;MyProject.c,44 :: 		writebuff[3] = ADC_Get_Sample(4) >> 2;
	MOVLW       4
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       1347 
;MyProject.c,45 :: 		writebuff[4] = ADC_Get_Sample(7) >> 2;
	MOVLW       7
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       1348 
;MyProject.c,46 :: 		writebuff[5] = ADC_Get_Sample(6) >> 2;
	MOVLW       6
	MOVWF       FARG_ADC_Get_Sample_channel+0 
	CALL        _ADC_Get_Sample+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	RRCF        R3, 1 
	RRCF        R2, 1 
	BCF         R3, 7 
	MOVF        R2, 0 
	MOVWF       1349 
;MyProject.c,47 :: 		writebuff[6] = PORTB;
	MOVF        PORTB+0, 0 
	MOVWF       1350 
;MyProject.c,50 :: 		if(HID_Write(&writebuff, 64) == 0) {  // 0 significa éxito
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Write_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Write_writebuff+1 
	MOVLW       64
	MOVWF       FARG_HID_Write_len+0 
	CALL        _HID_Write+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Thread25
;MyProject.c,51 :: 		ch4 = 0;  // Indicador de éxito
	BCF         RC6_bit+0, BitPos(RC6_bit+0) 
;MyProject.c,52 :: 		} else {
	GOTO        L_Thread26
L_Thread25:
;MyProject.c,53 :: 		ch4 = 1;  // Indicador de error
	BSF         RC6_bit+0, BitPos(RC6_bit+0) 
;MyProject.c,54 :: 		}
L_Thread26:
;MyProject.c,55 :: 		OS_Delay(1);
	MOVLW       1
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVLW       0
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVWF       FARG__OS_InitDelay_Delay+3 
	CALL        __OS_InitDelay+0, 0
	CALL        __OS_ReturnSave+0, 0
	NOP
;MyProject.c,56 :: 		}
	GOTO        L_Thread23
;MyProject.c,57 :: 		}
L_end_Thread2:
	RETURN      0
; end of _Thread2

_Thread3:

;MyProject.c,60 :: 		void Thread3(void)
;MyProject.c,62 :: 		while(1)
L_Thread37:
;MyProject.c,65 :: 		if(HID_Read() == 0) {  // 0 significa éxito
	CALL        _HID_Read+0, 0
	MOVF        R0, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_Thread39
;MyProject.c,66 :: 		ch4 = 1;  // Indicador de éxito
	BSF         RC6_bit+0, BitPos(RC6_bit+0) 
;MyProject.c,67 :: 		} else {
	GOTO        L_Thread310
L_Thread39:
;MyProject.c,68 :: 		ch4 = 0;  // Indicador de error
	BCF         RC6_bit+0, BitPos(RC6_bit+0) 
;MyProject.c,69 :: 		}
L_Thread310:
;MyProject.c,72 :: 		ch1 = 0; ch2 = 0; ch3 = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,73 :: 		PORTD = readbuff[1];  // Valor digital en byte 5
	MOVF        1281, 0 
	MOVWF       PORTD+0 
;MyProject.c,74 :: 		OS_Delay(1);
	MOVLW       1
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVLW       0
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVWF       FARG__OS_InitDelay_Delay+3 
	CALL        __OS_InitDelay+0, 0
	CALL        __OS_ReturnSave+0, 0
	NOP
;MyProject.c,75 :: 		ch3 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,77 :: 		ch1 = 0; ch2 = 1; ch3 = 0;
	BCF         RC0_bit+0, BitPos(RC0_bit+0) 
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,78 :: 		PORTD = readbuff[2];  // Mantener el valor digital
	MOVF        1282, 0 
	MOVWF       PORTD+0 
;MyProject.c,79 :: 		OS_Delay(1);
	MOVLW       1
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVLW       0
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVWF       FARG__OS_InitDelay_Delay+3 
	CALL        __OS_InitDelay+0, 0
	CALL        __OS_ReturnSave+0, 0
	NOP
;MyProject.c,80 :: 		ch3 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,82 :: 		ch1 = 1; ch2 = 0; ch3 = 0;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
	BCF         RC1_bit+0, BitPos(RC1_bit+0) 
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,83 :: 		PORTD = readbuff[3];  // Mantener el valor digital
	MOVF        1283, 0 
	MOVWF       PORTD+0 
;MyProject.c,84 :: 		OS_Delay(1);
	MOVLW       1
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVLW       0
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVWF       FARG__OS_InitDelay_Delay+3 
	CALL        __OS_InitDelay+0, 0
	CALL        __OS_ReturnSave+0, 0
	NOP
;MyProject.c,85 :: 		ch3 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,87 :: 		ch1 = 1; ch2 = 1; ch3 = 0;
	BSF         RC0_bit+0, BitPos(RC0_bit+0) 
	BSF         RC1_bit+0, BitPos(RC1_bit+0) 
	BCF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,88 :: 		PORTD = readbuff[4];  // Mantener el valor digital
	MOVF        1284, 0 
	MOVWF       PORTD+0 
;MyProject.c,89 :: 		OS_Delay(1);
	MOVLW       1
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVLW       0
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVWF       FARG__OS_InitDelay_Delay+3 
	CALL        __OS_InitDelay+0, 0
	CALL        __OS_ReturnSave+0, 0
	NOP
;MyProject.c,90 :: 		ch3 = 1;
	BSF         RC2_bit+0, BitPos(RC2_bit+0) 
;MyProject.c,92 :: 		PORTD = readbuff[5];  // Mantener el valor digital
	MOVF        1285, 0 
	MOVWF       PORTD+0 
;MyProject.c,93 :: 		ch5 = 1;
	BSF         RC7_bit+0, BitPos(RC7_bit+0) 
;MyProject.c,94 :: 		OS_Delay(1);
	MOVLW       1
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVLW       0
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVWF       FARG__OS_InitDelay_Delay+3 
	CALL        __OS_InitDelay+0, 0
	CALL        __OS_ReturnSave+0, 0
	NOP
;MyProject.c,95 :: 		ch5 = 0;
	BCF         RC7_bit+0, BitPos(RC7_bit+0) 
;MyProject.c,96 :: 		}
	GOTO        L_Thread37
;MyProject.c,97 :: 		}
L_end_Thread3:
	RETURN      0
; end of _Thread3

_main:

;MyProject.c,99 :: 		void main() {
;MyProject.c,100 :: 		HID_Enable(&readbuff, &writebuff);
	MOVLW       _readbuff+0
	MOVWF       FARG_HID_Enable_readbuff+0 
	MOVLW       hi_addr(_readbuff+0)
	MOVWF       FARG_HID_Enable_readbuff+1 
	MOVLW       _writebuff+0
	MOVWF       FARG_HID_Enable_writebuff+0 
	MOVLW       hi_addr(_writebuff+0)
	MOVWF       FARG_HID_Enable_writebuff+1 
	CALL        _HID_Enable+0, 0
;MyProject.c,103 :: 		ADCON1 = 0x07;
	MOVLW       7
	MOVWF       ADCON1+0 
;MyProject.c,104 :: 		ADFM_bit = 0;
	BCF         ADFM_bit+0, BitPos(ADFM_bit+0) 
;MyProject.c,105 :: 		TRISB = 0xFF;
	MOVLW       255
	MOVWF       TRISB+0 
;MyProject.c,106 :: 		TRISC = 0;
	CLRF        TRISC+0 
;MyProject.c,107 :: 		TRISE = 0xFF;
	MOVLW       255
	MOVWF       TRISE+0 
;MyProject.c,108 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;MyProject.c,109 :: 		TRISD = 0;
	CLRF        TRISD+0 
;MyProject.c,110 :: 		PORTD = 0;  // Inicializar PORTD a 0
	CLRF        PORTD+0 
;MyProject.c,113 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;MyProject.c,114 :: 		OS_Init();
	CALL        _OS_Init+0, 0
;MyProject.c,117 :: 		OS_Task_Create(0, Thread3);
	CLRF        FARG__OS_Task_Create_priority+0 
	MOVLW       _Thread3+0
	MOVWF       FARG__OS_Task_Create_TaskAddr+0 
	MOVLW       hi_addr(_Thread3+0)
	MOVWF       FARG__OS_Task_Create_TaskAddr+1 
	MOVLW       0
	MOVWF       FARG__OS_Task_Create_TaskAddr+2 
	MOVLW       0
	MOVWF       FARG__OS_Task_Create_TaskAddr+3 
	CALL        __OS_Task_Create+0, 0
;MyProject.c,118 :: 		OS_Task_Create(1, Thread2);
	MOVLW       1
	MOVWF       FARG__OS_Task_Create_priority+0 
	MOVLW       _Thread2+0
	MOVWF       FARG__OS_Task_Create_TaskAddr+0 
	MOVLW       hi_addr(_Thread2+0)
	MOVWF       FARG__OS_Task_Create_TaskAddr+1 
	MOVLW       0
	MOVWF       FARG__OS_Task_Create_TaskAddr+2 
	MOVLW       0
	MOVWF       FARG__OS_Task_Create_TaskAddr+3 
	CALL        __OS_Task_Create+0, 0
;MyProject.c,119 :: 		OS_Task_Create(2, Thread1);
	MOVLW       2
	MOVWF       FARG__OS_Task_Create_priority+0 
	MOVLW       _Thread1+0
	MOVWF       FARG__OS_Task_Create_TaskAddr+0 
	MOVLW       hi_addr(_Thread1+0)
	MOVWF       FARG__OS_Task_Create_TaskAddr+1 
	MOVLW       0
	MOVWF       FARG__OS_Task_Create_TaskAddr+2 
	MOVLW       0
	MOVWF       FARG__OS_Task_Create_TaskAddr+3 
	CALL        __OS_Task_Create+0, 0
;MyProject.c,122 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;MyProject.c,125 :: 		OS_Run();
L_main11:
	BCF         __OS_Flags+0, 4 
	BSF         __OS_Flags+0, 3 
	CLRF        __OS_Best_Priority+0 
	CLRF        __OS_Worst_Priority+0 
	MOVLW       3
	MOVWF       __OS_n+0 
L_main14:
	DECF        __OS_n+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       __OS_TaskQueue+0
	ADDWF       R0, 0 
	MOVWF       FSR2 
	MOVLW       hi_addr(__OS_TaskQueue+0)
	ADDWFC      R1, 0 
	MOVWF       FSR2H 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       __OS_Cur_Pos+0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       __OS_Tasks+0
	ADDWF       R0, 0 
	MOVWF       __OS_CurTask+0 
	MOVLW       hi_addr(__OS_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       __OS_CurTask+1 
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR0 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR0H 
	MOVLW       1
	MOVWF       R0 
	MOVLW       __OS_State+0
	MOVWF       FSR1 
	MOVLW       hi_addr(__OS_State+0)
	MOVWF       FSR1H 
L_main17:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main17
	BTFSS       __OS_State+0, 6 
	GOTO        L__main47
	BTFSC       __OS_State+0, 7 
	GOTO        L__main47
	GOTO        L_main20
L__main47:
	GOTO        ___main__OS_SCHED_CONTINUE
L_main20:
	BTFSC       __OS_State+0, 3 
	GOTO        L_main21
___main__OS_SCHED_RUN:
	CALL        __OS_JumpToTask+0, 0
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
	MOVLW       215
	ANDWF       __indf+0, 1 
	MOVLW       40
	ANDWF       __OS_State+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	IORWF       __indf+0, 1 
	BTFSC       __OS_Flags+0, 3 
	GOTO        L_main22
	BTFSC       __OS_State+0, 3 
	GOTO        L__main46
	BTFSC       __OS_Flags+1, 0 
	GOTO        L__main46
	GOTO        L_main25
L__main46:
	MOVLW       __OS_TaskLevel+0
	MOVWF       R1 
	MOVLW       hi_addr(__OS_TaskLevel+0)
	MOVWF       R2 
	MOVF        __OS_Cur_Pos+0, 0 
	ADDWF       R1, 1 
	BTFSC       STATUS+0, 0 
	INCF        R2, 1 
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        __OS_Worst_Priority+0, 0 
	SUBWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        __OS_Best_n+0, 0 
	MOVWF       __OS_n+0 
L_main26:
	MOVF        __OS_n+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
	MOVLW       __OS_TaskQueue+0
	MOVWF       FSR1 
	MOVLW       hi_addr(__OS_TaskQueue+0)
	MOVWF       FSR1H 
	MOVF        __OS_n+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	DECF        __OS_n+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       __OS_TaskQueue+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(__OS_TaskQueue+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        __OS_n+0, 1 
	GOTO        L_main26
L_main27:
	MOVF        __OS_Cur_Pos+0, 0 
	MOVWF       __OS_TaskQueue+0 
L_main25:
	GOTO        ___main_SCHED_END
L_main22:
L_main21:
	BTFSS       __OS_State+0, 4 
	GOTO        L_main30
	BTFSC       __OS_State+0, 5 
	GOTO        L_main30
L__main45:
	GOTO        ___main__OS_SCHED_CONTINUE
L_main30:
	BTFSS       __OS_State+0, 3 
	GOTO        L_main31
	MOVLW       __OS_TaskLevel+0
	MOVWF       FSR0 
	MOVLW       hi_addr(__OS_TaskLevel+0)
	MOVWF       FSR0H 
	MOVF        __OS_Cur_Pos+0, 0 
	ADDWF       FSR0, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR0H, 1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       __OS_Temp+0 
	BTFSC       R1, 7 
	GOTO        L_main32
	MOVLW       8
	ADDWF       __OS_Temp+0, 0 
	MOVWF       R1 
	MOVF        R1, 0 
	MOVWF       __OS_Temp+0 
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR0 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       7
	ANDWF       R0, 1 
	MOVF        R0, 0 
	SUBWF       R1, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       __OS_Temp+0 
	MOVLW       __OS_TaskLevel+0
	MOVWF       FSR1 
	MOVLW       hi_addr(__OS_TaskLevel+0)
	MOVWF       FSR1H 
	MOVF        __OS_Cur_Pos+0, 0 
	ADDWF       FSR1, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR1H, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
L_main32:
	MOVF        __OS_Temp+0, 0 
	SUBWF       __OS_Best_Priority+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
	MOVF        __OS_Best_Priority+0, 0 
	MOVWF       __OS_Worst_Priority+0 
	MOVF        __OS_Temp+0, 0 
	MOVWF       __OS_Best_Priority+0 
	DECF        __OS_n+0, 0 
	MOVWF       __OS_Best_n+0 
	BSF         __OS_Flags+0, 4 
	GOTO        L_main34
L_main33:
	MOVF        __OS_Temp+0, 0 
	SUBWF       __OS_Worst_Priority+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main35
	MOVF        __OS_Temp+0, 0 
	MOVWF       __OS_Worst_Priority+0 
L_main35:
L_main34:
L_main31:
___main__OS_SCHED_CONTINUE:
	DECF        __OS_n+0, 1 
	MOVF        __OS_n+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__main44
	GOTO        L_main14
L__main44:
	BTFSS       __OS_Flags+0, 4 
	GOTO        L_main38
	BCF         __OS_Flags+0, 3 
	BCF         __OS_Flags+1, 0 
	MOVLW       __OS_TaskQueue+0
	MOVWF       FSR2 
	MOVLW       hi_addr(__OS_TaskQueue+0)
	MOVWF       FSR2H 
	MOVF        __OS_Best_n+0, 0 
	ADDWF       FSR2, 1 
	BTFSC       STATUS+0, 0 
	INCF        FSR2H, 1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       __OS_Cur_Pos+0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       9
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       __OS_Tasks+0
	ADDWF       R0, 0 
	MOVWF       __OS_CurTask+0 
	MOVLW       hi_addr(__OS_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       __OS_CurTask+1 
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR0 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR0H 
	MOVLW       1
	MOVWF       R0 
	MOVLW       __OS_State+0
	MOVWF       FSR1 
	MOVLW       hi_addr(__OS_State+0)
	MOVWF       FSR1H 
L_main39:
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	DECF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_main39
	BTFSS       __OS_State+0, 6 
	GOTO        L_main42
	BTFSC       __OS_State+0, 7 
	GOTO        L_main42
L__main43:
	GOTO        ___main__OS_SCHED_RUN
L_main42:
L_main38:
___main_SCHED_END:
	GOTO        L_main11
;MyProject.c,126 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

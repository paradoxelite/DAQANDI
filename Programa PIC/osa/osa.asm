
__OS_JumpToTask:

;osa_pic18_mikroc.c,62 :: 		
;osa_pic18_mikroc.c,64 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,65 :: 		
	MOVF        4078, 0 
	MOVWF       __OS_State+0 
;osa_pic18_mikroc.c,67 :: 		
	PUSH
;osa_pic18_mikroc.c,68 :: 		
	MOVF        4078, 0, 0
;osa_pic18_mikroc.c,69 :: 		
	MOVWF       4093, 1
;osa_pic18_mikroc.c,70 :: 		
	MOVF        4078, 0, 0
;osa_pic18_mikroc.c,71 :: 		
	MOVWF       4094, 1
;osa_pic18_mikroc.c,72 :: 		
	MOVF        4078, 0, 0
;osa_pic18_mikroc.c,73 :: 		
	MOVWF       4095, 1
;osa_pic18_mikroc.c,74 :: 		
	RETURN      0
;osa_pic18_mikroc.c,76 :: 		
L_end__OS_JumpToTask:
	RETURN      0
; end of __OS_JumpToTask

__OS_ReturnSave:

;osa_pic18_mikroc.c,104 :: 		
;osa_pic18_mikroc.c,106 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,107 :: 		
	MOVF        4093, 0 
	MOVWF       4076 
	MOVF        4094, 0 
	MOVWF       4076 
	MOVF        4095, 0 
	MOVWF       4076 
;osa_pic18_mikroc.c,108 :: 		
	BSF         __OS_State+0, 3 
;osa_pic18_mikroc.c,109 :: 		
	POP
;osa_pic18_mikroc.c,110 :: 		
L_end__OS_ReturnSave:
	RETURN      0
; end of __OS_ReturnSave

__OS_ReturnNoSave:

;osa_pic18_mikroc.c,130 :: 		
;osa_pic18_mikroc.c,132 :: 		
	POP
;osa_pic18_mikroc.c,133 :: 		
L_end__OS_ReturnNoSave:
	RETURN      0
; end of __OS_ReturnNoSave

__OS_EnterWaitMode:

;osa_pic18_mikroc.c,154 :: 		
;osa_pic18_mikroc.c,156 :: 		
	CLRF        __OS_Temp+0 
;osa_pic18_mikroc.c,157 :: 		
	CALL        __OS_ClrReadySetClrCanContinue+0, 0
;osa_pic18_mikroc.c,158 :: 		
L_end__OS_EnterWaitMode:
	RETURN      0
; end of __OS_EnterWaitMode

__OS_EnterWaitModeTO:

;osa_pic18_mikroc.c,179 :: 		
;osa_pic18_mikroc.c,181 :: 		
	MOVLW       255
	MOVWF       __OS_Temp+0 
;osa_pic18_mikroc.c,182 :: 		
	CALL        __OS_ClrReadySetClrCanContinue+0, 0
;osa_pic18_mikroc.c,183 :: 		
L_end__OS_EnterWaitModeTO:
	RETURN      0
; end of __OS_EnterWaitModeTO

__OS_ClrReadySetClrCanContinue:

;osa_pic18_mikroc.c,205 :: 		
;osa_pic18_mikroc.c,207 :: 		
	POP
;osa_pic18_mikroc.c,209 :: 		
	BCF         __OS_Flags+0, 0 
;osa_pic18_mikroc.c,211 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,212 :: 		
	MOVF        4093, 0 
	MOVWF       4076 
	MOVF        4094, 0 
	MOVWF       4076 
	MOVF        4095, 0 
	MOVWF       4076 
;osa_pic18_mikroc.c,213 :: 		
	BCF         __OS_State+0, 3 
;osa_pic18_mikroc.c,216 :: 		
	BTFSC       __OS_State+0, 4 
	GOTO        L__OS_ClrReadySetClrCanContinue0
	BCF         __OS_State+0, 5 
L__OS_ClrReadySetClrCanContinue0:
;osa_pic18_mikroc.c,217 :: 		
	BTFSS       __OS_Temp+0, 0 
	GOTO        L__OS_ClrReadySetClrCanContinue1
	BSF         __OS_State+0, 5 
L__OS_ClrReadySetClrCanContinue1:
;osa_pic18_mikroc.c,220 :: 		
L_end__OS_ClrReadySetClrCanContinue:
	RETURN      0
; end of __OS_ClrReadySetClrCanContinue

__OS_SET_FSR_CUR_TASK:

;osa_pic18_mikroc.c,240 :: 		
;osa_pic18_mikroc.c,242 :: 		
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR0 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR0H 
;osa_pic18_mikroc.c,243 :: 		
L_end__OS_SET_FSR_CUR_TASK:
	RETURN      0
; end of __OS_SET_FSR_CUR_TASK

_OS_DI:

;osa_pic18_mikroc.c,279 :: 		
;osa_pic18_mikroc.c,282 :: 		
	MOVLW       192
	ANDWF       4082, 0 
	MOVWF       R1 
;osa_pic18_mikroc.c,283 :: 		
	BCF         GIE_bit+0, BitPos(GIE_bit+0) 
;osa_pic18_mikroc.c,284 :: 		
	BTFSS       IPEN_bit+0, BitPos(IPEN_bit+0) 
	GOTO        L_OS_DI2
	BCF         GIEL_bit+0, BitPos(GIEL_bit+0) 
L_OS_DI2:
;osa_pic18_mikroc.c,285 :: 		
	MOVF        R1, 0 
	MOVWF       R0 
;osa_pic18_mikroc.c,286 :: 		
L_end_OS_DI:
	RETURN      0
; end of _OS_DI

_OS_RI:

;osa_pic18_mikroc.c,324 :: 		
;osa_pic18_mikroc.c,326 :: 		
	BTFSS       FARG_OS_RI_temp+0, 7 
	GOTO        L_OS_RI3
	BSF         GIE_bit+0, BitPos(GIE_bit+0) 
L_OS_RI3:
;osa_pic18_mikroc.c,327 :: 		
	BTFSS       IPEN_bit+0, BitPos(IPEN_bit+0) 
	GOTO        L_OS_RI4
;osa_pic18_mikroc.c,329 :: 		
	BTFSS       FARG_OS_RI_temp+0, 6 
	GOTO        L_OS_RI5
	BSF         GIEL_bit+0, BitPos(GIEL_bit+0) 
L_OS_RI5:
;osa_pic18_mikroc.c,330 :: 		
L_OS_RI4:
;osa_pic18_mikroc.c,331 :: 		
L_end_OS_RI:
	RETURN      0
; end of _OS_RI

__OS_CheckEvent:

;osa_pic18_mikroc.c,381 :: 		
;osa_pic18_mikroc.c,419 :: 		
	BCF         __OS_Flags+0, 5 
;osa_pic18_mikroc.c,420 :: 		
	CALL        __OS_SET_FSR_CUR_TASK+0, 0
;osa_pic18_mikroc.c,422 :: 		
	MOVF        FARG__OS_CheckEvent_bEvent+0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L__OS_CheckEvent6
;osa_pic18_mikroc.c,424 :: 		
	BTFSS       __OS_State+0, 3 
	GOTO        L__OS_CheckEvent7
;osa_pic18_mikroc.c,428 :: 		
	BCF         __OS_State+0, 4 
;osa_pic18_mikroc.c,429 :: 		
	BCF         4079, 4 
;osa_pic18_mikroc.c,434 :: 		
	BSF         __OS_Flags+1, 0 
;osa_pic18_mikroc.c,437 :: 		
	GOTO        L_end__OS_CheckEvent
;osa_pic18_mikroc.c,438 :: 		
L__OS_CheckEvent7:
;osa_pic18_mikroc.c,440 :: 		
	BSF         __OS_State+0, 3 
;osa_pic18_mikroc.c,442 :: 		
	GOTO        L__OS_CheckEvent8
L__OS_CheckEvent6:
;osa_pic18_mikroc.c,443 :: 		
	BCF         __OS_State+0, 3 
;osa_pic18_mikroc.c,444 :: 		
L__OS_CheckEvent8:
;osa_pic18_mikroc.c,448 :: 		
	BTFSC       __OS_State+0, 4 
	GOTO        L__OS_CheckEvent11
	BTFSS       __OS_State+0, 5 
	GOTO        L__OS_CheckEvent11
L___OS_CheckEvent26:
;osa_pic18_mikroc.c,450 :: 		
	BSF         __OS_State+0, 3 
;osa_pic18_mikroc.c,451 :: 		
	BSF         __OS_Flags+0, 5 
;osa_pic18_mikroc.c,454 :: 		
	BSF         __OS_Flags+1, 0 
;osa_pic18_mikroc.c,457 :: 		
	GOTO        L_end__OS_CheckEvent
;osa_pic18_mikroc.c,458 :: 		
L__OS_CheckEvent11:
;osa_pic18_mikroc.c,462 :: 		
	POP
;osa_pic18_mikroc.c,467 :: 		
L_end__OS_CheckEvent:
	RETURN      0
; end of __OS_CheckEvent

__OS_InitDelay:

;osa_ttimer.c,69 :: 		
;osa_ttimer.c,72 :: 		
	BCF         __OS_State+0, 5 
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR1 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR1H 
	BCF         POSTINC1+0, 4 
;osa_ttimer.c,77 :: 		
	MOVF        FARG__OS_InitDelay_Delay+0, 0 
	IORWF       FARG__OS_InitDelay_Delay+1, 0 
	IORWF       FARG__OS_InitDelay_Delay+2, 0 
	IORWF       FARG__OS_InitDelay_Delay+3, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L__OS_InitDelay12
;osa_ttimer.c,79 :: 		
	MOVLW       255
	XORWF       FARG__OS_InitDelay_Delay+0, 0 
	MOVWF       R0 
	MOVLW       255
	XORWF       FARG__OS_InitDelay_Delay+1, 0 
	MOVWF       R1 
	MOVLW       255
	XORWF       FARG__OS_InitDelay_Delay+2, 0 
	MOVWF       R2 
	MOVLW       255
	XORWF       FARG__OS_InitDelay_Delay+3, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVF        R1, 0 
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVF        R2, 0 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVF        R3, 0 
	MOVWF       FARG__OS_InitDelay_Delay+3 
;osa_ttimer.c,80 :: 		
	MOVLW       1
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       R6 
	MOVLW       0
	ADDWFC      R3, 0 
	MOVWF       R7 
	MOVF        R4, 0 
	MOVWF       FARG__OS_InitDelay_Delay+0 
	MOVF        R5, 0 
	MOVWF       FARG__OS_InitDelay_Delay+1 
	MOVF        R6, 0 
	MOVWF       FARG__OS_InitDelay_Delay+2 
	MOVF        R7, 0 
	MOVWF       FARG__OS_InitDelay_Delay+3 
;osa_ttimer.c,81 :: 		
	MOVF        __OS_CurTask+0, 0 
	MOVWF       R0 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       R1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        R4, 0 
	MOVWF       POSTINC1+0 
	MOVF        R5, 0 
	MOVWF       POSTINC1+0 
	MOVF        R6, 0 
	MOVWF       POSTINC1+0 
	MOVF        R7, 0 
	MOVWF       POSTINC1+0 
;osa_ttimer.c,82 :: 		
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR1 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 3 
	MOVF        __OS_CurTask+0, 0 
	MOVWF       FSR1 
	MOVF        __OS_CurTask+1, 0 
	MOVWF       FSR1H 
	BSF         POSTINC1+0, 4 
;osa_ttimer.c,87 :: 		
	BSF         __OS_State+0, 4 
;osa_ttimer.c,88 :: 		
	BSF         __OS_State+0, 3 
;osa_ttimer.c,90 :: 		
L__OS_InitDelay12:
;osa_ttimer.c,91 :: 		
L_end__OS_InitDelay:
	RETURN      0
; end of __OS_InitDelay

_OS_Init:

;osa_system.c,67 :: 		
;osa_system.c,72 :: 		
	CLRF        __OS_Flags+0 
;osa_system.c,326 :: 		
	BCF         __OS_Tasks+0, 6 
;osa_system.c,329 :: 		
	BCF         __OS_Tasks+9, 6 
;osa_system.c,333 :: 		
	BCF         __OS_Tasks+18, 6 
;osa_system.c,380 :: 		
	MOVLW       __OS_Tasks+0
	MOVWF       __OS_CurTask+0 
	MOVLW       hi_addr(__OS_Tasks+0)
	MOVWF       __OS_CurTask+1 
;osa_system.c,381 :: 		
	MOVLW       3
	MOVWF       __OS_Temp+0 
;osa_system.c,382 :: 		
L_OS_Init13:
;osa_system.c,384 :: 		
	DECF        __OS_Temp+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       __OS_TaskQueue+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(__OS_TaskQueue+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;osa_system.c,385 :: 		
	DECF        __OS_Temp+0, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVLW       0
	SUBWFB      R1, 1 
	MOVLW       __OS_TaskLevel+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(__OS_TaskLevel+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;osa_system.c,386 :: 		
	DECF        __OS_Temp+0, 1 
	MOVF        __OS_Temp+0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_OS_Init13
;osa_system.c,394 :: 		
L_end_OS_Init:
	RETURN      0
; end of _OS_Init

_OS_Timer:

;osa_system.c,568 :: 		
;osa_system.c,570 :: 		
	CLRF        OS_Timer__os_i_L2+0 
L_OS_Timer16:
	MOVLW       3
	SUBWF       OS_Timer__os_i_L2+0, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_OS_Timer17
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        OS_Timer__os_i_L2+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       __OS_Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR0 
	MOVLW       hi_addr(__OS_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	BTFSS       R0, 4 
	GOTO        L_OS_Timer19
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        OS_Timer__os_i_L2+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       __OS_Tasks+0
	ADDWF       R0, 1 
	MOVLW       hi_addr(__OS_Tasks+0)
	ADDWFC      R1, 1 
	MOVLW       5
	ADDWF       R0, 0 
	MOVWF       R4 
	MOVLW       0
	ADDWFC      R1, 0 
	MOVWF       R5 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVLW       1
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R2 
	MOVLW       0
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R3 
	MOVFF       R4, FSR1
	MOVFF       R5, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
	MOVF        R2, 0 
	MOVWF       POSTINC1+0 
	MOVF        R3, 0 
	MOVWF       POSTINC1+0 
	MOVFF       R4, FSR0
	MOVFF       R5, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC0+0, 0 
	MOVWF       R1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R2 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        R0, 0 
	IORWF       R1, 0 
	IORWF       R2, 0 
	IORWF       R3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_OS_Timer20
	MOVLW       9
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVF        OS_Timer__os_i_L2+0, 0 
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	CALL        _Mul_16X16_U+0, 0
	MOVLW       __OS_Tasks+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(__OS_Tasks+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	BCF         POSTINC1+0, 4 
L_OS_Timer20:
L_OS_Timer19:
	INCF        OS_Timer__os_i_L2+0, 1 
	GOTO        L_OS_Timer16
L_OS_Timer17:
;osa_system.c,571 :: 		
L_end_OS_Timer:
	RETURN      0
; end of _OS_Timer

__OS_Task_Create:

;osa_tasks.c,75 :: 		
;osa_tasks.c,79 :: 		
	BCF         __OS_Flags+0, 1 
;osa_tasks.c,88 :: 		
	MOVLW       __OS_Tasks+0
	MOVWF       R1 
	MOVLW       hi_addr(__OS_Tasks+0)
	MOVWF       R2 
;osa_tasks.c,89 :: 		
	CLRF        __OS_Temp+0 
;osa_tasks.c,91 :: 		
L__OS_Task_Create21:
;osa_tasks.c,93 :: 		
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
	BTFSC       R0, 6 
	GOTO        L__OS_Task_Create24
;osa_tasks.c,95 :: 		
	BSF         FARG__OS_Task_Create_priority+0, 6 
;osa_tasks.c,96 :: 		
	BSF         FARG__OS_Task_Create_priority+0, 3 
;osa_tasks.c,98 :: 		
	MOVLW       1
	ADDWF       R1, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       FSR1H 
	MOVF        FARG__OS_Task_Create_TaskAddr+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG__OS_Task_Create_TaskAddr+1, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG__OS_Task_Create_TaskAddr+2, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG__OS_Task_Create_TaskAddr+3, 0 
	MOVWF       POSTINC1+0 
;osa_tasks.c,101 :: 		
	MOVLW       5
	ADDWF       R1, 0 
	MOVWF       FSR1 
	MOVLW       0
	ADDWFC      R2, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;osa_tasks.c,108 :: 		
	MOVFF       R1, FSR1
	MOVFF       R2, FSR1H
	MOVF        FARG__OS_Task_Create_priority+0, 0 
	MOVWF       POSTINC1+0 
;osa_tasks.c,111 :: 		
	MOVF        R2, 0 
	XORWF       __OS_CurTask+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L___OS_Task_Create41
	MOVF        __OS_CurTask+0, 0 
	XORWF       R1, 0 
L___OS_Task_Create41:
	BTFSS       STATUS+0, 2 
	GOTO        L__OS_Task_Create25
	MOVF        FARG__OS_Task_Create_priority+0, 0 
	MOVWF       __OS_State+0 
L__OS_Task_Create25:
;osa_tasks.c,126 :: 		
	BCF         __OS_Flags+0, 1 
;osa_tasks.c,128 :: 		
	GOTO        L_end__OS_Task_Create
;osa_tasks.c,130 :: 		
L__OS_Task_Create24:
;osa_tasks.c,132 :: 		
	MOVLW       9
	ADDWF       R1, 1 
	MOVLW       0
	ADDWFC      R2, 1 
;osa_tasks.c,134 :: 		
	INCF        __OS_Temp+0, 1 
	MOVLW       3
	SUBWF       __OS_Temp+0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L__OS_Task_Create21
;osa_tasks.c,137 :: 		
	BSF         __OS_Flags+0, 1 
;osa_tasks.c,139 :: 		
;osa_tasks.c,140 :: 		
L_end__OS_Task_Create:
	RETURN      0
; end of __OS_Task_Create

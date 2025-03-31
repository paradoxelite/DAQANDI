#line 1 "C:/Users/joser/DAQ limon/Programa PIC/MyProject.c"
#line 1 "c:/users/joser/daq limon/programa pic/osa/osa.h"
#line 1 "c:/users/joser/daq limon/programa pic/osacfg.h"
#line 1063 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef  unsigned char  _OST_SMSG;
#line 1 "c:/users/joser/daq limon/programa pic/osa/port/osa_include.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/port/pic18/osa_pic18_mikroc.h"
#line 39 "c:/users/joser/daq limon/programa pic/osa/port/pic18/osa_pic18_mikroc.h"
typedef unsigned char OST_UINT8;
typedef unsigned int OST_UINT16;
typedef unsigned long OST_UINT32;
typedef unsigned char OST_BOOL;

typedef OST_UINT8 OST_UINT;
#line 91 "c:/users/joser/daq limon/programa pic/osa/port/pic18/osa_pic18_mikroc.h"
extern volatile unsigned int _fsr;
extern volatile char _indf;
extern volatile char _postinc;
extern volatile char _postdec;
extern volatile char _preinc;

extern volatile unsigned char _fsr1l;

extern volatile char _pcl;
extern volatile char _pclath;
extern volatile char _pclatu;
extern volatile char _status;
extern volatile char _tosl;
extern volatile char _tosh;
extern volatile char _tosu;
extern volatile char _bsr;
extern volatile char _wreg;
extern volatile char _intcon;
extern volatile char _rcon;
extern volatile char _stkptr;
#line 249 "c:/users/joser/daq limon/programa pic/osa/port/pic18/osa_pic18_mikroc.h"
void _OS_JumpToTask (void);
#line 286 "c:/users/joser/daq limon/programa pic/osa/port/pic18/osa_pic18_mikroc.h"
extern void _OS_ReturnSave (void);
extern void _OS_ReturnNoSave (void);
extern void _OS_EnterWaitMode (void);
extern void _OS_EnterWaitModeTO (void);

extern void _OS_SET_FSR_CUR_TASK (void);
#line 394 "c:/users/joser/daq limon/programa pic/osa/port/pic18/osa_pic18_mikroc.h"
char OS_DI (void);
void OS_RI (char);
#line 416 "c:/users/joser/daq limon/programa pic/osa/port/pic18/osa_pic18_mikroc.h"
extern void _OS_CheckEvent (OST_UINT);
#line 1087 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef  unsigned char  OST_SMSG;
#line 1105 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef  void *  OST_MSG;







typedef

 volatile

 struct _OST_MSG_CB
{
 OST_UINT status;
 OST_MSG msg;

} OST_MSG_CB;
#line 1134 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef struct
{
 OST_UINT cSize;
 OST_UINT cFilled;
 OST_UINT cBegin;

} OST_QUEUE_CONTROL;




typedef struct
{
 OST_QUEUE_CONTROL Q;
 OST_MSG *pMsg;

} OST_QUEUE;




typedef struct
{
 OST_QUEUE_CONTROL Q;
 OST_SMSG *pSMsg;

} OST_SQUEUE;
#line 1185 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef struct
{
 OST_UINT bEventError : 1;
 OST_UINT bError : 1;

 OST_UINT bInCriticalSection : 1;

 OST_UINT bCheckingTasks : 1;


 OST_UINT bBestTaskFound : 1;





  OST_UINT bTimeout : 1; OST_UINT bGIE_CTemp : 1; OST_UINT bGIEL_CTemp : 1; 



 OST_UINT bEventOK : 1;







} OST_SYSTEM_FLAGS;
#line 1230 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef struct
{
 OST_UINT cPriority : 3;
 OST_UINT bReady : 1;
 OST_UINT bDelay : 1;


 OST_UINT bCanContinue: 1;
 OST_UINT bEnable : 1;
 OST_UINT bPaused : 1;


  


} OST_TASK_STATE;
#line 1265 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef struct
{
 OST_TASK_STATE State;
  unsigned long  pTaskPointer;




  



  OST_UINT32  Timer;


} OST_TCB;
#line 1472 "c:/users/joser/daq limon/programa pic/osa/osa.h"
typedef OST_UINT8 OST_CSEM;
#line 1501 "c:/users/joser/daq limon/programa pic/osa/osa.h"
extern volatile   OST_SYSTEM_FLAGS _OS_Flags;
extern   OST_UINT _OS_Temp;


extern volatile   OST_UINT _OS_TempH;




extern volatile   OST_TASK_STATE _OS_State;
#line 1522 "c:/users/joser/daq limon/programa pic/osa/osa.h"
extern   OST_TCB *    volatile _OS_CurTask;
#line 1558 "c:/users/joser/daq limon/programa pic/osa/osa.h"
 extern   OST_UINT _OS_Best_Priority;
 extern   OST_UINT _OS_Worst_Priority;
 extern   OST_UINT _OS_Best_n;
 extern   OST_UINT _OS_Cur_Pos;
 extern   OST_UINT _OS_n;
 extern   OST_UINT8 _OS_TaskQueue[ 3 ];
 extern   OST_UINT8 _OS_TaskLevel[ 3 ];
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/osa_oldnames.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/system/osa_system.h"
#line 48 "c:/users/joser/daq limon/programa pic/osa/kernel/system/osa_system.h"
extern void OS_Init (void);



extern void OS_EnterCriticalSection (void);
extern void OS_LeaveCriticalSection (void);
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/system/osa_tasks.h"
#line 37 "c:/users/joser/daq limon/programa pic/osa/kernel/system/osa_tasks.h"
extern   OST_TCB _OS_Tasks[ 3 ];






void _OS_Task_Create(OST_UINT priority,  unsigned long  TaskAddr);
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/events/osa_bsem.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/events/osa_csem.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/events/osa_flag.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/events/osa_msg.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/events/osa_queue.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/events/osa_smsg.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/events/osa_squeue.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_stimer.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_stimer_old.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_dtimer.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_qtimer.h"
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_ttimer.h"
#line 53 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_ttimer.h"
void _OS_InitDelay( OST_UINT32  Delay);
#line 1 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_timer.h"
#line 53 "c:/users/joser/daq limon/programa pic/osa/kernel/timers/osa_timer.h"
 extern void OS_Timer (void);
#line 8 "C:/Users/joser/DAQ limon/Programa PIC/MyProject.c"
unsigned char readbuff[64] absolute 0x500;
unsigned char writebuff[64] absolute 0x540;

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
#line 26 "C:/Users/joser/DAQ limon/Programa PIC/MyProject.c"
void Thread1(void)
{
 while(1)
 {
 USB_Polling_Proc();
  { _OS_InitDelay(1); { _OS_ReturnSave(); asm{ nop } ; } ; } ;
 }
}
#pragma funcall main Thread2
#line 36 "C:/Users/joser/DAQ limon/Programa PIC/MyProject.c"
void Thread2(void)
{
 while(1)
 {

 writebuff[0] = 0x01;
 writebuff[1] = ADC_Get_Sample(5) >> 2;
 writebuff[2] = ADC_Get_Sample(2) >> 2;
 writebuff[3] = ADC_Get_Sample(4) >> 2;
 writebuff[4] = ADC_Get_Sample(7) >> 2;
 writebuff[5] = ADC_Get_Sample(6) >> 2;
 writebuff[6] = PORTB;


 if(HID_Write(&writebuff, 64) == 0) {
  RC6_bit  = 0;
 } else {
  RC6_bit  = 1;
 }
  { _OS_InitDelay(1); { _OS_ReturnSave(); asm{ nop } ; } ; } ;
 }
}
#pragma funcall main Thread3
#line 60 "C:/Users/joser/DAQ limon/Programa PIC/MyProject.c"
void Thread3(void)
{
 while(1)
 {

 if(HID_Read() == 0) {
  RC6_bit  = 1;
 } else {
  RC6_bit  = 0;
 }


  RC0_bit  = 0;  RC1_bit  = 0;  RC2_bit  = 0;
 PORTD = readbuff[1];
  { _OS_InitDelay(1); { _OS_ReturnSave(); asm{ nop } ; } ; } ;
  RC2_bit  = 1;

  RC0_bit  = 0;  RC1_bit  = 1;  RC2_bit  = 0;
 PORTD = readbuff[2];
  { _OS_InitDelay(1); { _OS_ReturnSave(); asm{ nop } ; } ; } ;
  RC2_bit  = 1;

  RC0_bit  = 1;  RC1_bit  = 0;  RC2_bit  = 0;
 PORTD = readbuff[3];
  { _OS_InitDelay(1); { _OS_ReturnSave(); asm{ nop } ; } ; } ;
  RC2_bit  = 1;

  RC0_bit  = 1;  RC1_bit  = 1;  RC2_bit  = 0;
 PORTD = readbuff[4];
  { _OS_InitDelay(1); { _OS_ReturnSave(); asm{ nop } ; } ; } ;
  RC2_bit  = 1;

 PORTD = readbuff[5];
  RC7_bit  = 1;
  { _OS_InitDelay(1); { _OS_ReturnSave(); asm{ nop } ; } ; } ;
  RC7_bit  = 0;
 }
}

void main() {
 HID_Enable(&readbuff, &writebuff);


 ADCON1 = 0x07;
 ADFM_bit = 0;
 TRISB = 0xFF;
 TRISC = 0;
 TRISE = 0xFF;
 TRISA = 0xFF;
 TRISD = 0;
 PORTD = 0;


 ADC_Init();
 OS_Init();


  { _OS_Task_Create(0, ( unsigned long )&(Thread3)); } ;
  { _OS_Task_Create(1, ( unsigned long )&(Thread2)); } ;
  { _OS_Task_Create(2, ( unsigned long )&(Thread1)); } ;


 InitTimer0();


  for(;;) { _OS_Flags.bBestTaskFound = 0; _OS_Flags.bCheckingTasks = 1; _OS_Best_Priority = 0; _OS_Worst_Priority = 0; ; _OS_n = 3 ; do { _OS_Cur_Pos = _OS_TaskQueue[_OS_n-1];  _OS_CurTask = &_OS_Tasks[_OS_Cur_Pos]; _OS_State = _OS_CurTask->State ; if (! _OS_State.bEnable  || _OS_State.bPaused ) goto _OS_SCHED_CONTINUE; ; if (! _OS_State.bReady )  { _OS_SCHED_RUN:; _OS_JumpToTask() ; _OS_SET_FSR_CUR_TASK(); _indf &= ~( 0x08  | 0x20 ); _indf |= *((char*)&_OS_State) & ( 0x08  | 0x20 ); ; ; if (!_OS_Flags.bCheckingTasks) { if ( _OS_State.bReady  || _OS_Flags.bEventOK) { _OS_TaskLevel[_OS_Cur_Pos] -= _OS_Worst_Priority; _OS_n = _OS_Best_n; while (_OS_n) { _OS_TaskQueue[_OS_n] = _OS_TaskQueue[_OS_n-1]; _OS_n--; } _OS_TaskQueue[0] = _OS_Cur_Pos; ; } goto SCHED_END; } } if ( _OS_State.bDelay  && ! _OS_State.bCanContinue ) goto _OS_SCHED_CONTINUE; ; if ( _OS_State.bReady )  { _OS_Temp = _OS_TaskLevel[_OS_Cur_Pos]; if (!(_OS_Temp & 0x80)) { _OS_Temp += 8; _OS_Temp -= _OS_CurTask->State.cPriority; _OS_TaskLevel[_OS_Cur_Pos] = _OS_Temp; } ; if (_OS_Temp > _OS_Best_Priority) { _OS_Worst_Priority = _OS_Best_Priority; _OS_Best_Priority = _OS_Temp; _OS_Best_n = _OS_n-1; _OS_Flags.bBestTaskFound = 1; } else if (_OS_Temp > _OS_Worst_Priority) { _OS_Worst_Priority = _OS_Temp; } } _OS_SCHED_CONTINUE:;  } while ( 1  && --_OS_n); if (_OS_Flags.bBestTaskFound) { _OS_Flags.bCheckingTasks = 0; _OS_Flags.bEventOK = 0; _OS_Cur_Pos = _OS_TaskQueue[_OS_Best_n]; _OS_CurTask = &_OS_Tasks[_OS_Cur_Pos]; _OS_State = _OS_CurTask->State ; if ( _OS_State.bEnable  && ! _OS_State.bPaused ) goto _OS_SCHED_RUN; } SCHED_END:; } ;
}

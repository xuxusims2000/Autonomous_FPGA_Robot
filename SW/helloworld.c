

//libraris
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xgpio.h"
#include "xparameters.h"
#include "xscugic.h"
#include "xil_exception.h"

#define LEFT_DISTNACE_DEVICE_ID			XPAR_AXI_GPIO_0_DEVICE_ID	//GPIO for LEFT distance sensor
#define RIGHT_DISTNACE2_DEVICE_ID		XPAR_AXI_GPIO_1_DEVICE_ID
#define FRONT_DISTNACE3_DEVICE_ID		XPAR_AXI_GPIO_2_DEVICE_ID
#define OPERATION_ID					XPAR_AXI_GPIO_4_DEVICE_ID	//GPIO for mood(CH2) and on_off(CH1) sw
#define MANUAL_ID						XPAR_AXI_GPIO_3_DEVICE_ID
#define CHANEL1	1
#define CHANEL2	2


// definig the velocities that the motors can reach remember that we are thinking in binary
// MSF represents the direction and the other 3 represents the gear (velocity)
#define STOP 0	//0000
#define F_v1 1	//0001
#define F_v2 2  //0010
#define F_v3 3	//0011
#define F_v4 4	//0100
#define F_v5 5	//0101

#define B_v1 9	//1001
#define B_v2 10	//1010
#define B_v3 11	//1011
#define B_v4 12	//1100
#define B_v5 13	//1101

// defining diferent orders that we can recive frome the manual mode , rmember we are thinking in binary
#define M_FORWARD	1	//0001
#define M_RIGHT		2	//0010
#define M_LEFT		4	//0100
#define M_BACKWARD	8	//1000

#define mode_manual 0

#define action  500000 // us
#define wait 1 // seconds of delay

// Pointer to access the Motor diriver software register 16 BITS
int *Left_motor = (int *) XPAR_L293D_PWM3_0_S00_AXI_BASEADDR;
int *Right_motor = (int *) XPAR_L293D_PWM3_1_S00_AXI_BASEADDR;

//declaration of XGpio objects to manage the gpio on the board
XGpio GPIO_LEFT_distance;
XGpio GPIO_RIGHT_distance;
XGpio GPIO_FRONT_distance;
XGpio GPIO_OPERATION;
XGpio GPIO_MANUAL;


int main()
{

	int d_FRONT;	// distance in the front sensor
	int d_RIGHT;	//distance in the right sensor
	int d_LEFT;		// distance in the left sensor
	int mood;		// to define manual or authonomous mood
	int on_off;		// to tun on or off the robot
	int manual;		// to save the operation from the manual radiocontrol
	int status;

	init_platform();

    printf("Hello\n\r");

    // initialization of the XGpio instances
    status = XGpio_Initialize(&GPIO_LEFT_distance, LEFT_DISTNACE_DEVICE_ID);
    	if (status != XST_SUCCESS)
    		return XST_FAILURE;

    status = XGpio_Initialize(&GPIO_RIGHT_distance, RIGHT_DISTNACE2_DEVICE_ID);
    	if (status != XST_SUCCESS)
    		return XST_FAILURE;

    status = XGpio_Initialize(&GPIO_FRONT_distance, FRONT_DISTNACE3_DEVICE_ID);
    	if (status != XST_SUCCESS)
    		return XST_FAILURE;

    status = XGpio_Initialize(&GPIO_OPERATION, OPERATION_ID);
    	if (status != XST_SUCCESS)
    	    return XST_FAILURE;

    status = XGpio_Initialize(&GPIO_MANUAL, MANUAL_ID);
    	if (status != XST_SUCCESS)
    	    return XST_FAILURE;

    // Config GPIO channel 1 as input
    XGpio_SetDataDirection(&GPIO_LEFT_distance, CHANEL1, 0xFF);

    // Config GPIO channel 1 as input
    XGpio_SetDataDirection(&GPIO_RIGHT_distance, CHANEL1, 0xFF);

    // Config GPIO channel 1 as input
    XGpio_SetDataDirection(&GPIO_FRONT_distance, CHANEL1, 0xFF);

    // Config GPIO on_off channel 1 as input
    XGpio_SetDataDirection(&GPIO_OPERATION, CHANEL1, 0xFF);

    // Config GPIO mood channel 1 as input
    XGpio_SetDataDirection(&GPIO_OPERATION, CHANEL2, 0xFF);

    // Config GPIO manual channel 1 as input
    XGpio_SetDataDirection(&GPIO_MANUAL, CHANEL1, 0xFF);

    while(1){

     	on_off = XGpio_DiscreteRead(&GPIO_OPERATION, CHANEL1); //read the gpio of the switch to torn on or off the vehicle
     	mood = XGpio_DiscreteRead(&GPIO_OPERATION, CHANEL2); // read the gpio to now what mood is on.

    	//reading distance sensors -- remember that the IP outputs the distance in 9 bits but already in cm
     	d_LEFT = XGpio_DiscreteRead(&GPIO_LEFT_distance, CHANEL1);
    	d_RIGHT = XGpio_DiscreteRead(&GPIO_RIGHT_distance, CHANEL1);
    	d_FRONT = XGpio_DiscreteRead(&GPIO_FRONT_distance, CHANEL1);

    	//print the lectures on the terminal
    	printf("Distancia LEFT = %d\n",d_LEFT);
    	printf("Distancia RIGHT = %d\n",d_RIGHT);
     	printf("Distancia FRONT = %d\n\r",d_FRONT);
     	printf("on_off = %d\n",on_off);
     	printf("mood = %d\n",mood);
     	//sleep(1);

     	if(on_off == 0){  // if the on_off is set to off the veihcle wount move
     		*Left_motor = STOP; // set the AXI registers of the motors
     		*Right_motor =STOP;
     		sleep(wait);
     	}

     	else {

     		if (mood == mode_manual) {  // chec for the mode mood = 0

     			manual = XGpio_DiscreteRead(&GPIO_MANUAL, CHANEL1); // if manual we will read the controller
     			printf("manual = %d\n\r",manual);

     			if (manual == M_FORWARD){
     				printf("ordre manual = %d\n",manual);
     				*Left_motor = F_v2; // this action set the left motor with the veloctiy 2
     				*Right_motor = F_v2;
     			}

     			else if (manual == M_BACKWARD){
     			     *Left_motor = B_v2;
     			     *Right_motor = B_v2;
     			}

     			else if (manual == M_RIGHT){
     			     *Left_motor = F_v2;
     			     *Right_motor = B_v2;
     			}

     			else if (manual == M_LEFT){
     			     *Left_motor = B_v2;
     			     *Right_motor = F_v2;
     			}
     		}

     		else { // if the mood is authonomous the veihcle will follow the next algorithm
     			*Left_motor = F_v3;
     			*Right_motor =F_v3;
     			//sleep(wait);

     			if (d_FRONT < 15 ){
				*Left_motor = STOP;
				*Right_motor =STOP;
				sleep(wait*2); // it waits for 2s

					if(d_LEFT < 15 & d_RIGHT < 15 ){
						*Left_motor = F_v3;
						*Right_motor = B_v3;
						usleep(action*2); //will act for 4s wich will macke the vehicle rotate 180
						*Left_motor = STOP;
						*Right_motor =STOP;
						sleep(wait*2);
												}
					else if (d_LEFT < 15 & d_RIGHT > 15){
						*Left_motor = F_v3;
						*Right_motor =B_v3;
						usleep(action);
						*Left_motor = STOP;
						*Right_motor =STOP;
						sleep(wait*2);
						//RIGHT_Turn(&Left_motor, &Right_motor);
												}
					else{
						*Left_motor = B_v3;
						*Right_motor =F_v3;
						usleep(action);
						*Left_motor = STOP;
						*Right_motor =STOP;
						sleep(wait*2);
						//LEFT_Turn(&Left_motor, &Right_motor);
											}
									}
     			}
     	}

    }

    cleanup_platform();
    return 0;
}

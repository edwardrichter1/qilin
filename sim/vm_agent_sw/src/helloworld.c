/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "xparameters.h"
#include "platform.h"
#include "xil_printf.h"
#include "ats.h"
#include "coyote.h"
#include "xgpio.h"

#define USE_COYOTE              0
#define USE_ATS                 1
#define USE_DEVICE_PAGE_TABLE   2

// The implementation we are using
#define VM_IMPL 2

// If we are using the cache_overlap
// optimization, we must configure some
// of the IPs
#define USE_CACHE_OVERLAP 0

u32 miss_vaddr_hi       = 0;
u32 miss_vaddr_lo       = 0;
u32 miss_length         = 0;
u32 paddr_hi            = 0;
u32 paddr_lo            = 0;
u32 way                 = 0;

XGpio Gpio; /* The Instance of the GPIO Driver */

// Contains the H2C descriptor
struct h2c_byp_in h2c_desc;

// Contains the H2C data
struct m_axis_h2c h2c_data;

// Contains input messages
struct in_msg in_msg_data;

// Need to keep track of invalidates
// as we get to before the system boots
int num_invalidates_received = 0;

int main()
{
    init_platform();

    // Using GPIO to set whether we are using ATS or not
#if VM_IMPL == USE_ATS
    int Status = XGpio_Initialize(&Gpio, XPAR_GPIO_0_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("Gpio Initialization Failed\r\n");
		return XST_FAILURE;
	}

	// Set it to an output
	XGpio_SetDataDirection(&Gpio, 1, 0);

	// Write 1 to set ATS
	if(USE_CACHE_OVERLAP) {
		XGpio_DiscreteWrite(&Gpio, 1, 3);
	}
	else {
		XGpio_DiscreteWrite(&Gpio, 1, 1);
	}

#elif VM_IMPL == USE_DEVICE_PAGE_TABLE

	int Status = XGpio_Initialize(&Gpio, XPAR_GPIO_0_DEVICE_ID);
	if (Status != XST_SUCCESS) {
		xil_printf("Gpio Initialization Failed\r\n");
		return XST_FAILURE;
	}

	// Set it to an output
	XGpio_SetDataDirection(&Gpio, 1, 0);

	// Write 1 to device page table bit
	XGpio_DiscreteWrite(&Gpio, 1, 4);

#endif

    // Initialize h2c descriptor as a lot of the values won't change
    //initialize_h2c_desc(&h2c_desc);

    while(1) {

        // If we are doing ATS must check msg FIFO for invalidates
        // Check if we have any messages

        if(probe_and_read_msg_fifo(&in_msg_data)) {
			xil_printf("Msg Received: Info\r\n");
			print_msg(&in_msg_data);

			// Check if the message is an ATS invalidate
			if(check_invalidate(&in_msg_data)) {
				xil_printf("Inv\r\n");
				// Check if it is a TLB flush or not
				if(in_msg_data.addr[1] == 0xFFFFFF7F && in_msg_data.addr[0] == 0xF8FFFF) {
					//flush_tlb();
					xil_printf("Flush\r\n");
				}
				// If not a flush, invalidate the entry from the TLB
				else {
					inv_tlb(in_msg_data.addr[0], in_msg_data.addr[0]);
				}
				send_invl_completion(&in_msg_data);
				num_invalidates_received++;
			}
		}
    }

	return 0;
}

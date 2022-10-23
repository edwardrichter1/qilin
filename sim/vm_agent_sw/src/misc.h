/**
* Copyright (C) 2021 Xilinx, Inc
*
* Licensed under the Apache License, Version 2.0 (the "License"). You may
* not use this file except in compliance with the License. A copy of the
* License is located at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
* WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
* License for the specific language governing permissions and limitations
* under the License.
*/

#include "xil_types.h"
#include "xparameters.h"
#include "xil_printf.h"

#define DEBUG
//#define MM_ENABLE
//#define C2H_COMPLETION
//#define USE_TIMER

// Version of the VM agent we are using
#define VERSION     0x1


// Definitions that are consistent across all VM implementations
#define XPAR_VM_AGENT_QDMA_SHIM_0_S00_AXI_BASEADDR 0 //  Don't use the shim anymore, so just setting to 0
#define VM_AGENT_SHIM_STATUS 	0x44
#define VM_AGENT_SHIM(X) 		*(u32 *)(XPAR_VM_AGENT_QDMA_SHIM_0_S00_AXI_BASEADDR + X) // Don't use the shim anymore

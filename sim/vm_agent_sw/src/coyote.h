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
#include "misc.h"

// IRQ Stuff
#define USR_IRQ_OFFSET				0x1C
#define USR_IRQ_OUT_MASK			0x00000004
#define USR_IRQ_OUT_ACK_MASK		0x02000000
#define USR_IRQ_MASK				0x01000000
#define USR_IRQ_IN_CLR_MASK			0x00000002



// TLB Definitions
#define TLB_VALID_MASK				0x8000000000000000
#define STLB_ASSOC					4
#define STLB_PADDR_SIZE				28
#define VADDR_SIZE					40
#define PAGE_SHIFT 					12
#define STLB_ORDER					10
#define STLB_ORDER_MASK				0b1111111111 // 2**STLB_ORDER - 1
#define STLB_PADDR_MASK				0b1111111111111111111111111111 /* 2**STLB_PADDR_SIZE - 1 */


// Cnfg slave register destination
#define VADDR_MISS_LO_CNFG_SLAVE	40
#define VADDR_MISS_HI_CNFG_SLAVE	44
#define VADDR_MISS_LN_CNFG_SLAVE	48


#define STLB_CTRL_OFFSET		0x00010000
#define CNFG_SLAVE_CTRL_OFFSET	0x00030000
#define CNFG_SLAVE_BASE_ADDR	(XPAR_AXI_CTRL_0_BASEADDR + CNFG_SLAVE_CTRL_OFFSET)
#define STLB_BASE_ADDR			(XPAR_AXI_CTRL_0_BASEADDR + STLB_CTRL_OFFSET)


// Helper functions to R/W from regs
#define CNFG_SLV(X)				*(u32 *)(CNFG_SLAVE_BASE_ADDR + X) // For some reason Coyote gets the address from bits 3:5
#define STLB(X)					*(u32 *)(STLB_BASE_ADDR + X)


// TLB function
u8 check_tlb_miss();
void write_tlb(u32 paddr_hi, u32 paddr_lo, u32 vaddr_hi, u32 vaddr_lo, u32 way);
void read_tlb_miss_vaddr(u32 *vaddr_hi, u32 *vaddr_lo, u32 *len);
void write_tlb_resume();
void clear_tlb_miss();
void write_host_interrupt();
void inv_tlb(u32 vaddr_hi, u32 vaddr_lo);


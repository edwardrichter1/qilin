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

#include "coyote.h"


u8 check_tlb_miss() {
	u32 data;

	data = VM_AGENT_SHIM(VM_AGENT_SHIM_STATUS);
	if(data & USR_IRQ_MASK)
		return 1;
	else
		return 0;
}

void clear_tlb_miss() {
	// Clear the irq_in_reg the shim
	VM_AGENT_SHIM(USR_IRQ_OFFSET) = USR_IRQ_IN_CLR_MASK;
	VM_AGENT_SHIM(USR_IRQ_OFFSET) = 0x00000000;
}

void write_tlb(u32 paddr_hi, u32 paddr_lo, u32 vaddr_hi, u32 vaddr_lo, u32 way) {

	// Going to try to do it with 64-bit variables to make it easier
	u64 paddr = ((u64)paddr_hi << 32) | paddr_lo;
	u64 vaddr = ((u64)vaddr_hi << 32) | vaddr_lo;

	// Make sure they key will always be 32-bits
	u32 key 		= (vaddr >> PAGE_SHIFT ) & STLB_ORDER_MASK;
	u64 tag 		= vaddr >> (PAGE_SHIFT + STLB_ORDER);
	u64 tlb_entry	= TLB_VALID_MASK | (tag << STLB_PADDR_SIZE) | ((paddr >> PAGE_SHIFT) & STLB_PADDR_MASK);

	//xil_printf("%x,%x", tag, tlb_entry);
	//xil_printf("%x,%x", vaddr_hi, vaddr_lo);

	// Have to split it up into two 32-bit writes
	key = 8 * key + way * ( 1 << STLB_ASSOC );
	STLB(key) 		= (u32)(tlb_entry & 0x00000000FFFFFFFF); 	// Writing lower 32-bits
	STLB(key + 4) 	= (u32)(tlb_entry >> 32);					// Writing uper 32-bits
}

/*
 * Reading the high and low components of the VA that resulted in the miss
 */
void write_tlb_resume() {

	CNFG_SLV(0)	= 0x00000100; // Setting bit to replay access

	return;
}


/*
 * Reading the high and low components of the VA that resulted in the miss
 */
void read_tlb_miss_vaddr(u32 *vaddr_hi, u32 *vaddr_lo, u32 *len) {

	*vaddr_hi 	= CNFG_SLV(VADDR_MISS_HI_CNFG_SLAVE);
	*vaddr_lo 	= CNFG_SLV(VADDR_MISS_LO_CNFG_SLAVE);
	*len		= CNFG_SLV(VADDR_MISS_LN_CNFG_SLAVE);

	return;
}

/*
 * Reading the high and low components of the VA that resulted in the miss
 */
void write_host_interrupt() {

	// Interrupt the host
	VM_AGENT_SHIM(USR_IRQ_OFFSET) = USR_IRQ_OUT_MASK;

	// Poll on the ack from DMA Engine
	while(!(USR_IRQ_OUT_ACK_MASK & VM_AGENT_SHIM(VM_AGENT_SHIM_STATUS)));

	// Clear the irq ack in the shim
	VM_AGENT_SHIM(0x00000014) = 0x00000001;
	VM_AGENT_SHIM(0x00000014) = 0x00000000;

	// Stop interrupting the host
	VM_AGENT_SHIM(USR_IRQ_OFFSET) = 0x00000000;


	return;
}

/*
 * Invalidates the entry with vaddr_hi and vaddr_lo in
 * the TLB.
 *
 * TODO: Also integrate with large TLB
 */
void inv_tlb(u32 vaddr_hi, u32 vaddr_lo) {

	//
	u64 tlb_entry;
	u64 tlb_entry_vaddr;


	// Getting the entire vaddr
	u64 vaddr = ((u64)vaddr_hi << 32) | vaddr_lo;
	//u64 tag   = vaddr >> (PAGE_SHIFT + STLB_ORDER);

	// Make sure they key will always be 32-bits
	u32 key = (vaddr >> PAGE_SHIFT ) & STLB_ORDER_MASK;

	for(int way = 0; way < STLB_ASSOC; way++) {
		// Calculate the actual key with the appropriate way
		key = 8 * key + way * ( 1 << STLB_ASSOC );

		// Reading the tlb entry
		tlb_entry 		= ((u64)STLB(key + 4) << 32) | STLB(key);
		//xil_printf("%x", tlb_entry);

		// reconstructing the vaddr from the tlb entry
		tlb_entry_vaddr = (tlb_entry >> STLB_PADDR_SIZE) & STLB_ORDER;

		// If the vaddr matches, invalidate it
		if(tlb_entry_vaddr == vaddr) {
			//xil_printf("v");

			// Writing all 0's to the upper 32-bits which has the valid bit in it
			STLB(key + 4) 	= 0x00000000;
			return;
		}
	}

}

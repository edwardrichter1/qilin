//-----------------------------------------------------------------------------
//
// (c) Copyright 2012-2012 Xilinx, Inc. All rights reserved.
//
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
//
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
//
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
//
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
//
//-----------------------------------------------------------------------------
//
// Project    : The Xilinx PCI Express DMA 
// File       : sample_tests.vh
// Version    : 5.0
//-----------------------------------------------------------------------------
//
//------------------------------------------------------------------------------


else if(testname =="irq_test0")
begin
   qid = 11'h0;
   board.RP.tx_usrapp.TSK_QDMA_MM_H2C_TEST(qid, 0, 0);
   #1000;
   board.RP.tx_usrapp.TSK_USR_IRQ_TEST;   

end
else if(testname =="qdma_mm_test0")
begin
   qid = 11'h1;
   board.RP.tx_usrapp.TSK_QDMA_MM_H2C_TEST(qid, 0, 1);
   board.RP.tx_usrapp.TSK_QDMA_MM_C2H_TEST(qid, 0, 1);
   #1000;
   board.RP.tx_usrapp.pfTestIteration = board.RP.tx_usrapp.pfTestIteration + 1;
   if (board.RP.tx_usrapp.test_state == 1 )
     $display ("ERROR: TEST FAILED \n");
   #1000;
   $finish;
end
else if(testname =="qdma_mm_cmpt_test0")
begin
   qid = 11'h0;
   board.RP.tx_usrapp.TSK_QDMA_MM_H2C_TEST(qid, 0, 0);
   board.RP.tx_usrapp.TSK_QDMA_MM_C2H_TEST(qid, 0, 0);
   board.RP.tx_usrapp.TSK_QDMA_IMM_TEST(qid);
   #1000;
   board.RP.tx_usrapp.pfTestIteration = board.RP.tx_usrapp.pfTestIteration + 1;
   if (board.RP.tx_usrapp.test_state == 1 )
     $display ("ERROR: TEST FAILED \n");
   #1000;
   $finish;
end

else if(testname == "qdma_st_test0")
begin
//   qid = 11'h3;
//   board.RP.tx_usrapp.TSK_QDMA_ST_C2H_TEST(qid, 0);
//   board.RP.tx_usrapp.TSK_QDMA_ST_H2C_TEST(qid, 0);
//   #1000;
//   board.RP.tx_usrapp.pfTestIteration = board.RP.tx_usrapp.pfTestIteration + 1;
//    if (board.RP.tx_usrapp.test_state == 1 )
//     $display ("ERROR: TEST FAILED \n");
//   #1000;
   $finish;
end
else if(testname == "qdma_st_c2h_simbyp_test0")
begin
   qid = 11'h3;
   board.RP.tx_usrapp.TSK_QDMA_ST_C2H_SIMBYP_TEST(qid, 1);
   #1000;
   board.RP.tx_usrapp.pfTestIteration = board.RP.tx_usrapp.pfTestIteration + 1;
    if (board.RP.tx_usrapp.test_state == 1 )
     $display ("ERROR: TEST FAILED \n");
   #1000;
   $finish;
end
else if(testname == "qdma_imm_test0")
begin
   qid = 11'h2;
   board.RP.tx_usrapp.TSK_QDMA_IMM_TEST(qid);
   #1000;
   board.RP.tx_usrapp.pfTestIteration = board.RP.tx_usrapp.pfTestIteration + 1;
    if (board.RP.tx_usrapp.test_state == 1 )
     $display ("ERROR: TEST FAILED \n");
   #1000;
   $finish;
end
else if(testname == "soft_contr_host_memory")
begin
    
    // Initializing DATA_STORE to all zeros. Can run into issues if read don't cares 
    // from data store array
    board.RP.tx_usrapp.TSK_INIT_DATA_STORE;
    
    #5000000;
    
    // Assign Q 2 for AXI-ST
    pf0_qmax = 11'h200;
    axi_st_q = 11'h0;
                
     for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WRITING NODE %d***\n", $realtime, tlb_allocate_iterator);
        
        TSK_LNK_LIST_NODE_WRITE((tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                              // Physical address
                                tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                    // virtual address
                                {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000});  // data
        
        TSK_TX_CLK_EAT(50);
    end
    
    
    // Have to initialize the migration stuff
    TSK_TX_CLK_EAT(5);
    TSK_TX_BAR_WRITE_64(2, 'h0100_0030, DEFAULT_TAG, DEFAULT_TC, 0);
    TSK_TX_CLK_EAT(5);
    
    // Writing to the device page tables. Not wiritng to the L1 PTEs as they are in host memory and must be migrated over
    TSK_TX_BAR_WRITE_64(2, 'h2000_0000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_1000 /* Physical address */});    // 0x0000 as L4 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_1000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_2000 /* Physical address */});    // 0x1000 as L3 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_2000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_3000 /* Physical address */});    // 0x2000 as L2 PTE
    TSK_TX_CLK_EAT(10);
    

    $display("ENGINE PROGRAMMING OVER. BEGINNING BRING-UP TEST");
    
    $display(" **** WRITING TO USER APP CSR ***\n");
    TSK_TX_BAR_WRITE_64(2, 'h0012_0008, DEFAULT_TAG, DEFAULT_TC, 64'd5);    // Number of requests
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0018, DEFAULT_TAG, DEFAULT_TC, 64'd40960);// Bound register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0020, DEFAULT_TAG, DEFAULT_TC, 64'd64); // Request Size
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0028, DEFAULT_TAG, DEFAULT_TC, 64'd1024); // Stride register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0030, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Access Pattern
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0038, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Independent
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0010, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Ptr
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0040, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 0
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0048, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_5000);    // Base address 1
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0050, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_8000);    // Base address 2
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0058, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 3
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0060, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 4
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0068, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 5
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0070, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 6
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0078, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 7
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0080, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 8
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0088, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 9
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0090, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 10
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0098, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 11
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 12
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 13
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 14
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 15
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b1});    // Set AP_START to 1 for linked list modules from 0 - [4:1]
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b0});    // Set AP_START to 0
    
    // Waiting for each interrupt
    for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WAITING FOR QDMA TO ACK IRQ %d***\n", $realtime, tlb_allocate_iterator);
        wait (board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
        
        // Handling the interrupts generated by the page table walker because it can't find a valid L1 PTE
        TSK_TRANSLATION_WRITE(64'h0000_0000_0000_A000 + (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_2000,  // Card Physical address
                    (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                                      // Host physical address
                    tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                            // virtual address
                    {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000},           // data
                    64'h0000_0000_0000_0000,                                                                    // way
                    0,                                                                                          // ATS
                    0,                                                                                          // Device Page Table
                    {32'd0, 32'h2000_3000 + (tlb_allocate_iterator)*8},                                         // Page Table Address
                    2'd0);                                                                                      // Access_mode  // 00 = Access on host
                                                                                                                // 01 = Access on card
                                                                                                                // 10 = Migrate from host to Card and access on card
        
        TSK_TX_CLK_EAT(50);
   end
   
   // Polling on num_requests_recved
   TSK_REG_READ(2, 'h0012_0008);
   while(P_READ_DATA[31:0] != 5) begin
       TSK_REG_READ(2, 'h0012_0008);
   end
   $display("[%t] : **** Test Complete ***\n", $realtime);
   
   $finish;
   
end
else if(testname == "soft_contr_dev_memory")
begin
    
    // Initializing DATA_STORE to all zeros. Can run into issues if read don't cares 
    // from data store array
    board.RP.tx_usrapp.TSK_INIT_DATA_STORE;
    
    #5000000;
    
    // Assign Q 2 for AXI-ST
    pf0_qmax = 11'h200;
    axi_st_q = 11'h0;
                
     for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WRITING NODE %d***\n", $realtime, tlb_allocate_iterator);
        
        TSK_LNK_LIST_NODE_WRITE((tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                              // Physical address
                                tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                    // virtual address
                                {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000});  // data
        
        TSK_TX_CLK_EAT(50);
    end
    
    
    // Have to initialize the migration stuff
    TSK_TX_CLK_EAT(5);
    TSK_TX_BAR_WRITE_64(2, 'h0100_0030, DEFAULT_TAG, DEFAULT_TC, 0);
    TSK_TX_CLK_EAT(5);
    
    // Writing to the device page tables. Not wiritng to the L1 PTEs as they are in host memory and must be migrated over
    TSK_TX_BAR_WRITE_64(2, 'h2000_0000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_1000 /* Physical address */});    // 0x0000 as L4 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_1000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_2000 /* Physical address */});    // 0x1000 as L3 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_2000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_3000 /* Physical address */});    // 0x2000 as L2 PTE
    TSK_TX_CLK_EAT(10);
    

    $display("ENGINE PROGRAMMING OVER. BEGINNING BRING-UP TEST");
    
    $display(" **** WRITING TO USER APP CSR ***\n");
    TSK_TX_BAR_WRITE_64(2, 'h0012_0008, DEFAULT_TAG, DEFAULT_TC, 64'd5);    // Number of requests
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0018, DEFAULT_TAG, DEFAULT_TC, 64'd40960);// Bound register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0020, DEFAULT_TAG, DEFAULT_TC, 64'd64); // Request Size
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0028, DEFAULT_TAG, DEFAULT_TC, 64'd1024); // Stride register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0030, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Access Pattern
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0038, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Independent
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0010, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Ptr
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0040, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 0
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0048, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_5000);    // Base address 1
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0050, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_8000);    // Base address 2
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0058, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 3
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0060, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 4
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0068, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 5
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0070, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 6
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0078, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 7
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0080, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 8
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0088, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 9
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0090, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 10
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0098, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 11
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 12
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 13
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 14
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 15
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b1});    // Set AP_START to 1 for linked list modules from 0 - [4:1]
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b0});    // Set AP_START to 0
    
    // Waiting for each interrupt
    for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WAITING FOR QDMA TO ACK IRQ %d***\n", $realtime, tlb_allocate_iterator);
        wait (board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
        
        // Handling the interrupts generated by the page table walker because it can't find a valid L1 PTE
        TSK_TRANSLATION_WRITE(64'h0000_0000_0000_A000 + (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_2000,  // Card Physical address
                    (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                                      // Host physical address
                    tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                            // virtual address
                    {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000},           // data
                    64'h0000_0000_0000_0000,                                                                    // way
                    0,                                                                                          // ATS
                    0,                                                                                          // Device Page Table
                    {32'd0, 32'h2000_3000 + (tlb_allocate_iterator)*8},                                         // Page Table Address
                    2'd2);                                                                                      // Access_mode  // 00 = Access on host
                                                                                                                // 01 = Access on card
                                                                                                                // 10 = Migrate from host to Card and access on card
        
        TSK_TX_CLK_EAT(50);
   end
   
   // Polling on num_requests_recved
   TSK_REG_READ(2, 'h0012_0008);
   while(P_READ_DATA[31:0] != 5) begin
       TSK_REG_READ(2, 'h0012_0008);
   end
   $display("[%t] : **** Test Complete ***\n", $realtime);
   
   $finish;
   
end
else if(testname == "hard_contr_host_memory")
begin
    
    // Initializing DATA_STORE to all zeros. Can run into issues if read don't cares 
    // from data store array
    board.RP.tx_usrapp.TSK_INIT_DATA_STORE;
    
    #5000000;
    
    // Assign Q 2 for AXI-ST
    pf0_qmax = 11'h200;
    axi_st_q = 11'h0;
                
     for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WRITING NODE %d***\n", $realtime, tlb_allocate_iterator);
        
        TSK_LNK_LIST_NODE_WRITE((tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                              // Physical address
                                tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                    // virtual address
                                {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000});  // data
        
        TSK_TX_CLK_EAT(50);
    end
    
    
    // Have to initialize the migration stuff
    TSK_TX_CLK_EAT(5);
    TSK_TX_BAR_WRITE_64(2, 'h0100_0030, DEFAULT_TAG, DEFAULT_TC, 0);
    TSK_TX_CLK_EAT(5);
    

    $display("ENGINE PROGRAMMING OVER. BEGINNING BRING-UP TEST");
    
    $display(" **** WRITING TO USER APP CSR ***\n");
    TSK_TX_BAR_WRITE_64(2, 'h0012_0008, DEFAULT_TAG, DEFAULT_TC, 64'd5);    // Number of requests
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0018, DEFAULT_TAG, DEFAULT_TC, 64'd40960);// Bound register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0020, DEFAULT_TAG, DEFAULT_TC, 64'd64); // Request Size
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0028, DEFAULT_TAG, DEFAULT_TC, 64'd1024); // Stride register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0030, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Access Pattern
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0038, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Independent
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0010, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Ptr
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0040, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 0
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0048, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_5000);    // Base address 1
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0050, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_8000);    // Base address 2
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0058, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 3
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0060, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 4
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0068, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 5
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0070, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 6
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0078, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 7
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0080, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 8
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0088, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 9
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0090, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 10
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0098, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 11
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 12
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 13
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 14
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 15
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b1});    // Set AP_START to 1 for linked list modules from 0 - [4:1]
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b0});    // Set AP_START to 0
    
    // Waiting for each interrupt
    for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        //$display("[%t] : **** WAITING FOR QDMA TO ACK IRQ %d***\n", $realtime, tlb_allocate_iterator);
        //wait (board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
        
        // Handling the interrupts generated by the page table walker because it can't find a valid L1 PTE
        TSK_TRANSLATION_WRITE(64'h0000_0000_0000_A000 + (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_2000,  // Card Physical address
                    (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                                      // Host physical address
                    tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                            // virtual address
                    {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000},           // data
                    64'h0000_0000_0000_0000,                                                                    // way
                    1,                                                                                          // ATS
                    0,                                                                                          // Device Page Table
                    {32'd0, 32'h2000_3000 + (tlb_allocate_iterator)*8},                                         // Page Table Address
                    2'd0);                                                                                      // Access_mode  // 00 = Access on host
                                                                                                                                // 01 = Access on card
                                                                                                                                // 10 = Migrate from host to Card and access on card
        
        TSK_TX_CLK_EAT(50);
   end
   
   // Polling on num_requests_recved
   TSK_REG_READ(2, 'h0012_0008);
   while(P_READ_DATA[31:0] != 5) begin
       TSK_REG_READ(2, 'h0012_0008);
   end
   $display("[%t] : **** Test Complete ***\n", $realtime);
   
   $finish;
   
end
else if(testname == "device_page_table_host_memory")
begin
    //--------------------------------------------------------------------------
    // Direct Root Port to allow upstream traffic by enabling Mem, I/O and
    // BusMstr in the command register
    //--------------------------------------------------------------------------
//    $display("[%t] : Direct Root Port to allow upstream traffic by enabling Mem, I/O and  BusMstr in the command register", $realtime);   
//    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
//    board.RP.cfg_usrapp.TSK_WRITE_CFG_DW(32'h00000001, 32'h00000007, 4'b0001);
//    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
    
    // Initializing DATA_STORE to all zeros. Can run into issues if read don't cares 
    // from data store array
    board.RP.tx_usrapp.TSK_INIT_DATA_STORE;
    
    #5000000;
    
    // Assign Q 2 for AXI-ST
    pf0_qmax = 11'h200;
    axi_st_q = 11'h0;
                
      // Now that we are putting the buffer at 0xF000 it will just wrap over
//    TSK_TRANSLATION_WRITE(64'h0000_0000_0000_C000,     // Physical address
//                64'h0000_0000_0000_C000,    // virtual address
//                128'h0000_0000_0000_0000_0000_0000_FEED_EDED,    // data
//                64'h0000_0000_0000_0000,    // way
//                ats_reg);                   // ATS
    
    
     for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WRITING NODE %d***\n", $realtime, tlb_allocate_iterator);
        
        TSK_LNK_LIST_NODE_WRITE((tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                              // Physical address
                                tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                    // virtual address
                                {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000});  // data
        
        TSK_TX_CLK_EAT(50);
    end
    
    
    // Have to initialize the migration stuff
    TSK_TX_CLK_EAT(5);
    TSK_TX_BAR_WRITE_64(2, 'h0100_0030, DEFAULT_TAG, DEFAULT_TC, 0);
    TSK_TX_CLK_EAT(5);
    
    // Writing to the device page tables
    TSK_TX_BAR_WRITE_64(2, 'h2000_0000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_1000 /* Physical address */});    // 0x0000 as L4 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_1000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_2000 /* Physical address */});    // 0x1000 as L3 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_2000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_3000 /* Physical address */});    // 0x2000 as L2 PTE
    TSK_TX_CLK_EAT(10);
    

    // This is writing L1 PTEs to access host memory    
    TSK_TX_BAR_WRITE_64(2, 'h2000_3000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_1000 /* Physical address */});    // 0x1000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3008, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_2000 /* Physical address */});    // 0x2000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3010, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_3000 /* Physical address */});    // 0x3000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3018, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_4000 /* Physical address */});    // 0x4000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3020, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */,  1'd0 /* Host or Device */, 48'h0000_0000_5000 /* Physical address */});    // 0x5000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);


    $display("ENGINE PROGRAMMING OVER. BEGINNING BRING-UP TEST");
    
    $display(" **** WRITING TO USER APP CSR ***\n");
    TSK_TX_BAR_WRITE_64(2, 'h0012_0008, DEFAULT_TAG, DEFAULT_TC, 64'd5);    // Number of requests
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0018, DEFAULT_TAG, DEFAULT_TC, 64'd40960);// Bound register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0020, DEFAULT_TAG, DEFAULT_TC, 64'd64); // Request Size
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0028, DEFAULT_TAG, DEFAULT_TC, 64'd1024); // Stride register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0030, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Access Pattern
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0038, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Independent
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0010, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Ptr
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0040, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 0
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0048, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_5000);    // Base address 1
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0050, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_8000);    // Base address 2
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0058, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 3
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0060, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 4
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0068, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 5
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0070, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 6
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0078, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 7
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0080, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 8
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0088, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 9
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0090, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 10
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0098, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 11
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 12
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 13
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 14
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 15
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b1});    // Set AP_START to 1 for linked list modules from 0 - [4:1]
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b0});    // Set AP_START to 0
    
    // Waiting for each interrupt
    /*for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WAITING FOR QDMA TO ACK IRQ %d***\n", $realtime, tlb_allocate_iterator);
        wait (board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
        
        TSK_TRANSLATION_WRITE(64'h0000_0000_0000_A000 + (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_2000,  // Card Physical address
                    (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                                      // Host physical address
                    tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                            // virtual address
                    {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000},           // data
                    64'h0000_0000_0000_0000,                                                                    // way
                    0,                                                                                          // ATS
                    1,                                                                                          // Device Page Table
                    {32'd0, 32'h2000_3000 + (tlb_allocate_iterator)*8},                                         // Page Table Address
                    2'd0);                                                                                                      // access_mode  // 00 = Access on host
                                                                                                                                // 01 = Access on card
                                                                                                                                // 10 = Migrate from host to Card and access on card
        
        TSK_TX_CLK_EAT(50);
    end*/
   
   
   // Spinning waiting to respond to TLB misses
   $display("[%t] : **** SPINNING ON COMPLETION ***\n", $realtime);
   
   // Polling on num_requests_recved
   TSK_REG_READ(2, 'h0012_0008);
   while(P_READ_DATA[31:0] != 5) begin
       TSK_REG_READ(2, 'h0012_0008);
   end
   $display("[%t] : **** Test Complete ***\n", $realtime);
   
   $finish;
   
end
else if(testname == "device_page_table_dev_memory")
begin
    //--------------------------------------------------------------------------
    // Direct Root Port to allow upstream traffic by enabling Mem, I/O and
    // BusMstr in the command register
    //--------------------------------------------------------------------------
//    $display("[%t] : Direct Root Port to allow upstream traffic by enabling Mem, I/O and  BusMstr in the command register", $realtime);   
//    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
//    board.RP.cfg_usrapp.TSK_WRITE_CFG_DW(32'h00000001, 32'h00000007, 4'b0001);
//    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
    
    // Initializing DATA_STORE to all zeros. Can run into issues if read don't cares 
    // from data store array
    board.RP.tx_usrapp.TSK_INIT_DATA_STORE;
    
    #5000000;
    
    // Assign Q 2 for AXI-ST
    pf0_qmax = 11'h200;
    axi_st_q = 11'h0;
                
      // Now that we are putting the buffer at 0xF000 it will just wrap over
//    TSK_TRANSLATION_WRITE(64'h0000_0000_0000_C000,     // Physical address
//                64'h0000_0000_0000_C000,    // virtual address
//                128'h0000_0000_0000_0000_0000_0000_FEED_EDED,    // data
//                64'h0000_0000_0000_0000,    // way
//                ats_reg);                   // ATS
    
    
     for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WRITING NODE %d***\n", $realtime, tlb_allocate_iterator);
        
        TSK_LNK_LIST_NODE_WRITE((tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                              // Physical address
                                tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                    // virtual address
                                {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000});  // data
        
        TSK_TX_CLK_EAT(50);
    end
    
    
    // Have to initialize the migration stuff
    TSK_TX_CLK_EAT(5);
    TSK_TX_BAR_WRITE_64(2, 'h0100_0030, DEFAULT_TAG, DEFAULT_TC, 0);
    TSK_TX_CLK_EAT(5);
    
    // Writing to the device page tables. Not wiritng to the L1 PTEs as they are in host memory and must be migrated over
    TSK_TX_BAR_WRITE_64(2, 'h2000_0000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_1000 /* Physical address */});    // 0x0000 as L4 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_1000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_2000 /* Physical address */});    // 0x1000 as L3 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_2000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_3000 /* Physical address */});    // 0x2000 as L2 PTE
    TSK_TX_CLK_EAT(10);
    

    $display("ENGINE PROGRAMMING OVER. BEGINNING BRING-UP TEST");
    
    $display(" **** WRITING TO USER APP CSR ***\n");
    TSK_TX_BAR_WRITE_64(2, 'h0012_0008, DEFAULT_TAG, DEFAULT_TC, 64'd5);    // Number of requests
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0018, DEFAULT_TAG, DEFAULT_TC, 64'd40960);// Bound register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0020, DEFAULT_TAG, DEFAULT_TC, 64'd64); // Request Size
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0028, DEFAULT_TAG, DEFAULT_TC, 64'd1024); // Stride register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0030, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Access Pattern
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0038, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Independent
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0010, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Ptr
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0040, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 0
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0048, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_5000);    // Base address 1
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0050, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_8000);    // Base address 2
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0058, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 3
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0060, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 4
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0068, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 5
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0070, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 6
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0078, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 7
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0080, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 8
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0088, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 9
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0090, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 10
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0098, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 11
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 12
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 13
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 14
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 15
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b1});    // Set AP_START to 1 for linked list modules from 0 - [4:1]
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b0});    // Set AP_START to 0
    
    // Waiting for each interrupt
    for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WAITING FOR QDMA TO ACK IRQ %d***\n", $realtime, tlb_allocate_iterator);
        wait (board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
        
        // Handling the interrupts generated by the page table walker because it can't find a valid L1 PTE
        TSK_TRANSLATION_WRITE(64'h0000_0000_0000_A000 + (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_2000,  // Card Physical address
                    (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                                      // Host physical address
                    tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                            // virtual address
                    {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000},           // data
                    64'h0000_0000_0000_0000,                                                                    // way
                    0,                                                                                          // ATS
                    1,                                                                                          // Device Page Table
                    {32'd0, 32'h2000_3000 + (tlb_allocate_iterator)*8},                                         // Page Table Address
                    2'd2);                                                                                      // Access_mode  // 00 = Access on host
                                                                                                                // 01 = Access on card
                                                                                                                // 10 = Migrate from host to Card and access on card
        
        TSK_TX_CLK_EAT(50);
   end
   
   // Polling on num_requests_recved
   TSK_REG_READ(2, 'h0012_0008);
   while(P_READ_DATA[31:0] != 5) begin
       TSK_REG_READ(2, 'h0012_0008);
   end
   $display("[%t] : **** Test Complete ***\n", $realtime);
   
   $finish;
   
end
else if(testname == "qdma_mm_st_test0")
begin
    //--------------------------------------------------------------------------
    // Direct Root Port to allow upstream traffic by enabling Mem, I/O and
    // BusMstr in the command register
    //--------------------------------------------------------------------------
//    $display("[%t] : Direct Root Port to allow upstream traffic by enabling Mem, I/O and  BusMstr in the command register", $realtime);   
//    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
//    board.RP.cfg_usrapp.TSK_WRITE_CFG_DW(32'h00000001, 32'h00000007, 4'b0001);
//    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
    
    // Initializing DATA_STORE to all zeros
    board.RP.tx_usrapp.TSK_INIT_DATA_STORE;
    
    // Not testing ATS with this one
    // This is to just test other messages
//    $display("[%t] : Issue VDM message",$realtime); 
//    board.RP.tx_usrapp.TSK_TX_MESSAGE_VDM(      
//        board.RP.tx_usrapp.DEFAULT_TAG,     // [7:0]    tag_;
//        3'b000,                             // [2:0]    tc_;
//        11'b00000000001,                    // [10:0]   len_;
//        64'h0000000000009038,               // [63:0]   data_; 63_32 = VDM header 31:16 = dest_id 15:0 = Vend_id
//        3'b011,                             // [2:0]    message_rtg_;
//        8'h7E                               // [7:0]    message_code_;  
//    );
    
//    // First invalidate has an address of 0
//    $display("[%t] : Issue invalidate request to 0x0000000000000000",$realtime);
//    board.RP.tx_usrapp.TSK_TX_ATS_MESSAGE_DATA(
//       board.RP.tx_usrapp.DEFAULT_TAG,     //input  [4:0]    itag_;           
//       64'h0000000000000000,               //input  [63:0]   addr_;           
//       1'b0,                               //input           s_ rangei is greater than 4096 
//       8'h01,                              //input  [7:0]   dest_dev_id_bus_;                                                             
//       8'h00                               //input  [7:0]   dest_dev_id_num_; 
//    );     
//    #50000; 
    
//    // Second invalidate signifies to clear IOTLB
//    $display("[%t] : Issue invalidate request to 0x7FFFFFFFFFFFFFFF",$realtime);  
//    board.RP.tx_usrapp.TSK_TX_ATS_MESSAGE_DATA(             
//        board.RP.tx_usrapp.DEFAULT_TAG,     //input  [4:0]    itag_;   
//        64'h7FFFFFFFFFFFFFFF,               //input  [63:0]   addr_;           
//        1'b0,                               //input           s_ rangei is greater than 4096              
//        8'h01,                              //input  [7:0]    dest_dev_id_bus_;
//        8'h00                               //input  [7:0]    dest_dev_id_num_;
//    );
    #5000000;
    
    // Assign Q 2 for AXI-ST
    pf0_qmax = 11'h200;
    axi_st_q = 11'h0;
    
    // Decide if you are doing ATS or not
    ats_reg = 1'd1;
    
    // EDDIE: What if I remove this?
   
    // initilize all ring size to some value.
    //-------------- Global Ring Size for Queue 0  0x204  : num of dsc 16 ------------------------
    /*board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h204, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h208, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h20C, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h210, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h214, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h218, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h21C, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h220, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h224, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h228, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h22C, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h230, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h234, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h238, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h23C, 32'h00000010, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h240, 32'h00000010, 4'hF);*/
    
    

    // TODO: This was in the old sim, seems like it has been replaced by programming the 
    // FMAP through the indirect context register below
//    //-------------- Global Function MAP 0x400  : Func0 22:11 Qnumber ( 1 Queue ) : 10:0 Qid_base for this Func
//    // set up 16Queues
//    // Func number is 0 : 0*4 = 0: address 0x400+ Fnum*4 = 0x400
//    // 22:11 : 1_0000 : number of queues for this function. 
//    // 10:0  : 000_0000_0000 : Queue off set 
//    // 1000_0000_0000_0000 : 0x8000
//    $display ("[%t] : Setting global function map", $realtime);
//    for(pf_loop_index=0; pf_loop_index <= pfTestIteration; pf_loop_index = pf_loop_index + 1) begin
//	   if(pf_loop_index == pfTestIteration) begin
//            wr_dat = {14'h0,pf0_qmax[10:0],11'h00};
//            board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h400+(pf_loop_index*4), wr_dat[31:0], 4'hF);
//	   end else begin
//	        wr_dat = 32'h00000000;
//            board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h400+(pf_loop_index*4), wr_dat[31:0], 4'hF);
//       end
//    end
    
    // EDDIE: Checking if this will fix my interrupt issue
    
    // Programming the FMAP of function 0. This is 
    // how we allocate queues to functions
   /* $display ("[%t] : Setting up 16 queues", $realtime);
    wr_dat[31:0]   = 32'h0 | (QUEUE_PER_PF * fnc);
    wr_dat[63:32]  = 32'h0 | (QUEUE_PER_PF);
    wr_dat[255:64] = 'h0;

    TSK_REG_WRITE(xdma_bar, 16'h804, wr_dat[31 :0 ], 4'hF);
    TSK_REG_WRITE(xdma_bar, 16'h808, wr_dat[63 :32], 4'hF);
    TSK_REG_WRITE(xdma_bar, 16'h80C, wr_dat[95 :64], 4'hF);
    TSK_REG_WRITE(xdma_bar, 16'h810, wr_dat[127:96], 4'hF);
    TSK_REG_WRITE(xdma_bar, 16'h814, wr_dat[159:128], 4'hF);
    TSK_REG_WRITE(xdma_bar, 16'h818, wr_dat[191:160], 4'hF);
    TSK_REG_WRITE(xdma_bar, 16'h81C, wr_dat[223:192], 4'hF);
    TSK_REG_WRITE(xdma_bar, 16'h820, wr_dat[255:224], 4'hF);
    
    // Writing context written above to FMAP
    wr_dat[31:18] = 'h0; // reserved
    wr_dat[17:7]  = 11'h0 | fnc[7:0]; // fnc
    wr_dat[6:5]   = 2'h1; // MDMA_CTXT_CMD_WR
    wr_dat[4:1]   = 4'hC; // QDMA_CTXT_SELC_FMAP
    wr_dat[0]     = 'h0;
    TSK_REG_WRITE(xdma_bar, 32'h844, wr_dat[31:0], 4'hF);*/
    
    // Seem to need this to generate a MSI-X, but I am not sure how to get this data
    // I am pretty sure this is where one of the extended config pointers is pointing,
    // so typically the OS will do this on enumeration, but the sim doesn't seem to do 
    // that so I need to. 
    //
    // That is my guess because otherwise I have no idea how to get this data
    /*TSK_REG_WRITE(xdma_bar, 32'h0003_0000, 32'hADD00000, 4'hF); // addr lsb 
    TSK_REG_WRITE(xdma_bar, 32'h0003_0004, 32'h00000000, 4'hF); // addr msb
    TSK_REG_WRITE(xdma_bar, 32'h0003_0008, 32'hEDED0000, 4'hF); // data
    TSK_REG_WRITE(xdma_bar, 32'h0003_000C, 32'h00000000, 4'hF); // control (0th bit should be set to 0 to enable)*/
    
    // EDDIE: Going to see what happens if I don't program the H2C Queue, because I am not even using it
    
    
   /* //-------------- Clear HW CXTX for H2C and C2H first for Q1 ------------------------------------
    // [17:7] QID   01
    // [6:5 ] MDMA_CTXT_CMD_CLR=0 : 00
    // [4:1]  MDMA_CTXT_SELC_DSC_HW_H2C = 3 : 0011
    // 0      BUSY : 0 
    //        00000000001_00_0011_0 : _1000_0110 : 0x86
    wr_dat = {14'h0,axi_st_q[10:0],7'b0000110};
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h844, wr_dat[31:0], 4'hF);
    
    // [17:7] QID   01
    // [6:5 ] MDMA_CTXT_CMD_CLR=0 : 00
    // [4:1]  MDMA_CTXT_SELC_DSC_HW_C2H = 2 : 0010
    // 0      BUSY : 0 
    //        00000000001_00_0010_0 : _1000_0100 : 0x84
    wr_dat = {14'h0,axi_st_q[10:0],7'b0000100};
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h844, wr_dat[31:0], 4'hF);

    // Apparently this engine is mutually exclusive with the bridge
//    // This is necessary to start H2C MM engine. Streaming doesn't seem to need it
//    $display ("[%t] : Setting run bit in H2C MM engine", $realtime);
//    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h1204, 32'h00000001, 4'hF);     
//    #50000;
    
//    // This is necessary to start C2H MM engine. Streaming doesn't seem to need it
//    $display ("[%t] : Setting run bit in C2H MM engine", $realtime);
//    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h1004, 32'h00000001, 4'hF);     
//    #50000;
    
    
    
    
    // Setup context
    //-------------- Ind Dire CTXT MASK 0xffffffff for all 256 bits -------------------
    $display ("[%t] : Setting CTXT MASK", $realtime);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h824, 32'hffffffff, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h828, 32'hffffffff, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h82C, 32'hffffffff, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h830, 32'hffffffff, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h834, 32'hffffffff, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h838, 32'hffffffff, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h83C, 32'hffffffff, 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(0, 16'h840, 32'hffffffff, 4'hF);
    

    //-------------- Ind Dire CTXT AXI-ST H2C -------------------
    // ring size index is at 1
    // 
    wr_dat[255:140] = 'd0;
    wr_dat[139]     = 'd0;    // int_aggr
    wr_dat[138:128] = 'd3;    // vec MSI-X Vector 
    wr_dat[127:64]  =  (64'h0 | H2C_ADDR); // dsc base
    wr_dat[63]      =  1'b0;  // is_mm
    wr_dat[62]      =  1'b0;  // mrkr_dis
    wr_dat[61]      =  1'b0;  // irq_req
    wr_dat[60]      =  1'b0;  // err_wb_sent
    wr_dat[59:58]   =  2'b0;  // err        
    wr_dat[57]      =  1'b0;  // irq_no_last
    wr_dat[56:54]   =  3'h0;  // port_id
    wr_dat[53]      =  1'b0;  // irq_en
    wr_dat[52]      =  1'b1;  // wbk_en     
    wr_dat[51]      =  1'b0;  // mm_chn     
    wr_dat[50]      =  1'b1;  // bypass     
    wr_dat[49:48]   =  2'b01; // dsc_sz, 16bytes     
    wr_dat[47:44]   =  4'h1;  // rng_sz     
    wr_dat[43:41]   =  3'h0;  // reserved
    wr_dat[40:37]   =  4'h0;  // fetch_max
    wr_dat[36]      =  1'b0;  // atc
    wr_dat[35]      =  1'b0;  // wbi_intvl_en
    wr_dat[34]      =  1'b1;  // wbi_chk    
    wr_dat[33]      =  1'b0;  // fcrd_en    
    wr_dat[32]      =  1'b1;  // qen        
    wr_dat[31:25]   =  7'h0;  // reserved
    wr_dat[24:17]   =  {4'h0,pfTestIteration[3:0]}; // func_id        
    wr_dat[16]      =  1'b0;  // irq_arm  
    wr_dat[15:0]    =  16'b0; // pidx
    
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h804, wr_dat[31 :0], 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h808, wr_dat[63 :32], 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h80C, wr_dat[95 :64], 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h810, wr_dat[127:96], 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h814, wr_dat[159:128], 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h818, wr_dat[191:160], 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h81C, wr_dat[223:192], 4'hF);
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h820, wr_dat[255:224], 4'hF);
    

    //-------------- Ind Dire CTXT CMD 0x844 [17:7] Qid : <axi_st_q> [17:7} : CMD MDMA_CTXT_CMD_WR=1 ---------    
    // [17:7] QID : <axi_st_q>
    // [6:5 ] MDMA_CTXT_CMD_WR=1 : 01
    // [4:1]  MDMA_CTXT_SELC_DSC_SW_H2C = 1 : 0001
    // 0      BUSY : 0 
    //        00000000001_01_0001_0 : 1010_0010 : 0xA2
    wr_dat = {14'h0,axi_st_q[10:0],7'b0100010};
    board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'h844, wr_dat[31:0], 4'hF);*/
    
    
    // EDDIE: Pretty sure I can comment these out because I am not doing any C2H stuff
    // Program AXI-ST C2H 
    //-------------- Program C2H CMPT timer Trigger to 1 ----------------------------------------------
    //board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'hA00, 32'h00000001, 4'hF);
    
    //-------------- Program C2H CMPT Counter Threshold to 1 ----------------------------------------------
    //board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'hA40, 32'h00000001, 4'hF);
    
    //-------------- Program C2H DSC buffer size to 4K ----------------------------------------------
    //board.RP.tx_usrapp.TSK_REG_WRITE(xdma_bar, 16'hAB0, 32'h00001000, 4'hF);
   
    // AXI-ST H2C transfer
    //
    // dummy clear H2c match
    //board.RP.tx_usrapp.TSK_REG_WRITE(user_bar, 32'h0C, 32'h01, 4'hF);   // Dummy clear H2C match
                
      // Now that we are putting the buffer at 0xF000 it will just wrap over
//    TSK_TRANSLATION_WRITE(64'h0000_0000_0000_C000,     // Physical address
//                64'h0000_0000_0000_C000,    // virtual address
//                128'h0000_0000_0000_0000_0000_0000_FEED_EDED,    // data
//                64'h0000_0000_0000_0000,    // way
//                ats_reg);                   // ATS
    
    
     for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WRITING NODE %d***\n", $realtime, tlb_allocate_iterator);
        
        TSK_LNK_LIST_NODE_WRITE((tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                              // Physical address
                                tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                    // virtual address
                                {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000});  // data
        
        TSK_TX_CLK_EAT(50);
    end
    
    
    // Have to initialize the migration stuff
    TSK_TX_CLK_EAT(5);
    TSK_TX_BAR_WRITE_64(2, 'h0100_0030, DEFAULT_TAG, DEFAULT_TC, 0);
    TSK_TX_CLK_EAT(5);
    
    // Writing to the device page tables
    TSK_TX_BAR_WRITE_64(2, 'h2000_0000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_1000 /* Physical address */});    // 0x0000 as L4 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_1000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_2000 /* Physical address */});    // 0x1000 as L3 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_2000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_3000 /* Physical address */});    // 0x2000 as L2 PTE
    TSK_TX_CLK_EAT(10);
    

    // This is writing L1 PTEs to access host memory    
    TSK_TX_BAR_WRITE_64(2, 'h2000_3000, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_1000 /* Physical address */});    // 0x1000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3008, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_2000 /* Physical address */});    // 0x2000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3010, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_3000 /* Physical address */});    // 0x3000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3018, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */, 1'd0 /* Host or Device */, 48'h0000_0000_4000 /* Physical address */});    // 0x4000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h2000_3020, DEFAULT_TAG, DEFAULT_TC, {14'd0 /* rsrvd */, 1'b1 /* Valid */,  1'd0 /* Host or Device */, 48'h0000_0000_5000 /* Physical address */});    // 0x5000 in host memory as the L1 PTE
    TSK_TX_CLK_EAT(10);


    $display("ENGINE PROGRAMMING OVER. BEGINNING BRING-UP TEST");
    
    $display(" **** WRITING TO USER APP CSR ***\n");
    TSK_TX_BAR_WRITE_64(2, 'h0012_0008, DEFAULT_TAG, DEFAULT_TC, 64'd5);    // Number of requests
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0018, DEFAULT_TAG, DEFAULT_TC, 64'd40960);// Bound register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0020, DEFAULT_TAG, DEFAULT_TC, 64'd64); // Request Size
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0028, DEFAULT_TAG, DEFAULT_TC, 64'd1024); // Stride register
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0030, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Access Pattern
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0038, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Independent
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0010, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Ptr
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0040, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 0
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0048, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_5000);    // Base address 1
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0050, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_8000);    // Base address 2
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0058, DEFAULT_TAG, DEFAULT_TC, 64'h0000_0000_0000_0000);    // Base address 3
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0060, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 4
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0068, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 5
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0070, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 6
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0078, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 7
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0080, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 8
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0088, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 9
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0090, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 10
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0098, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 11
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 12
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00A8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 13
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B0, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 14
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_00B8, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Base address 15
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b1});    // Set AP_START to 1 for linked list modules from 0 - [4:1]
    TSK_TX_CLK_EAT(10);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, {59'd0, /* Num modules (starting at 0)*/ 4'd0, /*ap_start value*/ 1'b0});    // Set AP_START to 0
    
    // Invalidating some of the addresses and then starting again
//    $display("[%t] : Issue invalidate request for addr 0x0000000000001000",$realtime);
//    board.RP.tx_usrapp.TSK_TX_ATS_MESSAGE_DATA(
//       board.RP.tx_usrapp.DEFAULT_TAG,     //input  [4:0]    itag_;           
//       64'h0000000000001000,               //input  [63:0]   addr_;           
//       1'b0,                               //input           s_ rangei is greater than 4096 
//       8'h01,                              //input  [7:0]   dest_dev_id_bus_;                                                             
//       8'h00                               //input  [7:0]   dest_dev_id_num_; 
//    );     
    //#50000000;
    
 
   
    // Waiting for each interrupt
    for(tlb_allocate_iterator = 0; tlb_allocate_iterator < 5; tlb_allocate_iterator = tlb_allocate_iterator + 1) begin
        
        $display("[%t] : **** WAITING FOR QDMA TO ACK IRQ %d***\n", $realtime, tlb_allocate_iterator);
        wait (board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
        
        TSK_TRANSLATION_WRITE(64'h0000_0000_0000_A000 + (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_2000,  // Card Physical address
                    (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                                      // Host physical address
                    tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                            // virtual address
                    {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000},           // data
                    64'h0000_0000_0000_0000,                                                                    // way
                    0,                                                                                          // ATS
                    1,                                                                                          // Device Page Table
                    {32'd0, 32'h2000_3000 + (tlb_allocate_iterator)*8},                                         // Page Table Address
                    2'd0/*2*/);                                                                                 // access_mode  // 00 = Access on host
                                                                                                                                // 01 = Access on card
                                                                                                                                // 10 = Migrate from host to Card and access on card
        
        /*TSK_TRANSLATION_WRITE((tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000,                    // Physical address
                    tlb_allocate_iterator * 64'h0000_0000_0000_1000,                                    // virtual address
                    {64'h0000_0000_DEAD_BEEF, (tlb_allocate_iterator + 1) * 64'h0000_0000_0000_1000},   // data
                    64'h0000_0000_0000_0000,                                                            // way
                    0);                                                                                 // ATS*/
        
        TSK_TX_CLK_EAT(50);
    end
   
   
   // Spinning waiting to respond to TLB misses

   $display("[%t] : **** SPINNING ON COMPLETION ***\n", $realtime);
   
   // Polling on num_requests_recved
   TSK_REG_READ(2, 'h0012_0000);
   while(P_READ_DATA[31:0] != 5) begin
       TSK_REG_READ(2, 'h0012_0000);
   end
   
   $display("[%t] : **** DONE Statistics of run: ***\n", $realtime);
   $display("[%t] : **** Number of Interrupts: %d***\n", $realtime, board.RP.tx_usrapp.NUM_INTERRUPTS);
   for(bin_iterator = 0; bin_iterator < 512; bin_iterator = bin_iterator + 1) begin
        TSK_REG_READ(2, 'h0012_0000 + bin_iterator * 4 + 4);
        $display("Histogram[%d] = %d", bin_iterator, P_READ_DATA);
   end
   
   $finish;
   
   
   
   
   ///TSK_TX_CLK_EAT(1000000);
   //$display("[%t] : **** Number of Interrupts: %d***\n", $realtime, board.RP.tx_usrapp.NUM_INTERRUPTS);
   
   
    /*$display("[%t] : RUNNING AGAIN TO SEE HITS IN TLB", $realtime);
    TSK_TX_BAR_WRITE_64(2, 'h0012_0000, DEFAULT_TAG, DEFAULT_TC, 64'd0);    // Set AP_START to 0
    TSK_TX_CLK_EAT(10);
   
   // Spinning waiting to respond to TLB misses
   $display("[%t] : **** WAITING FOR IRQ 0 ***\n", $realtime);
   wait (ats_reg == 1 || board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
   TSK_TLB_ISR(64'h0000_0000_0000_0000,     // Physical address
                64'h0000_0000_0000_0000,    // virtual address
                64'h0000_0000_0000_1000,    // data
                64'h0000_0000_0000_0000,    // way
                ats_reg);                   // ATS
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   $display("[%t] :  **** Done handling IRQ 0***\n", $realtime);

   $display("[%t] : **** WAITING FOR IRQ 1 ***\n", $realtime);
   wait (ats_reg == 1 || board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
   TSK_TLB_ISR(64'h0000_0000_0000_1000,     // Physical address
                64'h0000_0000_0000_1000,    // virtual address
                64'h0000_0000_0000_2000,    // data
                64'h0000_0000_0000_0000,    // way
                ats_reg);                   // ATS
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   $display("[%t] :  **** Done handling IRQ 1***\n", $realtime);

   $display("[%t] : **** WAITING FOR IRQ 2 ***\n", $realtime);
   wait (ats_reg == 1 || board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
   TSK_TLB_ISR(64'h0000_0000_0000_2000,     // Physical address
                64'h0000_0000_0000_2000,    // virtual address
                64'h0000_0000_0000_3000,    // data
                64'h0000_0000_0000_0000,    // way
                ats_reg);                   // ATS
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   $display("[%t] :  **** Done handling IRQ 2***\n", $realtime);

   $display("[%t] : **** WAITING FOR IRQ 3 ***\n", $realtime);
   wait (ats_reg == 1 || board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
   TSK_TLB_ISR(64'h0000_0000_0000_3000,     // Physical address
                64'h0000_0000_0000_3000,    // virtual address
                64'h0000_0000_0000_4000,    // data
                64'h0000_0000_0000_0000,    // way
                ats_reg);                   // ATS
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   $display("[%t] : **** Done handling IRQ 3***\n", $realtime);

   $display("[%t] : **** Flushing TLB ***\n", $realtime);
   board.RP.tx_usrapp.TSK_TX_ATS_MESSAGE_DATA(             
        board.RP.tx_usrapp.DEFAULT_TAG,     //input  [4:0]    itag_;   
        64'h7FFFFFFFFFFFFFFF,               //input  [63:0]   addr_;           
        1'b0,                               //input           s_ rangei is greater than 4096              
        8'h01,                              //input  [7:0]    dest_dev_id_bus_;
        8'h00                               //input  [7:0]    dest_dev_id_num_;
    );


   $display("[%t] : **** WAITING FOR IRQ 4 ***\n", $realtime);
   wait (ats_reg == 1 || board.EP.design_static_i.qdma_0.inst.usr_irq_out_ack == 1);    // Wait for QDMA to ack the irq
   TSK_TLB_ISR(64'h0000_0000_0000_4000,     // Physical address
                64'h0000_0000_0000_4000,    // virtual address
                64'h0000_0000_0000_0000,    // data
                64'h0000_0000_0000_0000,    // way
                ats_reg);                   // ATS
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b1 );
   //wait (ats_reg == 0 || board.RP.s_axis_cc_tvalid == 1'b0 );
   $display("[%t] : **** Done handling IRQ 4***\n", $realtime);

    // Just waiting a long time at the end so I can see everything
    TSK_TX_CLK_EAT(1000000);

    // Just waiting a long time at the end so I can see everything
    TSK_TX_CLK_EAT(1000000);*/

   $finish;
end

else if(testname == "qdma_h2c_lp_c2h_imm_test0")
begin
   qid = 11'h1;
   board.RP.tx_usrapp.TSK_QDMA_H2C_LP_C2H_IMM_TEST(qid, 0);
   #1000;
   board.RP.tx_usrapp.pfTestIteration = board.RP.tx_usrapp.pfTestIteration + 1;
    if (board.RP.tx_usrapp.test_state == 1 )
     $display ("ERROR: TEST FAILED \n");
   #1000;
   $finish;
end

else if(testname == "qdma_mm_st_dsc_byp_test0")
begin
   qid = 11'h4;
   board.RP.tx_usrapp.TSK_QDMA_MM_H2C_TEST(qid, 1, 0);
   board.RP.tx_usrapp.TSK_QDMA_MM_C2H_TEST(qid, 1, 0);
   board.RP.tx_usrapp.TSK_QDMA_ST_C2H_TEST(qid, 1);
   board.RP.tx_usrapp.TSK_QDMA_ST_H2C_TEST(qid, 1);
   #1000;
   board.RP.tx_usrapp.pfTestIteration = board.RP.tx_usrapp.pfTestIteration + 1;
    if (board.RP.tx_usrapp.test_state == 1 )
     $display ("ERROR: TEST FAILED \n");
   #1000;
   $finish;
end
else if(testname =="qdma_mm_user_reset_test0")
begin
   qid = 0;
   board.RP.tx_usrapp.TSK_QDMA_MM_H2C_TEST(qid, 0, 0);
   board.RP.tx_usrapp.TSK_QDMA_MM_C2H_TEST(qid, 0, 0);
   #1000;
   board.RP.tx_usrapp.TSK_REG_WRITE(board.RP.tx_usrapp.user_bar,32'h98, 32'h640001, 4'hF);
   #30000000  
   board.RP.tx_usrapp.TSK_QDMA_MM_H2C_TEST(qid, 0, 0);
   board.RP.tx_usrapp.TSK_QDMA_MM_C2H_TEST(qid, 0, 0);
    if (board.RP.tx_usrapp.test_state == 1 )
      $display ("ERROR: TEST FAILED \n");

   $finish;
end



else if(testname == "sample_smoke_test0")
begin


    TSK_SIMULATION_TIMEOUT(5050);

    //System Initialization
    TSK_SYSTEM_INITIALIZATION;




    
    $display("[%t] : Expected Device/Vendor ID = %x", $realtime, DEV_VEN_ID); 
    
    //--------------------------------------------------------------------------
    // Read core configuration space via PCIe fabric interface
    //--------------------------------------------------------------------------

    $display("[%t] : Reading from PCI/PCI-Express Configuration Register 0x00", $realtime);

    TSK_TX_TYPE0_CONFIGURATION_READ(DEFAULT_TAG, 12'h0, 4'hF);
    TSK_WAIT_FOR_READ_DATA;
    if  (P_READ_DATA != DEV_VEN_ID) begin
        $display("ERROR: [%t] : TEST FAILED --- Data Error Mismatch, Write Data %x != Read Data %x", $realtime, 
                                    DEV_VEN_ID, P_READ_DATA);
    end
    else begin
        $display("[%t] : TEST PASSED --- Device/Vendor ID %x successfully received", $realtime, P_READ_DATA);
        $display("[%t] : Test Completed Successfully",$realtime);
    end

    //--------------------------------------------------------------------------
    // Direct Root Port to allow upstream traffic by enabling Mem, I/O and
    // BusMstr in the command register
    //--------------------------------------------------------------------------

    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
    board.RP.cfg_usrapp.TSK_WRITE_CFG_DW(32'h00000001, 32'h00000007, 4'b0001);
    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
    
     if (board.RP.tx_usrapp.test_state == 1 )
     $display ("ERROR: TEST FAILED \n");

  $finish;
end


else if(testname == "sample_smoke_test1")
begin

    // This test use tlp expectation tasks.

    TSK_SIMULATION_TIMEOUT(5050);

    // System Initialization
    TSK_SYSTEM_INITIALIZATION;
    // Program BARs (Required so Completer ID at the Endpoint is updated)
    TSK_BAR_INIT;

fork
  begin
    //--------------------------------------------------------------------------
    // Read core configuration space via PCIe fabric interface
    //--------------------------------------------------------------------------

    $display("[%t] : Reading from PCI/PCI-Express Configuration Register 0x00", $realtime);

    TSK_TX_TYPE0_CONFIGURATION_READ(DEFAULT_TAG, 12'h0, 4'hF);
    DEFAULT_TAG = DEFAULT_TAG + 1;
    TSK_TX_CLK_EAT(100);
  end
    //---------------------------------------------------------------------------
    // List Rx TLP expections
    //---------------------------------------------------------------------------
  begin
    test_vars[0] = 0;                                                                                                                         
                                          
    $display("[%t] : Expected Device/Vendor ID = %x", $realtime, DEV_VEN_ID);                                              

    expect_cpld_payload[0] = DEV_VEN_ID[31:24];
    expect_cpld_payload[1] = DEV_VEN_ID[23:16];
    expect_cpld_payload[2] = DEV_VEN_ID[15:8];
    expect_cpld_payload[3] = DEV_VEN_ID[7:0];
    @(posedge pcie_rq_tag_vld);
    exp_tag = pcie_rq_tag;

    board.RP.com_usrapp.TSK_EXPECT_CPLD(
      3'h0, //traffic_class;
      1'b0, //td;
      1'b0, //ep;
      2'h0, //attr;
      10'h1, //length;
      board.RP.tx_usrapp.EP_BUS_DEV_FNS, //completer_id;
      3'h0, //completion_status;
      1'b0, //bcm;
      12'h4, //byte_count;
      board.RP.tx_usrapp.RP_BUS_DEV_FNS, //requester_id;
      exp_tag ,
      7'b0, //address_low;
      expect_status //expect_status;
    );

    if (expect_status) 
      test_vars[0] = test_vars[0] + 1;      
  end
join
  
  expect_finish_check = 1;

  if (test_vars[0] == 1) begin
    $display("[%t] : TEST PASSED --- Finished transmission of PCI-Express TLPs", $realtime);
    $display("[%t] : Test Completed Successfully",$realtime);
  end else begin
    $display("ERROR: [%t] : TEST FAILED --- Haven't Received All Expected TLPs", $realtime);

    //--------------------------------------------------------------------------
    // Direct Root Port to allow upstream traffic by enabling Mem, I/O and
    // BusMstr in the command register
    //--------------------------------------------------------------------------

    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);
    board.RP.cfg_usrapp.TSK_WRITE_CFG_DW(32'h00000001, 32'h00000007, 4'b0001);
    board.RP.cfg_usrapp.TSK_READ_CFG_DW(32'h00000001);

  end

  $finish;
end

else if(testname == "pio_writeReadBack_test0")
begin

    // This test performs a 32 bit write to a 32 bit Memory space and performs a read back

    board.RP.tx_usrapp.TSK_SIMULATION_TIMEOUT(10050);

    board.RP.tx_usrapp.TSK_SYSTEM_INITIALIZATION;

    board.RP.tx_usrapp.TSK_BAR_INIT;

//--------------------------------------------------------------------------
// Event : Testing BARs
//--------------------------------------------------------------------------

        for (board.RP.tx_usrapp.ii = 0; board.RP.tx_usrapp.ii <= 6; board.RP.tx_usrapp.ii =
            board.RP.tx_usrapp.ii + 1) begin
            if ((board.RP.tx_usrapp.BAR_INIT_P_BAR_ENABLED[board.RP.tx_usrapp.ii] > 2'b00)) // bar is enabled
               case(board.RP.tx_usrapp.BAR_INIT_P_BAR_ENABLED[board.RP.tx_usrapp.ii])
                   2'b01 : // IO SPACE
                        begin

                          $display("[%t] : Transmitting TLPs to IO Space BAR %x", $realtime, board.RP.tx_usrapp.ii);

                          //--------------------------------------------------------------------------
                          // Event : IO Write bit TLP
                          //--------------------------------------------------------------------------



                          board.RP.tx_usrapp.TSK_TX_IO_WRITE(board.RP.tx_usrapp.DEFAULT_TAG,
                             board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii][31:0], 4'hF, 32'hdead_beef);
                             @(posedge pcie_rq_tag_vld);
                             exp_tag = pcie_rq_tag;


                          board.RP.com_usrapp.TSK_EXPECT_CPL(3'h0, 1'b0, 1'b0, 2'b0,
                             board.RP.tx_usrapp.EP_BUS_DEV_FNS, 3'h0, 1'b0, 12'h4,
                             board.RP.tx_usrapp.RP_BUS_DEV_FNS, exp_tag,
                             board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii][31:0], test_vars[0]);

                          board.RP.tx_usrapp.TSK_TX_CLK_EAT(10);
                          board.RP.tx_usrapp.DEFAULT_TAG = board.RP.tx_usrapp.DEFAULT_TAG + 1;

                          //--------------------------------------------------------------------------
                          // Event : IO Read bit TLP
                          //--------------------------------------------------------------------------


                          // make sure P_READ_DATA has known initial value
                          board.RP.tx_usrapp.P_READ_DATA = 32'hffff_ffff;
                          fork
                             board.RP.tx_usrapp.TSK_TX_IO_READ(board.RP.tx_usrapp.DEFAULT_TAG,
                                board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii][31:0], 4'hF);
                             board.RP.tx_usrapp.TSK_WAIT_FOR_READ_DATA;
                          join
                          if  (board.RP.tx_usrapp.P_READ_DATA != 32'hdead_beef)
                             begin
			       testError=1'b1;
                               $display("ERROR:  [%t] : Test FAILED --- Data Error Mismatch, Write Data %x != Read Data %x",
                                   $realtime, 32'hdead_beef, board.RP.tx_usrapp.P_READ_DATA);
                             end
                          else
                             begin
                               $display("[%t] : Test PASSED --- Write Data: %x successfully received",
                                   $realtime, board.RP.tx_usrapp.P_READ_DATA);
                             end


                          board.RP.tx_usrapp.TSK_TX_CLK_EAT(10);
                          board.RP.tx_usrapp.DEFAULT_TAG = board.RP.tx_usrapp.DEFAULT_TAG + 1;


                        end

                   2'b10 : // MEM 32 SPACE
                        begin


                          $display("[%t] : Transmitting TLPs to Memory 32 Space BAR %x", $realtime,
                              board.RP.tx_usrapp.ii);

                          //--------------------------------------------------------------------------
                          // Event : Memory Write 32 bit TLP
                          //--------------------------------------------------------------------------

                          board.RP.tx_usrapp.DATA_STORE[0] = 8'h04;
                          board.RP.tx_usrapp.DATA_STORE[1] = 8'h03;
                          board.RP.tx_usrapp.DATA_STORE[2] = 8'h02;
                          board.RP.tx_usrapp.DATA_STORE[3] = 8'h01;

                          board.RP.tx_usrapp.TSK_TX_MEMORY_WRITE_32(board.RP.tx_usrapp.DEFAULT_TAG,
                              board.RP.tx_usrapp.DEFAULT_TC, 11'd1,
                              board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii][31:0]+8'h10, 4'h0, 4'hF, 1'b0);
                          board.RP.tx_usrapp.TSK_TX_CLK_EAT(100);
                          board.RP.tx_usrapp.DEFAULT_TAG = board.RP.tx_usrapp.DEFAULT_TAG + 1;

                          //--------------------------------------------------------------------------
                          // Event : Memory Read 32 bit TLP
                          //--------------------------------------------------------------------------


                         // make sure P_READ_DATA has known initial value
                         board.RP.tx_usrapp.P_READ_DATA = 32'hffff_ffff;
                          fork
                             board.RP.tx_usrapp.TSK_TX_MEMORY_READ_32(board.RP.tx_usrapp.DEFAULT_TAG,
                                 board.RP.tx_usrapp.DEFAULT_TC, 11'd1,
                                 board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii][31:0]+8'h10, 4'h0, 4'hF);
                             board.RP.tx_usrapp.TSK_WAIT_FOR_READ_DATA;
                          join
                          if  (board.RP.tx_usrapp.P_READ_DATA != {board.RP.tx_usrapp.DATA_STORE[3],
                             board.RP.tx_usrapp.DATA_STORE[2], board.RP.tx_usrapp.DATA_STORE[1],
                             board.RP.tx_usrapp.DATA_STORE[0] })
                             begin
			       testError=1'b1;
                               $display("ERROR: [%t] : Test FAILED --- Data Error Mismatch, Write Data %x != Read Data %x",
                                    $realtime, {board.RP.tx_usrapp.DATA_STORE[3],board.RP.tx_usrapp.DATA_STORE[2],
                                     board.RP.tx_usrapp.DATA_STORE[1],board.RP.tx_usrapp.DATA_STORE[0]},
                                     board.RP.tx_usrapp.P_READ_DATA);

                             end
                          else
                             begin
                               $display("[%t] : Test PASSED --- Write Data: %x successfully received",
                                   $realtime, board.RP.tx_usrapp.P_READ_DATA);
                             end


                          board.RP.tx_usrapp.TSK_TX_CLK_EAT(10);
                          board.RP.tx_usrapp.DEFAULT_TAG = board.RP.tx_usrapp.DEFAULT_TAG + 1;

                     end
                2'b11 : // MEM 64 SPACE
                     begin


                          $display("[%t] : Transmitting TLPs to Memory 64 Space BAR %x", $realtime,
                              board.RP.tx_usrapp.ii);


                          //--------------------------------------------------------------------------
                          // Event : Memory Write 64 bit TLP
                          //--------------------------------------------------------------------------

                          board.RP.tx_usrapp.DATA_STORE[0] = 8'h64;
                          board.RP.tx_usrapp.DATA_STORE[1] = 8'h63;
                          board.RP.tx_usrapp.DATA_STORE[2] = 8'h62;
                          board.RP.tx_usrapp.DATA_STORE[3] = 8'h61;

                          board.RP.tx_usrapp.TSK_TX_MEMORY_WRITE_64(board.RP.tx_usrapp.DEFAULT_TAG,
                              board.RP.tx_usrapp.DEFAULT_TC, 10'd1,
                              {board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii+1][31:0],
                              board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii][31:0]+8'h20}, 4'h0, 4'hF, 1'b0);
                          board.RP.tx_usrapp.TSK_TX_CLK_EAT(10);
                          board.RP.tx_usrapp.DEFAULT_TAG = board.RP.tx_usrapp.DEFAULT_TAG + 1;

                          //--------------------------------------------------------------------------
                          // Event : Memory Read 64 bit TLP
                          //--------------------------------------------------------------------------


                          // make sure P_READ_DATA has known initial value
                          board.RP.tx_usrapp.P_READ_DATA = 32'hffff_ffff;
                          fork
                             board.RP.tx_usrapp.TSK_TX_MEMORY_READ_64(board.RP.tx_usrapp.DEFAULT_TAG,
                                 board.RP.tx_usrapp.DEFAULT_TC, 10'd1,
                                 {board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii+1][31:0],
                                 board.RP.tx_usrapp.BAR_INIT_P_BAR[board.RP.tx_usrapp.ii][31:0]+8'h20}, 4'h0, 4'hF);
                             board.RP.tx_usrapp.TSK_WAIT_FOR_READ_DATA;
                          join
                          if  (board.RP.tx_usrapp.P_READ_DATA != {board.RP.tx_usrapp.DATA_STORE[3],
                             board.RP.tx_usrapp.DATA_STORE[2], board.RP.tx_usrapp.DATA_STORE[1],
                             board.RP.tx_usrapp.DATA_STORE[0] })

                             begin
			       testError=1'b1;
                               $display("ERROR: [%t] : Test FAILED --- Data Error Mismatch, Write Data %x != Read Data %x",
                                   $realtime, {board.RP.tx_usrapp.DATA_STORE[3],
                                   board.RP.tx_usrapp.DATA_STORE[2], board.RP.tx_usrapp.DATA_STORE[1],
                                   board.RP.tx_usrapp.DATA_STORE[0]}, board.RP.tx_usrapp.P_READ_DATA);

                             end
                          else
                             begin
                               $display("[%t] : Test PASSED --- Write Data: %x successfully received",
                                   $realtime, board.RP.tx_usrapp.P_READ_DATA);
                             end


                          board.RP.tx_usrapp.TSK_TX_CLK_EAT(10);
                          board.RP.tx_usrapp.DEFAULT_TAG = board.RP.tx_usrapp.DEFAULT_TAG + 1;


                     end
                default : $display("Error case in usrapp_tx\n");
            endcase

         end
    if(testError==1'b0)
      $display("[%t] : Test Completed Successfully",$realtime);

    $display("[%t] : Finished transmission of PCI-Express TLPs", $realtime);
    $finish;
end

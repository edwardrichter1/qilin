
`timescale 1 ns / 1 ps

module device_pt_walker_v1_0 #
(

    // Parameters of Axi Master Bus Interface M00_AXI
    parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
    parameter integer C_M00_AXI_BURST_LEN	= 16,
    parameter integer C_M00_AXI_ID_WIDTH	= 1,
    parameter integer C_M00_AXI_ADDR_WIDTH	= 64,
    parameter integer C_M00_AXI_DATA_WIDTH	= 64,
    parameter integer C_M00_AXI_AWUSER_WIDTH	= 0,
    parameter integer C_M00_AXI_ARUSER_WIDTH	= 0,
    parameter integer C_M00_AXI_WUSER_WIDTH	= 0,
    parameter integer C_M00_AXI_RUSER_WIDTH	= 0,
    parameter integer C_M00_AXI_BUSER_WIDTH	= 0,
    
    // Adding my owqn parameters
    parameter integer PADDR_BITS = 48,
    parameter integer HOST_BIT = 48,
    parameter integer VALID_BIT = 49

)
(

    // Resets and Clocks
    input wire clk,
    input wire aresetn,
    
    // Information regarding the miss
    // and how we should deal with it
    input wire tlb_miss,
    input wire device_pt, // If device_pt is enabled
    
    // Offset in memory map pt is located at
    input wire [63:0] pt_addr,
    
    // L4 Base address is passed in based off of the slot
    input wire [63:0] l4_pt_addr,
    
    // Set page fault high until we recieve the irq_ack
    // if we find an invalid PTE
    output reg  page_fault,
    input  wire irq_ack,
    
    // AXI Lite ports going to the TLB and Coyote Controller
    output  wire  [C_M00_AXI_ADDR_WIDTH-1 : 0]      m00_axi_awaddr,
    output  wire [2 : 0]                            m00_axi_awprot,
    output  reg                                     m00_axi_awvalid,
    input   wire                                    m00_axi_awready,
    output  wire  [C_M00_AXI_DATA_WIDTH-1 : 0]      m00_axi_wdata,
    output  wire [C_M00_AXI_DATA_WIDTH/8-1 : 0]     m00_axi_wstrb,
    output  reg                                     m00_axi_wvalid,
    input   wire                                    m00_axi_wready,
    input   wire [1 : 0]                            m00_axi_bresp,
    input   wire                                    m00_axi_bvalid,
    output  reg                                     m00_axi_bready,
    output  reg [C_M00_AXI_ADDR_WIDTH-1 : 0]        m00_axi_araddr,
    output  wire [2 : 0]                            m00_axi_arprot,
    output  reg                                     m00_axi_arvalid,
    input   wire                                    m00_axi_arready,
    input   wire [C_M00_AXI_DATA_WIDTH-1 : 0]       m00_axi_rdata,
    input   wire [1 : 0]                            m00_axi_rresp,
    input   wire                                    m00_axi_rvalid,
    output  reg                                     m00_axi_rready,
    
    // AXI Lite ports going to the DRAM
    output  wire  [C_M00_AXI_ADDR_WIDTH-1 : 0]      m01_axi_awaddr,
    output  wire [2 : 0]                            m01_axi_awprot,
    output  wire                                    m01_axi_awvalid,
    input   wire                                    m01_axi_awready,
    output  wire  [C_M00_AXI_DATA_WIDTH-1 : 0]      m01_axi_wdata,
    output  wire [C_M00_AXI_DATA_WIDTH/8-1 : 0]     m01_axi_wstrb,
    output  wire                                    m01_axi_wvalid,
    input   wire                                    m01_axi_wready,
    input   wire [1 : 0]                            m01_axi_bresp,
    input   wire                                    m01_axi_bvalid,
    output  wire                                    m01_axi_bready,
    output  reg [C_M00_AXI_ADDR_WIDTH-1 : 0]        m01_axi_araddr,
    output  wire [2 : 0]                            m01_axi_arprot,
    output  reg                                     m01_axi_arvalid,
    input   wire                                    m01_axi_arready,
    input   wire [C_M00_AXI_DATA_WIDTH-1 : 0]       m01_axi_rdata,
    input   wire [1 : 0]                            m01_axi_rresp,
    input   wire                                    m01_axi_rvalid,
    output  reg                                     m01_axi_rready
);
    
    // Constants for writing, cause we are only writing replays
    assign m00_axi_awprot               = 0;
    assign m00_axi_wstrb                = 8'hFF;
    
    // Don't write to DRAM, so setting those to 0
    assign m01_axi_awaddr = 0;
    assign m01_axi_awprot = 0;
    assign m01_axi_awvalid = 0;
    assign m01_axi_wdata = 0;
    assign m01_axi_wstrb = 0;
    assign m01_axi_wvalid = 0;
    assign m01_axi_bready = 0;
    
    
    // Asigning reading signals we don't use
    assign m00_axi_arprot = 0;
    assign m01_axi_arprot = 0;
    
    // Flopping outputs from state machine
    reg                                     m00_axi_arvalid_n;
    reg                                     m01_axi_arvalid_n;
    reg                                     m00_axi_awvalid_n;
    reg                                     m00_axi_wvalid_n;
    reg                                     m00_axi_bready_n;
    reg                                     m00_axi_rready_n;
    reg                                     m01_axi_rready_n;
    reg                                     page_fault_n;
    reg                                     write_replay, write_replay_n;
    reg [63:0]                              m00_axi_araddr_n;
    reg [63:0]                              m01_axi_araddr_n;
    reg [63:0]                              vaddr, vaddr_n;
    reg [63:0]                              paddr, paddr_n;
    reg [31:0]                              way, way_n;
    reg                                     data_on_host, data_on_host_n;
    (* mark_debug = "true" *) reg [4:0]     state, state_n;
    
    localparam IDLE = 0, VADDR_AR_STATE = 1, VADDR_R_STATE = 2, L3_AR_STATE = 3, L3_R_STATE = 4, L2_AR_STATE = 5, L2_R_STATE = 6, 
    L1_AR_STATE = 7, L1_R_STATE = 8, PA_AR_STATE = 9, PA_R_STATE = 10, TLB_AR_STATE = 11, TLB_R_STATE = 12, AW_STATE = 13, 
    W_STATE = 14, PAGE_FAULT = 15, WAIT_FOR_ACK = 16;
    
    // We are either writing to the TLB or writing to replay the access
    wire [63:0] replay_addr = 64'h0000_0000_0100_0000;
    wire [63:0] tlb_addr = {48'h0000_0000_0011, way[2:0], vaddr[21:12], 3'b000};
    assign m00_axi_awaddr = write_replay ? replay_addr : tlb_addr;
    
   
    
    // Assining the entry we will write to the TLB
    // TODO: Parameterize this
    wire [63:0] tlb_data;
    wire [33:0] tlb_data_tag;
    wire [27:0] tlb_data_paddr_shifted;
    
    assign tlb_data_tag             = vaddr >> 22 /* PAGE_SHIFT + STLB_ORDER*/;
    assign tlb_data_paddr_shifted   = paddr >> 12 /*PAGE_SHIFT*/;
    assign tlb_data                 = {1'b1 /* valid bit */, data_on_host, tlb_data_tag, tlb_data_paddr_shifted};
    
    wire [63:0] replay_data;
    assign replay_data = 'h0000_0000_0000_0100;
    
    assign m00_axi_wdata = write_replay ? replay_data : tlb_data;
    
    // Using a cycle counter as a "pseudo-random" number generator as a replacement policy
    // TODO: Make this programmable with the associativty of the TLB
    reg [1:0] cycle_count;
    always@(posedge clk) begin
        if(~aresetn) begin
            cycle_count <= 0;
        end
        else begin
            cycle_count <= cycle_count + 1;
        end
    end
    
    
    // Generating sticky bit for the ready signals
    // so we can keep track of which ready's we have 
    // received
    
    reg aw_and_w_ready_sticky_high_delayed;
    
    reg m00_axi_awready_sticky;
    always@(posedge clk) begin
         if(~aresetn) begin
             m00_axi_awready_sticky <= 1'b0;
         end
         else if(m00_axi_awready) begin
             m00_axi_awready_sticky <= 1'b1;
         end
         else if(aw_and_w_ready_sticky_high_delayed) begin
             m00_axi_awready_sticky <= 1'b0;
         end
         else begin
             m00_axi_awready_sticky <= m00_axi_awready_sticky;
         end
     end
    
    reg m00_axi_wready_sticky;
    always@(posedge clk) begin
         if(~aresetn) begin
             m00_axi_wready_sticky <= 1'b0;
         end
         else if(m00_axi_wready) begin
             m00_axi_wready_sticky <= 1'b1;
         end
         else if(aw_and_w_ready_sticky_high_delayed) begin
             m00_axi_wready_sticky <= 1'b0;
         end
         else begin
             m00_axi_wready_sticky <= m00_axi_wready_sticky;
         end
     end
    
     // Generate a pulse one clock cycle after 
     // the sticky bits are both high
     always@(posedge clk) begin
        if(~aresetn) begin
            aw_and_w_ready_sticky_high_delayed <= 1'b0;
        end
        // Only care about genearting this pulse when we are in the AW_STATE because
        // that is when we have set the valid signals high and are waiting for the 
        // ready signals
        else if((state == AW_STATE) && m00_axi_awready_sticky && m00_axi_wready_sticky) begin
            aw_and_w_ready_sticky_high_delayed <= 1'b1;
        end
        else begin
            aw_and_w_ready_sticky_high_delayed <= 1'b0;
        end
     end
     
     
     // FSM Combinational Logic
     always@(*) begin
     
        case(state)
        
            // Wait in this state until we receive a TLB miss
            IDLE: begin
                // If Device Page Tables are not tuirned on, never move
                if(~device_pt) begin
                    state_n             <= IDLE;
                    m00_axi_arvalid_n   <= 1'b0;
                    m00_axi_araddr_n    <= 0;
                end
                else begin
                    // Wait until we recieve a TLB miss
                    // Then when we do, read the vaddr
                    // of that miss
                    if(~tlb_miss) begin
                        state_n             <= IDLE;
                        m00_axi_arvalid_n   <= 1'b0;
                        m00_axi_araddr_n    <= 0;
                    end
                    else begin
                        state_n             <= VADDR_AR_STATE;
                        m00_axi_arvalid_n   <= 1'b1;
                        m00_axi_araddr_n    <= 64'h0000_0000_0100_0020; // Address to read VADDR of TLB MISS
                    end
                end
                
                // Signals that we are not changing
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                m00_axi_rready_n  <= 0;
                m01_axi_rready_n  <= 0;
                m01_axi_arvalid_n <= 0; 
                m01_axi_araddr_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= 0;
                way_n             <= 0;
                data_on_host_n    <= 0;
                page_fault_n      <= 0;
            end
            
            // State where the VADDR of the miss is 
            // read. NOTE: Right now we are assumiung
            // the legnth is a page, need to update that 
            // so we can read multiple translations
            // sequentiall (or in parallel)
            VADDR_AR_STATE: begin
                // Wait until we recieve ready
                if(~m00_axi_arready) begin
                    m00_axi_arvalid_n   <= 1'b1;
                    m00_axi_araddr_n    <= 64'h0000_0000_0100_0020;
                    m00_axi_rready_n    <= 1'b0;
                    state_n             <= VADDR_AR_STATE;
                end
                else begin
                    m00_axi_arvalid_n   <= 1'b0;
                    m00_axi_araddr_n    <= 0;
                    m00_axi_rready_n    <= 1'b1;
                    state_n             <= VADDR_R_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                m01_axi_rready_n  <= 0;
                m01_axi_arvalid_n <= 0; 
                m01_axi_araddr_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= 0;
                way_n             <= 0;
                data_on_host_n    <= 0;
                page_fault_n      <= 0;
            end
            
            // State where we receive the VADDR data
            // Once the VADDR is received we can fetch the 
            // L4 PTE
            VADDR_R_STATE: begin
                // Wait until we receive valid data
                if(~m00_axi_rvalid) begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0;
                    m00_axi_rready_n        <= 1'b1; // This is m00 because we are waiting to read the vaddr from the Coyote shell
                    state_n                 <= VADDR_R_STATE;
                    vaddr_n                 <= 0;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= pt_addr + l4_pt_addr + (m00_axi_rdata[47:39] << 3); // Getting address to L4 PTE
                    m00_axi_rready_n        <= 1'b0; // This is m00 because we are waiting to read the vaddr from the Coyote shell
                    vaddr_n                 <= {16'd0, m00_axi_rdata[47:0]}; // Keeping track of the vaddr for the future parts of the walk
                    state_n                 <= L3_AR_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m01_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                way_n             <= 0;
                data_on_host_n    <= 0;
                page_fault_n      <= 0;
            end
            
            // Fetching the L3 PTE
            L3_AR_STATE: begin
                if(~m01_axi_arready) begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= pt_addr + l4_pt_addr + (vaddr[47:39] << 3); // Getting address to L4 PTE
                    m01_axi_rready_n        <= 1'b0;
                    state_n                 <= L3_AR_STATE;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b1;
                    state_n                 <= L3_R_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m00_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
                data_on_host_n    <= 0;
                page_fault_n      <= 0;
            end
            
            L3_R_STATE: begin
                if(~m01_axi_rvalid) begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b1;
                    page_fault_n            <= 1'b0;
                    state_n                 <= L3_R_STATE;
                end
                else if(~m01_axi_rdata[VALID_BIT]) begin // If we are reading an invalid PTE
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b1;
                    state_n                 <= WAIT_FOR_ACK;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= m01_axi_rdata[PADDR_BITS-1:0] + pt_addr + (vaddr[38:30] << 3); // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b0;
                    state_n                 <= L2_AR_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m00_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
                data_on_host_n    <= 0;
            end
            
            L2_AR_STATE: begin
                
                if(~m01_axi_arready) begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= m01_axi_rdata[PADDR_BITS-1:0] + pt_addr + (vaddr[38:30] << 3); // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b0;
                    state_n                 <= L2_AR_STATE;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b1;
                    state_n                 <= L2_R_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m00_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
                data_on_host_n    <= 0;
                page_fault_n      <= 0;
            end
            
            
            L2_R_STATE: begin
                
                if(~m01_axi_rvalid) begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b1;
                    page_fault_n            <= 1'b0;
                    state_n                 <= L2_R_STATE;
                end
                else if(~m01_axi_rdata[VALID_BIT]) begin // If we are reading an invalid PTE
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b1;
                    state_n                 <= WAIT_FOR_ACK;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= m01_axi_rdata[PADDR_BITS-1:0] + pt_addr + (vaddr[29:21] << 3); // Getting address to L1 PTE
                    m01_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b0;
                    state_n                 <= L1_AR_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m00_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
                data_on_host_n    <= 0;
            end
            
            L1_AR_STATE: begin
            
                
                if(~m01_axi_arready) begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= m01_axi_rdata[PADDR_BITS-1:0] + pt_addr + (vaddr[29:21] << 3); // Getting address to L1 PTE
                    m01_axi_rready_n        <= 1'b0;
                    state_n                 <= L1_AR_STATE;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L1 PTE
                    m01_axi_rready_n        <= 1'b1;
                    state_n                 <= L1_R_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m00_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
                data_on_host_n    <= 0;
                page_fault_n      <= 0;
            end
            
            L1_R_STATE: begin
                
                if(~m01_axi_rvalid) begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L1 PTE
                    m01_axi_rready_n        <= 1'b1;
                    page_fault_n            <= 1'b0;
                    state_n                 <= L1_R_STATE;
                end
                else if(~m01_axi_rdata[VALID_BIT]) begin // If we are reading an invalid PTE
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b1;
                    state_n                 <= WAIT_FOR_ACK;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= m01_axi_rdata[PADDR_BITS-1:0] + pt_addr + (vaddr[20:12] << 3); // Getting address to L1 PTE
                    m01_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b0;
                    state_n                 <= PA_AR_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m00_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
                data_on_host_n    <= 0;
            end
            
            PA_AR_STATE: begin
           
                if(~m01_axi_arready) begin
                    m01_axi_arvalid_n       <= 1'b1;
                    m01_axi_araddr_n        <= m01_axi_rdata[PADDR_BITS-1:0] + pt_addr + (vaddr[20:12] << 3); // Getting address to L1 PTE
                    m01_axi_rready_n        <= 1'b0;
                    state_n                 <= PA_AR_STATE;
                end
                else begin
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0;
                    m01_axi_rready_n        <= 1'b1;
                    state_n                 <= PA_R_STATE;
                end
                
                // Signals that we are not changing
                m00_axi_arvalid_n <= 1'b0;
                m00_axi_araddr_n  <= 0;
                m00_axi_rready_n  <= 1'b0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
                data_on_host_n    <= 0;
                page_fault_n      <= 0;
            end
            
            PA_R_STATE: begin
            
                if(~m01_axi_rvalid) begin
                    // Still waiting to receive the actual physical address from the PTE
                    m01_axi_rready_n        <= 1'b1;
                    
                    // Going to do the replacement policy next, so need to set these to 
                    // 0 just in this case
                    m00_axi_arvalid_n       <= 1'b0;
                    m00_axi_araddr_n        <= 0;
                    m00_axi_rready_n        <= 1'b0;
                    
                    page_fault_n            <= 1'b0;
                    paddr_n                 <= 0;
                    data_on_host_n          <= 0;
                    state_n                 <= PA_R_STATE;
                end
                else if(~m01_axi_rdata[VALID_BIT]) begin // If we are reading an invalid PTE
                    m01_axi_arvalid_n       <= 1'b0;
                    m01_axi_araddr_n        <= 0; // Getting address to L2 PTE
                    m01_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b1;
                    state_n                 <= WAIT_FOR_ACK;
                end
                else begin
                    // No longer reading anything from DRAM so setting ready to 0
                    m01_axi_rready_n        <= 1'b0;
                    
                    // Reading from the TLB to do the replacement policy
                    m00_axi_arvalid_n       <= 1'b1;
                    m00_axi_araddr_n        <= tlb_addr;
                    m00_axi_rready_n        <= 1'b0;
                    page_fault_n            <= 1'b0;
                    paddr_n                 <= m01_axi_rdata[PADDR_BITS-1:0];
                    data_on_host_n          <= m01_axi_rdata[HOST_BIT];  // Checking if the PADDR is on the host or the device
                    state_n                 <= TLB_R_STATE;
                end
                
                // Signals that we are not changing
                m01_axi_arvalid_n <= 1'b0;
                m01_axi_araddr_n  <= 0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                write_replay_n    <= 0;
                vaddr_n           <= vaddr;
                way_n             <= 0;
            
            end
            
            // State where we generate requests to the 
            // different TLB ways to see if there is 
            // valid data
            TLB_AR_STATE: begin
                // Wait until we recieve address ready
                if(~m00_axi_arready) begin
                    m00_axi_arvalid_n   <= 1'b1;
                    m00_axi_rready_n    <= 1'b0;
                    state_n             <= TLB_AR_STATE;
                end
                else begin
                    m00_axi_arvalid_n   <= 1'b0;
                    m00_axi_rready_n    <= 1'b1;
                    state_n             <= TLB_R_STATE;
                end
                
                m01_axi_arvalid_n   <= 1'b0;
                m01_axi_araddr_n    <= 0;
                m01_axi_rready_n    <= 1'b0;
                m00_axi_araddr_n    <= tlb_addr;
                m00_axi_awvalid_n   <= 0;
                m00_axi_wvalid_n    <= 0;
                m00_axi_bready_n    <= 0;
                paddr_n             <= paddr;
                vaddr_n             <= vaddr;
                write_replay_n      <= 1'b0;
                way_n               <= way;
                data_on_host_n      <= data_on_host;
                page_fault_n        <= 1'b0;
            end
            
            // State where we receive the data from the TLB
            // to see if the data is valid or not
            TLB_R_STATE: begin
                // Wait until we recieve data from the TLB
                if(~m00_axi_rvalid) begin
                    m00_axi_arvalid_n   <= 1'b0;
                    m00_axi_rready_n    <= 1'b1;
                    m00_axi_awvalid_n   <= 1'b0;
                    m00_axi_wvalid_n    <= 1'b0;
                    way_n               <= way;
                    state_n             <= TLB_R_STATE;
    
                end
                // If TLB entry is valid
                else if(m00_axi_rdata[63]) begin
                    // If we still have more ways to check
                    if(way < 4 /* STLB_ASSOC */) begin
                        m00_axi_arvalid_n   <= 1'b1;
                        m00_axi_rready_n    <= 1'b0;
                        m00_axi_awvalid_n   <= 1'b0;
                        m00_axi_wvalid_n    <= 1'b0;
                        way_n               <= way + 1;
                        state_n             <= TLB_AR_STATE;
                    end
                    // If we have checked all ways, use cycle
                    // counter to pick a random way to overwrite
                    else begin
                        m00_axi_arvalid_n   <= 1'b0;
                        m00_axi_rready_n    <= 1'b0;
                        m00_axi_awvalid_n   <= 1'b1;
                        m00_axi_wvalid_n    <= 1'b1;
                        way_n               <= cycle_count;
                        state_n             <= AW_STATE;
                    end
    
                    write_replay_n      <= 1'b0;
                    m00_axi_rready_n    <= 1'b0;
                end
                // If TLB entry was not valid, we can write to that location
                else begin
                    m00_axi_arvalid_n   <= 1'b0;
                    m00_axi_rready_n    <= 1'b0;
                    m00_axi_awvalid_n   <= 1'b1;
                    m00_axi_wvalid_n    <= 1'b1;
                    way_n               <= way;
                    state_n             <= AW_STATE;
                end
                
                m01_axi_arvalid_n   <= 1'b0;
                m01_axi_araddr_n    <= 0;
                m01_axi_rready_n    <= 1'b0;
                paddr_n             <= paddr;
                data_on_host_n      <= data_on_host;
                vaddr_n             <= vaddr;
                m00_axi_araddr_n    <= tlb_addr;
                write_replay_n      <= 1'b0;
                m00_axi_bready_n    <= 1'b0;
                page_fault_n        <= 1'b0;
            end
            
            // State where we generate a write request, first 
            // to the TLB and then to replay the access
            AW_STATE: begin
                // Waiting to receive ready for writing 
                // the data
                if(~aw_and_w_ready_sticky_high_delayed) begin
    
                    // If we recieved a ready we have
                    // to set valid low
                    if(m00_axi_wready_sticky) begin
                        m00_axi_wvalid_n   <= 1'b0;
                    end
                    else begin
                        m00_axi_wvalid_n   <= 1'b1;
                    end
    
                    // If we recieved a ready we have
                    // to set valid low
                    if(m00_axi_awready_sticky) begin
                        m00_axi_awvalid_n   <= 1'b0;
                    end
                    else begin
                        m00_axi_awvalid_n   <= 1'b1;
                    end
    
    
                    m00_axi_bready_n    <= 1'b0;
                    state_n             <= AW_STATE;
                end
                else begin
                    m00_axi_awvalid_n   <= 1'b0;
                    m00_axi_wvalid_n    <= 1'b0;
                    m00_axi_bready_n    <= 1'b1;
                    state_n             <= W_STATE;
                end
                
                m01_axi_arvalid_n   <= 1'b0;
                m01_axi_araddr_n    <= 0;
                m01_axi_rready_n    <= 1'b0;
                paddr_n             <= paddr;
                data_on_host_n      <= data_on_host;
                vaddr_n             <= vaddr;
                m00_axi_araddr_n    <= 0;
                write_replay_n      <= write_replay;
                m00_axi_arvalid_n   <= 1'b0;
                m00_axi_rready_n    <= 1'b0;
                way_n               <= way;
                page_fault_n        <= 1'b0;
            
            end
            
            // When we wait for the write response
            W_STATE: begin
                // Waiting until we receive a valid write response
                if(~m00_axi_bvalid) begin
                    m00_axi_bready_n     <= 1'b1;
                    write_replay_n       <= write_replay;
                    m00_axi_awvalid_n    <= 1'b0;
                    m00_axi_wvalid_n     <= 1'b0;
                    state_n              <= W_STATE;
                end
                // If we have not written the replay yet, go back
                // and write it and then go to idle
                else if(~write_replay) begin
                    m00_axi_bready_n     <= 1'b0;
                    write_replay_n       <= 1'b1;
                    m00_axi_awvalid_n    <= 1'b1;
                    m00_axi_wvalid_n     <= 1'b1;
                    state_n              <= AW_STATE;
                end
                else begin
                    m00_axi_bready_n     <= 1'b0;
                    write_replay_n       <= 1'b0;
                    m00_axi_awvalid_n    <= 1'b0;
                    m00_axi_wvalid_n     <= 1'b0;
                    state_n              <= IDLE;
                end
                
                m01_axi_arvalid_n   <= 1'b0;
                m01_axi_araddr_n    <= 0;
                m01_axi_rready_n    <= 1'b0;
                paddr_n             <= paddr;
                data_on_host_n      <= data_on_host;
                vaddr_n             <= vaddr;
                m00_axi_araddr_n    <= tlb_addr;
                m00_axi_arvalid_n   <= 1'b0;
                m00_axi_rready_n    <= 1'b0;
                way_n               <= 0;
                page_fault_n        <= 1'b0;
            end
            
            WAIT_FOR_ACK: begin
            
                // Wait until our irq has been 
                // acked by QDMA
                if(irq_ack) begin
                    state_n <= PAGE_FAULT;
                end
                else begin
                    state_n <= WAIT_FOR_ACK;
                end
            
            
                m01_axi_arvalid_n <= 1'b0;
                m01_axi_araddr_n  <= 0;
                m01_axi_rready_n  <= 1'b0;
                m00_axi_arvalid_n <= 0;
                m00_axi_araddr_n  <= 0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                m00_axi_rready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                data_on_host_n    <= 0;
                vaddr_n           <= 0;
                way_n             <= 0;
                page_fault_n      <= 1;
            end
            
            PAGE_FAULT: begin
            
                // Just wait here until the miss is resolved
                // by the host
                if(~tlb_miss) begin
                    state_n <= IDLE;
                end
                else begin
                    state_n <= PAGE_FAULT;
                end
            
            
                m01_axi_arvalid_n <= 1'b0;
                m01_axi_araddr_n  <= 0;
                m01_axi_rready_n  <= 1'b0;
                m00_axi_arvalid_n <= 0;
                m00_axi_araddr_n  <= 0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                m00_axi_rready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                data_on_host_n    <= 0;
                vaddr_n           <= 0;
                way_n             <= 0;
                page_fault_n      <= 0;
            end
            
            default: begin
                m01_axi_arvalid_n <= 1'b0;
                m01_axi_araddr_n  <= 0;
                m01_axi_rready_n  <= 1'b0;
                m00_axi_arvalid_n <= 0;
                m00_axi_araddr_n  <= 0;
                m00_axi_awvalid_n <= 0;
                m00_axi_wvalid_n  <= 0;
                m00_axi_bready_n  <= 0;
                m00_axi_rready_n  <= 0;
                write_replay_n    <= 0;
                paddr_n           <= 0;
                data_on_host_n    <= 0;
                vaddr_n           <= 0;
                way_n             <= 0;
                page_fault_n      <= 0;
                state_n           <= IDLE;
            end
    
        endcase
     
     
     end
    
    
    // FSM Sequential logic
    always@(posedge clk) begin
        if(~aresetn) begin
            m00_axi_arvalid <= 0;
            m00_axi_araddr  <= 0;
            m00_axi_awvalid <= 0;
            m00_axi_wvalid  <= 0;
            m00_axi_bready  <= 0;
            m00_axi_rready  <= 0;
            m01_axi_arvalid <= 0;
            m01_axi_araddr  <= 0;
            m01_axi_rready  <= 0;
            write_replay    <= 0;
            paddr           <= 0;
            vaddr           <= 0;
            way             <= 0;
            data_on_host    <= 0;
            page_fault      <= 0;
            state           <= IDLE;
        end
        else begin
            m00_axi_arvalid <= m00_axi_arvalid_n;
            m00_axi_araddr  <= m00_axi_araddr_n;
            m00_axi_awvalid <= m00_axi_awvalid_n;
            m00_axi_wvalid  <= m00_axi_wvalid_n;
            m00_axi_bready  <= m00_axi_bready_n;
            m00_axi_rready  <= m00_axi_rready_n;
            m01_axi_arvalid <= m01_axi_arvalid_n;
            m01_axi_araddr  <= m01_axi_araddr_n;
            m01_axi_rready  <= m01_axi_rready_n;
            write_replay    <= write_replay_n;
            paddr           <= paddr_n;
            vaddr           <= vaddr_n;
            way             <= way_n;
            data_on_host    <= data_on_host_n;
            page_fault      <= page_fault_n;
            state           <= state_n;
        end
    end
    


endmodule

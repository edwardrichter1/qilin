
`timescale 1 ns / 1 ps

module translation_generator_v1_0 #
(
    // Do I need these? Not sure
    parameter           C_M00_AXI_START_DATA_VALUE	     = 32'hAA000000,
    parameter           C_M00_AXI_TARGET_SLAVE_BASE_ADDR = 32'h40000000,
    parameter integer   C_M00_AXI_ADDR_WIDTH	         = 64,
    parameter integer   C_M00_AXI_DATA_WIDTH	         = 64,
    parameter integer   C_M00_AXI_TRANSACTIONS_NUM	     = 4
)
(

    // Resets and Clocks
    input wire clk,
    input wire aresetn,
   
    // Information regarding the miss
    // and how we should deal with it
    input wire tlb_miss,
    input wire ats,
    input wire cache_overlap,
    
    // Descriptor streaming output
    output reg                                      m_h2c_byp_in_st_vld,
    input  wire                                     m_h2c_byp_in_st_rdy,                 
    output reg [63:0]                               m_h2c_byp_in_raddr,
    output wire [15:0]                              m_h2c_byp_in_cidx,
    output wire [1:0]                               m_h2c_byp_in_at,
    output wire                                     m_h2c_byp_in_eop,
    output wire                                     m_h2c_byp_in_error,
    output wire [7:0]                               m_h2c_byp_in_func,
    output wire [15:0]                              m_h2c_byp_in_len,
    output wire                                     m_h2c_byp_in_mrkr_req,
    output wire                                     m_h2c_byp_in_no_dma,
    output wire [2:0]                               m_h2c_byp_in_port_id,
    output wire [10:0]                              m_h2c_byp_in_qid,
    output wire                                     m_h2c_byp_in_sdi,
    output wire                                     m_h2c_byp_in_sop,

    // M AXI Lite Ports
    output  wire [C_M00_AXI_ADDR_WIDTH-1 : 0]       m00_axi_awaddr,
    output  wire [2 : 0]                            m00_axi_awprot,
    output  reg                                     m00_axi_awvalid,
    input   wire                                    m00_axi_awready,
    output  wire [C_M00_AXI_DATA_WIDTH-1 : 0]       m00_axi_wdata,
    output  wire [C_M00_AXI_DATA_WIDTH/8-1 : 0]     m00_axi_wstrb,
    output  reg                                     m00_axi_wvalid,
    input   wire                                    m00_axi_wready,
    input   wire [1 : 0]                            m00_axi_bresp,
    input   wire                                    m00_axi_bvalid,
    output  reg                                     m00_axi_bready,
    output  wire [C_M00_AXI_ADDR_WIDTH-1 : 0]       m00_axi_araddr,
    output  wire [2 : 0]                            m00_axi_arprot,
    output  reg                                     m00_axi_arvalid,
    input   wire                                    m00_axi_arready,
    input   wire [C_M00_AXI_DATA_WIDTH-1 : 0]       m00_axi_rdata,
    input   wire [1 : 0]                            m00_axi_rresp,
    input   wire                                    m00_axi_rvalid,
    output  reg                                     m00_axi_rready
);

    localparam IDLE = 0, AR_STATE = 1, R_STATE = 2, AW_STATE = 3, W_STATE = 4, DESCR_STATE = 5, WAIT_STATE = 6;
    
    // Flopping outputs from state machine
    reg                                 m00_axi_arvalid_n;
    reg                                 m00_axi_awvalid_n;
    reg                                 m00_axi_wvalid_n;
    reg                                 m00_axi_bready_n;
    reg                                 m00_axi_rready_n;
    reg                                 m_h2c_byp_in_st_vld_n;
    reg [63:0]                          m_h2c_byp_in_raddr_n;
    reg [2:0]                           state, state_n;
    

    // Assigning constants of descriptors
    assign m_h2c_byp_in_cidx            = 1;
    assign m_h2c_byp_in_at              = 1;
    assign m_h2c_byp_in_eop             = 1;
    assign m_h2c_byp_in_error           = 0;
    assign m_h2c_byp_in_func            = 0;
    assign m_h2c_byp_in_len             = 8;
    assign m_h2c_byp_in_mrkr_req        = 0;
    assign m_h2c_byp_in_no_dma          = 0;
    assign m_h2c_byp_in_port_id         = 2;
    assign m_h2c_byp_in_qid             = 1; // Note: Right now all translations need to be on QID 1
    assign m_h2c_byp_in_sdi             = 0;
    assign m_h2c_byp_in_sop             = 1;
    
    // Constants for writing, cause we are only writing replays
    assign m00_axi_awaddr               = 64'h0000_0000_0100_0000;
    assign m00_axi_awprot               = 0;
    assign m00_axi_wdata                = 64'h0000_0000_0000_0100;
    assign m00_axi_wstrb                = 8'hFF;
    
    
    // Asigning reading signals we don't use
    assign m00_axi_arprot               = 0;
    assign m00_axi_araddr               = 64'h0000_0000_0100_0020; // Just hardcoding the address that stores the vaddr of the miss
   
   // Was having trouble with timing so flopping the cache_overlap bit
   reg cache_overlap_reg;
   always@(posedge clk) begin
        if(~aresetn) begin
            cache_overlap_reg <= 0;
        end
        else begin
            cache_overlap_reg <= cache_overlap;
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
   

    
    
    // Combination state machine logic
    always@(*) begin
        case(state)
            
            IDLE: begin
                // If ATS is not tuirned on, never move
                if(~ats) begin
                    state_n             <= IDLE;
                    m00_axi_arvalid_n   <= 1'b0;
                end
                else begin
                    // Wait until we recieve a TLB miss
                    // Then when we do, read the vaddr
                    // of that miss
                    if(~tlb_miss) begin
                        state_n             <= IDLE;
                        m00_axi_arvalid_n   <= 1'b0;
                    end
                    else begin
                        state_n             <= AR_STATE;
                        m00_axi_arvalid_n   <= 1'b1;
                    end  
                end
                
                m_h2c_byp_in_st_vld_n   <= 1'b0;
                m_h2c_byp_in_raddr_n    <= 64'd0; 
                m00_axi_rready_n        <= 1'b0;
                m00_axi_awvalid_n       <= 1'b0;
                m00_axi_wvalid_n        <= 1'b0;
                m00_axi_bready_n        <= 1'b0;
                
            end
            
            AR_STATE: begin
                // Wait until we recieve ready
                if(~m00_axi_arready) begin
                    m00_axi_arvalid_n   <= 1'b1;
                    m00_axi_rready_n    <= 1'b0;
                    state_n             <= AR_STATE;
                end
                else begin
                    m00_axi_arvalid_n   <= 1'b0;
                    m00_axi_rready_n    <= 1'b1;
                    state_n             <= R_STATE;
                end
                
                m_h2c_byp_in_st_vld_n   <= 1'b0;
                m_h2c_byp_in_raddr_n    <= 64'd0;
                m00_axi_awvalid_n       <= 1'b0;
                m00_axi_wvalid_n        <= 1'b0;
                m00_axi_bready_n        <= 1'b0;
            end
            
            R_STATE: begin
                // Wait until we receive valid data
                if(~m00_axi_rvalid) begin
                    m00_axi_arvalid_n       <= 1'b0;
                    m00_axi_rready_n        <= 1'b1;
                    m_h2c_byp_in_st_vld_n   <= 1'b0;
                    m_h2c_byp_in_raddr_n    <= 64'd0;
                    
                    state_n                 <= R_STATE;
                end
                else begin
                    m00_axi_arvalid_n       <= 1'b0;
                    m00_axi_rready_n        <= 1'b0;
                    m_h2c_byp_in_st_vld_n   <= 1'b1;
                    m_h2c_byp_in_raddr_n    <= {16'd0, m00_axi_rdata[47:0]}; // Only stores 48-bits of virtual address
                    state_n                 <= DESCR_STATE;
                end
                
                m00_axi_awvalid_n       <= 1'b0;
                m00_axi_wvalid_n        <= 1'b0;
                m00_axi_bready_n        <= 1'b0;
            end
            
            DESCR_STATE: begin
                // Wait until we recieve a ready from QDMA
                if(~m_h2c_byp_in_st_rdy) begin
                    m_h2c_byp_in_st_vld_n   <= 1'b1;
                    m00_axi_awvalid_n       <= 1'b0;
                    m00_axi_wvalid_n        <= 1'b0;
                    state_n                 <= DESCR_STATE;
                end
                else begin
                    m_h2c_byp_in_st_vld_n   <= 1'b0;
                    m00_axi_awvalid_n       <= cache_overlap_reg;
                    m00_axi_wvalid_n        <= cache_overlap_reg;
                    state_n                 <= cache_overlap_reg ? AW_STATE : WAIT_STATE;
                end
                
                m00_axi_arvalid_n       <= 1'b0;
                m00_axi_rready_n        <= 1'b0;
                m_h2c_byp_in_raddr_n    <= m_h2c_byp_in_raddr;
                m00_axi_bready_n        <= 1'b0;
            end
            
            // We are only ever going to go into this state if cache_overlap_reg is high, 
            // so we can assume that it is high.
            AW_STATE: begin
                if(!aw_and_w_ready_sticky_high_delayed) begin
                    
                    // If we recieved a ready we have to set valid low
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
                
                m00_axi_arvalid_n       <= 1'b0;    
                m00_axi_rready_n        <= 1'b0;     
                m_h2c_byp_in_st_vld_n   <= 1'b0;
                m_h2c_byp_in_raddr_n    <= 64'd0;
            end
            
            W_STATE: begin
                // Waiting until we receive a valid write response
                if(~m00_axi_bvalid) begin
                    m00_axi_bready_n     <= 1'b1;
                    state_n              <= W_STATE;
                end
                else begin
                    m00_axi_bready_n     <= 1'b0;
                    state_n              <= WAIT_STATE; 
                end
                
                m00_axi_arvalid_n       <= 1'b0;    
                m00_axi_rready_n        <= 1'b0;     
                m_h2c_byp_in_st_vld_n   <= 1'b0;
                m_h2c_byp_in_raddr_n    <= 64'd0; 
                m00_axi_awvalid_n       <= 1'b0;
                m00_axi_wvalid_n        <= 1'b0;
            end
            
            
            
            WAIT_STATE: begin
                // Need to wait for tlb_miss to go low again, maybe don't need to 
                // do this anymore now that we are clearing the miss in this module
                if(tlb_miss) begin   
                    state_n                 <= WAIT_STATE;
                end
                else begin
                    state_n                 <= IDLE;
                end
                
                m00_axi_arvalid_n       <= 1'b0;
                m00_axi_rready_n        <= 1'b0;
                m_h2c_byp_in_st_vld_n   <= 1'b0;
                m_h2c_byp_in_raddr_n    <= 64'd0;
                m00_axi_awvalid_n       <= 1'b0;
                m00_axi_wvalid_n        <= 1'b0;
                m00_axi_bready_n        <= 1'b0;
            end
            
            default: begin
                m00_axi_arvalid_n       <= 1'b0;
                m00_axi_rready_n        <= 1'b0;
                m_h2c_byp_in_st_vld_n   <= 1'b0;
                m_h2c_byp_in_raddr_n    <= 64'd0;
                m00_axi_awvalid_n       <= 1'b0;
                m00_axi_wvalid_n        <= 1'b0;
                m00_axi_bready_n        <= 1'b0;
                state_n                 <= IDLE;
            end
        
        endcase
    
    
    end
    
    
    // Flops
    always@(posedge clk) begin
        if(~aresetn) begin
            m00_axi_arvalid     <= 1'b0;
            m00_axi_rready      <= 1'b0;
            m_h2c_byp_in_st_vld <= 1'b0;
            m_h2c_byp_in_raddr  <= 64'd0;
            m00_axi_awvalid     <= 1'b0;
            m00_axi_wvalid      <= 1'b0;
            m00_axi_bready      <= 1'b0;
            state               <= IDLE;
        end
        else begin
            m00_axi_arvalid     <= m00_axi_arvalid_n;
            m00_axi_rready      <= m00_axi_rready_n;
            m_h2c_byp_in_st_vld <= m_h2c_byp_in_st_vld_n;
            m_h2c_byp_in_raddr  <= m_h2c_byp_in_raddr_n;
            m00_axi_awvalid     <= m00_axi_awvalid_n;
            m00_axi_wvalid      <= m00_axi_wvalid_n;
            m00_axi_bready      <= m00_axi_bready_n;
            state               <= state_n;
        end
    end
    



endmodule

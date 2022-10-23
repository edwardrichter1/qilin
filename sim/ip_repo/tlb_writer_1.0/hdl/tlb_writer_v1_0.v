
`timescale 1 ns / 1 ps

module tlb_writer_v1_0 #
(
    // Parameters of Axi Master Bus Interface M00_AXI
    parameter  C_M00_AXI_START_DATA_VALUE	= 32'hAA000000,
    parameter  C_M00_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
    parameter integer C_M00_AXI_ADDR_WIDTH	= 64,
    parameter integer C_M00_AXI_DATA_WIDTH	= 64,
    parameter integer C_M00_AXI_TRANSACTIONS_NUM	= 4
)
(

    // Clocks and resets
    input wire clk,
    input wire aresetn,
    
    // Need to be able to tap into the module 
    // generating the translation requests 
    // in order to get the vaddr
    input  wire [63:0]  vadddr_in,
    input  wire         vaddr_valid,
    
    // If we are using the cache overlap optimization
    input wire cache_overlap,

    // Input from m_axis_h2c 
    input  wire [511:0] s_axis_h2c_tdata,
    input  wire [31:0]  s_axis_h2c_tuser_crc,
    input  wire [10:0]  s_axis_h2c_tuser_qid,
    input  wire [2:0]   s_axis_h2c_tuser_port_id,
    input  wire         s_axis_h2c_tuser_err,
    input  wire [31:0]  s_axis_h2c_tuser_mdata,
    input  wire [5:0]   s_axis_h2c_tuser_mty,
    input  wire         s_axis_h2c_tuser_zerobyte,
    input  wire         s_axis_h2c_tvalid,
    input  wire         s_axis_h2c_tlast,
    output wire         s_axis_h2c_tready,


    // Ports of Axi Master Bus Interface M00_AXI
    output  wire [C_M00_AXI_ADDR_WIDTH-1 : 0]   m00_axi_awaddr,
    output  wire [2 : 0]                        m00_axi_awprot,
    output  reg                                 m00_axi_awvalid,
    input   wire                                m00_axi_awready,
    output  wire [C_M00_AXI_DATA_WIDTH-1 : 0]   m00_axi_wdata,
    output  wire [C_M00_AXI_DATA_WIDTH/8-1 : 0] m00_axi_wstrb,
    output  reg                                 m00_axi_wvalid,
    input   wire                                m00_axi_wready,
    input   wire [1 : 0]                        m00_axi_bresp,
    input   wire                                m00_axi_bvalid,
    output  reg                                 m00_axi_bready,
    output  wire [C_M00_AXI_ADDR_WIDTH-1 : 0]   m00_axi_araddr,
    output  wire [2 : 0]                        m00_axi_arprot,
    output  reg                                 m00_axi_arvalid,
    input   wire                                m00_axi_arready,
    input   wire [C_M00_AXI_DATA_WIDTH-1 : 0]   m00_axi_rdata,
    input   wire [1 : 0]                        m00_axi_rresp,
    input   wire                                m00_axi_rvalid,
    output  reg                                 m00_axi_rready
);

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


    // Tying off AXI signals I am not going to use
    assign m00_axi_awprot   = 0;
    assign m00_axi_wstrb    = 8'hFF;
    assign m00_axi_arprot   = 0;
    
    // FIFO used to store the vaddrs of in-flight translations
    wire [63:0] in_flight_fifo_vaddr;
    xpm_fifo_sync #(
      .DOUT_RESET_VALUE("0"),    // String
      .ECC_MODE("no_ecc"),       // String
      .FIFO_MEMORY_TYPE("auto"), // String
      .FIFO_READ_LATENCY(1),     // DECIMAL
      .FIFO_WRITE_DEPTH(2048),   // DECIMAL
      .FULL_RESET_VALUE(0),      // DECIMAL
      .PROG_EMPTY_THRESH(10),    // DECIMAL
      .PROG_FULL_THRESH(10),     // DECIMAL
      .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
      .READ_DATA_WIDTH(64),     // DECIMAL
      .READ_MODE("fwft"),        // String
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .USE_ADV_FEATURES("0000"), // String
      .WAKEUP_TIME(0),           // DECIMAL
      .WRITE_DATA_WIDTH(64),    // DECIMAL
      .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
   )
   in_flight_fifo (
      .almost_empty(),
      .almost_full(),
      .data_valid(),
      .dbiterr(),
      .dout(in_flight_fifo_vaddr),
      .empty(),
      .full(), // NOTE: We just ignore this for now and size this much larger than possible # of in flight requests
      .overflow(),
      .prog_empty(),
      .prog_full(),
      .rd_data_count(),
      .rd_rst_busy(),
      .sbiterr(),
      .underflow(),
      .wr_ack(),
      .wr_data_count(),
      .wr_rst_busy(),
      .din(vadddr_in),
      .injectdbiterr(),
      .injectsbiterr(),
      .rd_en(s_axis_h2c_tvalid),                 
      .rst(~aresetn),
      .sleep(),
      .wr_clk(clk), // They say that this must be a free running clock, don't think this is but we will see
      .wr_en(vaddr_valid)
   );
    
    // FIFO used to store the data from translation request completions
    // TODO
    wire        trans_fifo_empty;
    wire        trans_fifo_full;
    reg         trans_fifo_rd_en;
    wire [63:0] trans_fifo_vaddr;
    wire [63:0] trans_fifo_paddr;
    
    // Use FIFO as handshake
    assign s_axis_h2c_tready = ~trans_fifo_full;
    
   // xpm_fifo_sync: Synchronous FIFO
   // Xilinx Parameterized Macro, version 2020.2
   xpm_fifo_sync #(
      .DOUT_RESET_VALUE("0"),    // String
      .ECC_MODE("no_ecc"),       // String
      .FIFO_MEMORY_TYPE("auto"), // String
      .FIFO_READ_LATENCY(1),     // DECIMAL
      .FIFO_WRITE_DEPTH(2048),   // DECIMAL
      .FULL_RESET_VALUE(0),      // DECIMAL
      .PROG_EMPTY_THRESH(10),    // DECIMAL
      .PROG_FULL_THRESH(10),     // DECIMAL
      .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
      .READ_DATA_WIDTH(128),     // DECIMAL
      .READ_MODE("fwft"),        // String
      .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
      .USE_ADV_FEATURES("0000"), // String
      .WAKEUP_TIME(0),           // DECIMAL
      .WRITE_DATA_WIDTH(128),    // DECIMAL
      .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
   )
   trans_fifo (
      .almost_empty(),
      .almost_full(),
      .data_valid(),
      .dbiterr(),
      .dout({trans_fifo_vaddr, trans_fifo_paddr}),
      .empty(trans_fifo_empty),
      .full(trans_fifo_full),
      .overflow(),
      .prog_empty(),
      .prog_full(),
      .rd_data_count(),
      .rd_rst_busy(),
      .sbiterr(),
      .underflow(),
      .wr_ack(),
      .wr_data_count(),
      .wr_rst_busy(),
      .din({in_flight_fifo_vaddr, s_axis_h2c_tdata[7:0], s_axis_h2c_tdata[15:8], s_axis_h2c_tdata[23:16], s_axis_h2c_tdata[31:24], s_axis_h2c_tdata[39:32], s_axis_h2c_tdata[47:40], s_axis_h2c_tdata[55:52], 12'd0}), // Have to unswizzle the paddr that is in the translation completion
      .injectdbiterr(),
      .injectsbiterr(),
      .rd_en(trans_fifo_rd_en),                 
      .rst(~aresetn),
      .sleep(),
      .wr_clk(clk), // They say that this must be a free running clock, don't think this is but we will see
      .wr_en(s_axis_h2c_tvalid)
   );

    
   
    
    // Data used in the FSM
    reg         m00_axi_awvalid_n;
    reg         m00_axi_wvalid_n;
    reg         m00_axi_bready_n;
    reg         m00_axi_arvalid_n;
    reg         m00_axi_rready_n;
    reg         trans_fifo_rd_en_n;
    reg         write_replay, write_replay_n;
    reg [31:0]  way, way_n;
    reg [2:0]   state, state_n;

    localparam IDLE = 0, AR_STATE = 1, R_STATE = 2, AW_STATE = 3, W_STATE = 4;
    
    
    // NOTE: There are better ways to do both of these now that we are in verilog (like with bit concatenation) TODO
    
    // Assigning the address we are reading/writing from/tio in the TLB 
    // TODO: Paramaterize this
    wire [63:0] tlb_addr;
    assign tlb_addr = {48'h0000_0000_0011, way[2:0], trans_fifo_vaddr[21:12], 3'b000};
    //assign tlb_addr = 64'h0000_0000_0011_0000 + 8 * ((trans_fifo_vaddr >> 12 /*PAGE_SHIFT*/ ) & 'b1111111111 /*STLB_ORDER_MASK*/) + way * ( 1 << 4 /*STLB_ASSOC*/ ); 
    
    // Assigning the address we are writing to to resume the access
    wire [63:0] replay_addr = 64'h0000_0000_0100_0000;
    
    assign m00_axi_araddr = tlb_addr;
    assign m00_axi_awaddr = write_replay ? replay_addr : tlb_addr;
    
    
    // Assining the entry we will write to the TLB
    // TODO: Parameterize this
    wire [63:0] tlb_data;
    wire [34:0] tlb_data_tag;
    wire [27:0] tlb_data_paddr_shifted;

    assign tlb_data_tag             = trans_fifo_vaddr >> 22 /* PAGE_SHIFT + STLB_ORDER*/;
    assign tlb_data_paddr_shifted   = trans_fifo_paddr >> 12 /*PAGE_SHIFT*/;
    assign tlb_data                 = {1'b1 /* valid bit */, tlb_data_tag, tlb_data_paddr_shifted};
    //assign tlb_data = 'h8000_0000_0000_0000 /*TLB_VALID_MASK*/ | ((trans_fifo_vaddr >> (12 /*PAGE_SHIFT*/ + 10/*STLB_ORDER*/)) << 28 /*STLB_PADDR_SIZE*/) | ((trans_fifo_paddr >> 12 /*PAGE_SHIFT*/) & 'b1111111111111111111111111111 /*STLB_PADDR_MASK*/);
    
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
    
    
    // Combinational logic
    always@(*) begin
        case(state)
        
            IDLE: begin
                // Poll on the translation fifo having valid data
                if(~trans_fifo_empty) begin
                    m00_axi_arvalid_n   <= 1'b1;
                    state_n             <= AR_STATE;
                end
                else begin
                    m00_axi_arvalid_n   <= 1'b0;
                    state_n             <= IDLE;
                end
                
                m00_axi_awvalid_n   <= 0;
                m00_axi_wvalid_n    <= 0;
                m00_axi_bready_n    <= 0;
                m00_axi_rready_n    <= 0;
                way_n               <= 0;
                write_replay_n      <= 1'b0;
                trans_fifo_rd_en_n  <= 1'b0;
            end
            
            AR_STATE: begin
                // Wait until we recieve address ready
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
                
                m00_axi_awvalid_n   <= 0;
                m00_axi_wvalid_n    <= 0;
                m00_axi_bready_n    <= 0;
                write_replay_n      <= 1'b0;
                way_n               <= way;
                trans_fifo_rd_en_n  <= 1'b0;
            end
            
            R_STATE: begin
                // Wait until we recieve data from the TLB
                if(~m00_axi_rvalid) begin
                    m00_axi_arvalid_n   <= 1'b0;
                    m00_axi_rready_n    <= 1'b1;
                    m00_axi_awvalid_n   <= 1'b0;
                    m00_axi_wvalid_n    <= 1'b0;
                    way_n               <= way;
                    state_n             <= R_STATE;
                    
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
                        state_n             <= AR_STATE;
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
                
                write_replay_n      <= 1'b0;
                m00_axi_bready_n    <= 1'b0;
                trans_fifo_rd_en_n  <= 1'b0;
                
            end
            
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
                    trans_fifo_rd_en_n  <= 1'b1;
                    state_n             <= AW_STATE;
                end
                else begin
                    m00_axi_awvalid_n   <= 1'b0;
                    m00_axi_wvalid_n    <= 1'b0;
                    m00_axi_bready_n    <= 1'b1;
                    trans_fifo_rd_en_n  <= 1'b0;
                    state_n             <= W_STATE;
                end
                
                write_replay_n      <= write_replay;
                m00_axi_arvalid_n   <= 1'b0;
                m00_axi_rready_n    <= 1'b0;
                way_n               <= way;
                
            end
            
            // Might be more accurate if this was called B_STATE but oh well
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
                else if(~write_replay & (cache_overlap_reg == 0)) begin
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
                
                m00_axi_arvalid_n   <= 1'b0;
                m00_axi_rready_n    <= 1'b0;
                trans_fifo_rd_en_n  <= 1'b0;
                way_n               <= 0;
            end
            
            default: begin
                m00_axi_arvalid_n   <= 1'b0;
                m00_axi_rready_n    <= 1'b0;
                m00_axi_awvalid_n   <= 1'b0;
                m00_axi_wvalid_n    <= 1'b0;
                way_n               <= 0;
                m00_axi_bready_n    <= 1'b0;
                trans_fifo_rd_en_n  <= 1'b0;
                write_replay_n      <= 1'b0;
                state_n             <= R_STATE;
            end
        
        
        endcase
    
    end
    
    
    // Sequential logic
    always@(posedge clk) begin
        if(~aresetn) begin
            m00_axi_awvalid     <= 0;
            m00_axi_wvalid      <= 0;
            m00_axi_bready      <= 0;
            m00_axi_arvalid     <= 0;
            m00_axi_rready      <= 0;
            way                 <= 0;
            trans_fifo_rd_en    <= 0;
            write_replay        <= 0;
            state               <= IDLE;
        end
        else begin
            m00_axi_awvalid   <= m00_axi_awvalid_n;
            m00_axi_wvalid    <= m00_axi_wvalid_n;
            m00_axi_bready    <= m00_axi_bready_n;
            m00_axi_arvalid   <= m00_axi_arvalid_n;
            m00_axi_rready    <= m00_axi_rready_n;
            way               <= way_n;
            trans_fifo_rd_en  <= trans_fifo_rd_en_n;
            write_replay      <= write_replay_n;
            state             <= state_n;
        end 
    end






endmodule

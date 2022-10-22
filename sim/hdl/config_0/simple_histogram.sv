`timescale 1ns / 1ps

`include "axi_macros.svh"
//`include "lynx_macros.svh"
import lynxTypes::*;

module simple_histogram(
    input wire          aclk,
    input wire          aresetn,
    
    // AXI Lite port
    // Was running into issues using the struct and multiple net drivers, just deconstructing it here
    //AXI4L.s             axi_l,
    input  wire                         axi_l_arvalid,
    output wire                         axi_l_arready,
    input  wire [AXI_ADDR_BITS-1:0]     axi_l_araddr,
    output wire [1:0]                   axi_l_rresp,
    input  wire                         axi_l_rready,
    output wire                         axi_l_rvalid,
    output reg [AXIL_DATA_BITS-1:0]     axi_l_rdata,
    
    // Indicate when request starts and when the data has come back
    input wire          axis_host_sink_t_valid,
    input wire          axis_host_sink_t_ready,
    input wire          axis_host_sink_t_last,
    input wire          rd_req_user_t_valid,
    input wire          rd_req_user_t_ready,
    input wire  [63:0]  num_requests
);
    
    // Number of bins in the histogram
    localparam NUM_BINS=512;
    localparam BINS_INDEX_WIDTH=$clog2(NUM_BINS);
    localparam BIN_SIZE=16;
    
    (* mark_debug = "true" *) reg [63:0] cycle_count;
    wire [63:0] cycle_count_fifo_out;
    wire fifo_empty;
    wire fifo_full;
    (* mark_debug = "true" *) wire fifo_dout_valid;
    
    //reg [32:0] histogram [NUM_BINS - 1:0];
    
    // Assigning static parts of the AXI bus
    assign axi_l_rresp = 0;
    
    always@(posedge aclk) begin
        if(!aresetn) begin
            cycle_count <= 0;
        end
        else begin
            cycle_count <= cycle_count + 1;
        end
    end
    
    xpm_fifo_sync #(
        .DOUT_RESET_VALUE("0"),    // String
        .ECC_MODE("no_ecc"),       // String
        .FIFO_MEMORY_TYPE("auto"), // String
        .FIFO_READ_LATENCY(2),     // DECIMAL
        .FIFO_WRITE_DEPTH(2048),   // DECIMAL
        .FULL_RESET_VALUE(0),      // DECIMAL
        .PROG_EMPTY_THRESH(10),    // DECIMAL
        .PROG_FULL_THRESH(10),     // DECIMAL
        .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
        .READ_DATA_WIDTH(64),      // DECIMAL
        .READ_MODE("std"),        // String
        .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
        .USE_ADV_FEATURES("1000"), // String
        .WAKEUP_TIME(0),           // DECIMAL
        .WRITE_DATA_WIDTH(64),     // DECIMAL
        .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
    )
    xpm_fifo_sync_inst (
        .almost_empty(),
        .almost_full(),
        .data_valid(fifo_dout_valid),
        .dbiterr(),
        .dout(cycle_count_fifo_out),                   
        .empty(fifo_empty),                 
        .full(fifo_full),                   
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
        .din(cycle_count),
        .injectdbiterr(),
        .injectsbiterr(), 
        .rd_en(axis_host_sink_t_valid & axis_host_sink_t_ready & axis_host_sink_t_last),
        .rst(~aresetn),
        .sleep(),
        .wr_clk(aclk),
        .wr_en(rd_req_user_t_valid & rd_req_user_t_ready)
    );
    
    // Keeping track of the number of requests sent
    (* mark_debug = "true" *) reg [31:0] num_reqs_sent;
    always@(posedge aclk) begin
        if(~aresetn) begin
            num_reqs_sent <= 0;
        end
        else begin
            if(rd_req_user_t_valid & rd_req_user_t_ready) begin
                num_reqs_sent <= num_reqs_sent + 1;
            end
            else begin
                num_reqs_sent <= num_reqs_sent;
            end
        end
    end
    
    // Keeping track of the number of data recieved
    (* mark_debug = "true" *) reg [31:0] num_reqs_recvd;
    always@(posedge aclk) begin
        if(~aresetn) begin
            num_reqs_recvd <= 0;
        end
        else begin
            if(fifo_dout_valid) begin
                num_reqs_recvd <= num_reqs_recvd + 1;
            end
            else begin
                num_reqs_recvd <= num_reqs_recvd;
            end
        end
    end
    

    // Writing to the histogram when the output is valid
    wire [BINS_INDEX_WIDTH-1:0] histogram_index;
    (* mark_debug = "true" *) wire [63:0] cycle_diff_bin;
    integer i;
    
    // Used to read from the histogram
    wire [31:0]                 histogram_douta;
    wire [31:0]                 histogram_doutb;
    reg  [AXI_ADDR_BITS-1:0]    s_axi_araddr_reg;
    
    // To write to the histogram, need to delay the address and 
    // valid by two clock cyles to get the current bin count, so 
    // we can increment it. We also want to flop between the 
    // FIFO and BRAM to ease timing, so need three flops
    reg         fifo_dout_valid_reg_1;
    reg [31:0]  histogram_index_reg_1;
    reg         fifo_dout_valid_reg_2;
    reg [31:0]  histogram_index_reg_2;
    reg         fifo_dout_valid_reg_3;
    reg [31:0]  histogram_index_reg_3;
    reg         fifo_dout_valid_reg_4;
    reg [63:0]  cycle_diff_bin_reg_1;
    always@(posedge aclk) begin
        if(~aresetn) begin
            fifo_dout_valid_reg_1 <= 0;
            histogram_index_reg_1 <= 0;
            cycle_diff_bin_reg_1  <= 0;
            fifo_dout_valid_reg_2 <= 0;
            histogram_index_reg_2 <= 0;
            fifo_dout_valid_reg_3 <= 0;
            histogram_index_reg_3 <= 0;
            fifo_dout_valid_reg_4 <= 0;
        end
        else begin
            fifo_dout_valid_reg_1 <= fifo_dout_valid;
            histogram_index_reg_1 <= histogram_index;
            cycle_diff_bin_reg_1  <= cycle_diff_bin;
            fifo_dout_valid_reg_2 <= fifo_dout_valid_reg_1;
            histogram_index_reg_2 <= histogram_index_reg_1;
            fifo_dout_valid_reg_3 <= fifo_dout_valid_reg_2;
            histogram_index_reg_3 <= histogram_index_reg_2;
            fifo_dout_valid_reg_4 <= fifo_dout_valid_reg_3;
        end
    end
    
    // Calculating the bin it will be in
    assign cycle_diff_bin = (cycle_count - cycle_count_fifo_out) >> $clog2(BIN_SIZE);
    
    // If we are going to overflow, put it in the last bin
    assign histogram_index = cycle_diff_bin_reg_1 >= NUM_BINS ? NUM_BINS - 1 : cycle_diff_bin_reg_1;

    
    /* Storing the histogram counts. Note that I am 
    using True DP BRAM but as a simple DP BRAM. This 
    is just in case I need to write to Port B in the future, 
    but for now Port A is solely used for writing incremented
    values of the histogram, and Port B is used to read
    the histogram for incrementing, and when the host
    wants to read the contents of the histogram. */
     xpm_memory_tdpram #(
        .ADDR_WIDTH_A($clog2(NUM_BINS)),// DECIMAL
        .ADDR_WIDTH_B($clog2(NUM_BINS)),// DECIMAL
        .AUTO_SLEEP_TIME(0),            // DECIMAL
        .BYTE_WRITE_WIDTH_A(32),        // DECIMAL
        .BYTE_WRITE_WIDTH_B(32),        // DECIMAL
        .CASCADE_HEIGHT(0),             // DECIMAL
        .CLOCKING_MODE("common_clock"), // String
        .ECC_MODE("no_ecc"),            // String
        .MEMORY_INIT_FILE("none"),      // String
        .MEMORY_INIT_PARAM("0"),        // String
        .MEMORY_OPTIMIZATION("true"),   // String
        .MEMORY_PRIMITIVE("auto"),      // String
        .MEMORY_SIZE(NUM_BINS*32),      // DECIMAL
        .MESSAGE_CONTROL(0),            // DECIMAL
        .READ_DATA_WIDTH_A(32),         // DECIMAL
        .READ_DATA_WIDTH_B(32),         // DECIMAL
        .READ_LATENCY_A(2),             // DECIMAL
        .READ_LATENCY_B(2),             // DECIMAL
        .READ_RESET_VALUE_A("0"),       // String
        .READ_RESET_VALUE_B("0"),       // String
        .RST_MODE_A("SYNC"),            // String
        .RST_MODE_B("SYNC"),            // String
        .SIM_ASSERT_CHK(0),             // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
        .USE_EMBEDDED_CONSTRAINT(0),    // DECIMAL
        .USE_MEM_INIT(1),               // DECIMAL
        .WAKEUP_TIME("disable_sleep"),  // String
        .WRITE_DATA_WIDTH_A(32),        // DECIMAL
        .WRITE_DATA_WIDTH_B(32),        // DECIMAL
        .WRITE_MODE_A("no_change"),     // String
        .WRITE_MODE_B("no_change")      // String
     )
     histogram_mem (
        .dbiterra(),
        .dbiterrb(),
        .douta(),
        .doutb(histogram_doutb),                                                                                                                                    // READ_DATA_WIDTH_B-bit output: Data output for port B read operations.
        .sbiterra(),
        .sbiterrb(),
        .addra(histogram_index_reg_3),                                                                                                                              // ADDR_WIDTH_A-bit input: Address for port A write and read operations.
        .addrb(fifo_dout_valid_reg_2 ? histogram_index_reg_1 /* Bin of histogram to increment */: (s_axi_araddr_reg >> 3) - 2 /* Address host is reading from */),  // Port B does reads when incrementing histogram and when host is reading from histogram
        .clka(aclk),
        .clkb(),                                                                                                                                                    // unushed when common_clock is set
        .dina(histogram_doutb + 1),                                                                                                                                 // WRITE_DATA_WIDTH_A-bit input: Data input for port A write operations.
        .dinb(0),                                                                                                                                                   // Not writing to B
        .ena(1'b1),                                                                                                                                                 // Going to try just setting to 1
        .enb(1'b1),                                                                                                                                                 // Going to try just setting to 1
        .injectdbiterra(), 
        .injectdbiterrb(),
        .injectsbiterra(),
        .injectsbiterrb(),
        .regcea(1'b1),                                                              // Going to try just setting this to 1
        .regceb(1'b1),
        .rsta(~aresetn),
        .rstb(~aresetn),
        .sleep(1'b0),                   
        .wea(fifo_dout_valid_reg_4),                              
        .web(1'b0)

     );

    receive_controller receive_controller_inst(
        .clk(aclk),
        .aresetn(aresetn),
        .arvalid(axi_l_arvalid),
        .rready(axi_l_rready),
        .arready(axi_l_arready),
        .rvalid(axi_l_rvalid)
    );
    
    // Reg to store last valid address to address mux
    always@(posedge aclk) begin
        if(~aresetn) begin      
            s_axi_araddr_reg <= 0;
        end
        else if(axi_l_arvalid) begin
            s_axi_araddr_reg[15:0] <= axi_l_araddr[15:0];
        end
        else begin
            s_axi_araddr_reg <= s_axi_araddr_reg;
        end
    end
    
    // MUX + flop to choose which 32-bit portion is to be read
    always @ (posedge aclk) begin
        // If a valid address, return histogram, else return junk
        // Address 8 will tell us if we have sent all requests and if we have received all requests
        // NOTE: had to change from Address 0 because for some reason when implementing it in hardware
        // I can't get a read to address 0 to get to the histogram :shrug:
        if(s_axi_araddr_reg == 8) begin
            axi_l_rdata = {num_reqs_sent, num_reqs_recvd};
        end
        else if(s_axi_araddr_reg < 8 * (NUM_BINS + 2)) begin
            // Reading 64 bits, duplicate histogram to both 32-bit words to make sure addressing doesn't mess us up
            axi_l_rdata <= {histogram_doutb, histogram_doutb}; // Need to divide by 4 to get word address, and minus 2 because we have an offset of 2
        end
        else begin
            axi_l_rdata <= 'hDEAD_BEEF_DEAD_BEEF;
        end
    end
    
    
    
endmodule

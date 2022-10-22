`timescale 1ns / 1ps

`include "axi_macros.svh"
`include "lynx_macros.svh"

import lynxTypes::*;

//`define RANDOM_READ

/**
 * User logic
 * 
 */
module design_user_logic_0 (
    // AXI4L CONTROL
    // Slave control. Utilize this interface for any kind of CSR implementation.
    AXI4L.s                     axi_ctrl,

    // AXI4S HOST
    AXI4SR.m                    axis_host_src,
    AXI4SR.s                    axis_host_sink,
    
    // AXI4S Card DRAM
`ifdef EN_DDR
    AXI4SR.m                    axis_card_src,
    AXI4SR.s                    axis_card_sink,
`endif

    // AXI4S RDMA
    //AXI4S.m                     axis_rdma_src,
    //AXI4S.s                     axis_rdma_sink,

    // FV
    //metaIntf.s                  fv_sink,
    //metaIntf.m                  fv_src,

    // Requests
    reqIntf.m                   rd_req_user,
    reqIntf.m                   wr_req_user,

    // RDMA
    //reqIntf.s                   rd_req_rdma,
    //reqIntf.s                   wr_req_rdma,

    // Clock and reset
    input  wire                 aclk,
    input  wire[0:0]            aresetn
);

parameter LINKED_LIST_UNROLL = 16;


/* -- Tie-off unused interfaces and signals ----------------------------- */
//always_comb axi_ctrl.tie_off_s();
//always_comb rd_req_user.tie_off_m();
always_comb wr_req_user.tie_off_m();
//always_comb rd_req_rdma.tie_off_s();
//always_comb wr_req_rdma.tie_off_s();
//always_comb fv_sink.tie_off_s();
//always_comb fv_src.tie_off_m();
//always_comb axis_rdma_src.tie_off_m();
//always_comb axis_rdma_sink.tie_off_s();
always_comb axis_host_src.tie_off_m();
always_comb axis_card_src.tie_off_m();
//always_comb axis_host_sink.tie_off_s();

/* -- USER LOGIC -------------------------------------------------------- */

// Defining the data-path port for Host -> RTL and flopping it
AXI4S axis_sink ();


// Defining CSR wires between control and data-path
wire [63:0]  num_requests;
wire [63:0]  base_addr [LINKED_LIST_UNROLL-1:0];
wire [63:0]  bound;
wire [63:0]  req_size;
wire [63:0]  stride;
wire         access_pattern;
wire         independent;
wire         ptr;
wire    [LINKED_LIST_UNROLL-1:0]  ap_start ;
reqIntf      rd_req_user_unroll     [LINKED_LIST_UNROLL-1:0] (aclk);
AXI4SR       axis_host_sink_unroll  [LINKED_LIST_UNROLL-1:0] (aclk);

genvar linked_list_gen_iter;
wire [13*8-1:0]                 concate_req_tdata [LINKED_LIST_UNROLL-1:0];
wire [LINKED_LIST_UNROLL-1:0]   concate_req_tvalid;
wire [LINKED_LIST_UNROLL-1:0]   concate_req_tready;
wire [3:0] rd_req_user_tid, tid_fifo_dout;


// If we are using DDR for some reason we have two seperate 
// AXI streams, one from the host and one from the card. 
// So if DDR is enabled going to combine them here, 
// otherwise just set equal to the host
wire [AXI_DATA_BITS-1:0]        axis_sink_tdata;
wire [(AXI_DATA_BITS/8)-1:0]    axis_sink_tkeep;
wire [3:0]                      axis_sink_tdest;
wire                            axis_sink_tlast;
wire                            axis_sink_tvalid;
reg                             axis_sink_tready;


`ifdef EN_DDR
    
    
    axis_card_host_mux axis_card_host_mux_inst (
        .aclk(aclk),                                                    // input wire aclk
        .aresetn(aresetn),                                              // input wire aresetn
        .s_axis_tvalid({axis_card_sink.tvalid, axis_host_sink.tvalid}), // input wire [1 : 0] s_axis_tvalid
        .s_axis_tready({axis_card_sink.tready, axis_host_sink.tready}), // output wire [1 : 0] s_axis_tready
        .s_axis_tdata({axis_card_sink.tdata, axis_host_sink.tdata}),    // input wire [1023 : 0] s_axis_tdata
        .s_axis_tkeep({axis_card_sink.tkeep, axis_host_sink.tkeep}),    // input wire [127 : 0] s_axis_tkeep
        .s_axis_tlast({axis_card_sink.tlast, axis_host_sink.tlast}),    // input wire [1 : 0] s_axis_tlast
        .s_axis_tdest({axis_card_sink.tdest, axis_host_sink.tdest}),    // input wire [7 : 0] s_axis_tdest
        .m_axis_tvalid(axis_sink_tvalid),                               // output wire [0 : 0] m_axis_tvalid
        .m_axis_tready(axis_sink_tready),                               // input wire [0 : 0] m_axis_tready
        .m_axis_tdata(axis_sink_tdata),                                 // output wire [511 : 0] m_axis_tdata
        .m_axis_tkeep(axis_sink_tkeep),                                 // output wire [63 : 0] m_axis_tkeep
        .m_axis_tlast(axis_sink_tlast),                                 // output wire [0 : 0] m_axis_tlast
        .m_axis_tdest(axis_sink_tdest),                                 // output wire [3 : 0] m_axis_tdest
        .s_req_suppress(2'd0),                                          // input wire [1 : 0] s_req_suppress
        .s_decode_err()                                                 // output wire [1 : 0] s_decode_err
    );
    
`else
    assign axis_sink_tdata = axis_host_sink.tdata;
    assign axis_sink_tkeep = axis_host_sink.tkeep;
    assign axis_sink_tdest = axis_host_sink.tdest;
    assign axis_sink_tlast = axis_host_sink.tlast;
    assign axis_sink_tvalid = axis_host_sink.tvalid;

    // tready is a reg? Not really sure why    
    always_comb begin
        axis_sink_tready = axis_host_sink.tready;
    end
`endif


// Control Interface
microbenchmark_controller microbenchmark_controller_inst(
    // Clock and Reset
    .aclk(aclk),
    .aresetn(aresetn),
    
    // AXI Lite to read/write CSRs
    //.axi_l(axi_ctrl), // Was running into issues using the struct and multiple net drivers, just deconstructing it here
    .axi_l_awvalid(axi_ctrl.awvalid),
    .axi_l_awaddr(axi_ctrl.awaddr),
    .axi_l_awready(axi_ctrl.awready),
    .axi_l_wvalid(axi_ctrl.wvalid),
    .axi_l_wready(axi_ctrl.wready),
    .axi_l_wdata(axi_ctrl.wdata),
    .axi_l_wstrb(axi_ctrl.wstrb),
    .axi_l_bvalid(axi_ctrl.bvalid),
    .axi_l_bready(axi_ctrl.bready),
    .axi_l_bresp(axi_ctrl.bresp),
    
    // Outputting the CSRs in the control reg file
    .num_requests(num_requests),
    .base_addr(base_addr),
    .bound(bound),
    .req_size(req_size),
    .stride(stride),
    .access_pattern(access_pattern),
    .independent(independent),
    .ptr(ptr),
    .ap_start(ap_start)
);

`ifdef RANDOM_READ  
    // Data-path
    random_read_data_path random_read_data_path_inst(
        // Clock and Reset
        .aclk(aclk),
        .aresetn(aresetn),
        
        // The CSRs in the control reg file
        .num_requests(num_requests),
        .base_addr(base_addr),
        .bound(bound),
        .req_size(req_size),
        .stride(stride),
        .access_pattern(access_pattern),
        .ap_start(ap_start[0]),
        
        // Outputting the user requests
        .rd_req_user(rd_req_user)
    );
    
    // Receiving the data. For random read we aren't actually doing anythign with the data so we just leave it
    always_comb begin
        axis_sink_tready    = 1'b1;
    end

`else
    for(linked_list_gen_iter = 0; linked_list_gen_iter < LINKED_LIST_UNROLL; linked_list_gen_iter = linked_list_gen_iter + 1) begin:linked_list_gen
        linked_list_traversal_data_path linked_list_traversal_data_path_inst (
            // Clock and Reset
            .aclk(aclk),
            .aresetn(aresetn),
            
            // The CSRs in the control reg file
            .num_requests(num_requests),
            .base_addr(base_addr[linked_list_gen_iter]),
            .req_size(req_size),
            .ap_start(ap_start[linked_list_gen_iter]),
            .independent(independent),
            .ptr(ptr),
            
            // Outputting the user requests
            .rd_req_user(rd_req_user_unroll[linked_list_gen_iter]),
            
            // Input data of nodes as they come in
            .axis_host_sink(axis_host_sink_unroll[linked_list_gen_iter])
        );
        
        // Assigning concatenated wires so we can put them into a AXIS Switch
        assign concate_req_tvalid[linked_list_gen_iter]         = rd_req_user_unroll[linked_list_gen_iter].valid;
        assign rd_req_user_unroll[linked_list_gen_iter].ready   = concate_req_tready[linked_list_gen_iter];
        assign concate_req_tdata[linked_list_gen_iter]          = { rd_req_user_unroll[linked_list_gen_iter].req.rsrvd_high,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.cache_mode,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.vaddr,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.len,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.stream,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.sync,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.ctl,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.dest,
                                                                    rd_req_user_unroll[linked_list_gen_iter].req.rsrvd};
       
       
        // Creating a demux to map tvalid to the correct linked_list module, other busses are just 
        // connected, doesn't matter if there is a match
        assign axis_host_sink_unroll[linked_list_gen_iter].tvalid = axis_sink_tvalid & (linked_list_gen_iter == tid_fifo_dout);
        assign axis_host_sink_unroll[linked_list_gen_iter].tdata = axis_sink_tdata;
        assign axis_host_sink_unroll[linked_list_gen_iter].tdest = axis_sink_tdest;
        assign axis_host_sink_unroll[linked_list_gen_iter].tlast = axis_sink_tlast;
        assign axis_host_sink_unroll[linked_list_gen_iter].tkeep = axis_sink_tkeep;
        
        
    end



// Need to use an AXIS Switch to arbitrate between the different rd_reqs
ll_rd_req_switch ll_rd_req_switch_inst (
  .aclk(aclk),                      // input wire aclk
  .aresetn(aresetn),                // input wire aresetn
  .s_axis_tvalid(concate_req_tvalid),    // input wire [15 : 0] s_axis_tvalid
  .s_axis_tready(concate_req_tready),    // output wire [15 : 0] s_axis_tready
  .s_axis_tdata({concate_req_tdata[15],
                concate_req_tdata[14],
                concate_req_tdata[13],
                concate_req_tdata[12],
                concate_req_tdata[11],
                concate_req_tdata[10],
                concate_req_tdata[ 9],
                concate_req_tdata[ 8],
                concate_req_tdata[ 7],
                concate_req_tdata[ 6],
                concate_req_tdata[ 5],
                concate_req_tdata[ 4],
                concate_req_tdata[ 3],
                concate_req_tdata[ 2],
                concate_req_tdata[ 1],
                concate_req_tdata[ 0]}),      // input wire [1535 : 0] s_axis_tdata
  .s_axis_tid({ 4'd15,
                4'd14,
                4'd13,
                4'd12,
                4'd11,
                4'd10,
                4'd9,
                4'd8,
                4'd7,
                4'd6,
                4'd5,
                4'd4,
                4'd3,
                4'd2,
                4'd1,
                4'd0}),          // input wire [63 : 0] s_axis_tid
  
  .m_axis_tvalid(rd_req_user.valid),    // output wire [0 : 0] m_axis_tvalid
  .m_axis_tready(rd_req_user.ready),    // input wire [0 : 0] m_axis_tready
  .m_axis_tdata({ rd_req_user.req.rsrvd_high,
                  rd_req_user.req.cache_mode,
                  rd_req_user.req.vaddr,
                  rd_req_user.req.len,
                  rd_req_user.req.stream,
                  rd_req_user.req.sync,
                  rd_req_user.req.ctl,
                  rd_req_user.req.dest,
                  rd_req_user.req.rsrvd}),      // output wire [103 : 0] m_axis_tdata
  
  // TODO: Connect this to the FIFO coming back in
  .m_axis_tid(rd_req_user_tid),          // output wire [3 : 0] m_axis_tid
  .s_req_suppress(16'd0),  // input wire [15 : 0] s_req_suppress
  .s_decode_err()      // output wire [15 : 0] s_decode_err
);

// A FIFO that keep track of the ID that sent the request, so we 
// can return them to the proper module
xpm_fifo_sync #(
    .DOUT_RESET_VALUE("0"),    // String
    .ECC_MODE("no_ecc"),       // String
    .FIFO_MEMORY_TYPE("auto"), // String
    .FIFO_READ_LATENCY(1),     // DECIMAL
    .FIFO_WRITE_DEPTH(64),   // DECIMAL
    .FULL_RESET_VALUE(0),      // DECIMAL
    .PROG_EMPTY_THRESH(10),    // DECIMAL
    .PROG_FULL_THRESH(10),     // DECIMAL
    .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
    .READ_DATA_WIDTH(4),      // DECIMAL
    .READ_MODE("fwft"),        // String
    .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
    .USE_ADV_FEATURES("1000"), // String
    .WAKEUP_TIME(0),           // DECIMAL
    .WRITE_DATA_WIDTH(4),     // DECIMAL
    .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
)
linked_list_tag_fifo (
    .almost_empty(),
    .almost_full(),
    .data_valid(),
    .dbiterr(),
    .dout(tid_fifo_dout),                   
    .empty(),                 
    .full(),                   // We are assuming this will never be full. 
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
    .din(rd_req_user_tid),
    .injectdbiterr(),
    .injectsbiterr(), 
    .rd_en(axis_sink_tvalid & axis_sink_tready & axis_sink_tlast), // Pop once we recieve tlast and are ready for it
    .rst(~aresetn),
    .sleep(),
    .wr_clk(aclk),
    .wr_en(rd_req_user.valid & rd_req_user.ready)
);


// Mux to assign the proper tready
always@(*) begin
    case(tid_fifo_dout)
        4'd0:  axis_sink_tready = axis_host_sink_unroll[0].tready;
        4'd1:  axis_sink_tready = axis_host_sink_unroll[1].tready;
        4'd2:  axis_sink_tready = axis_host_sink_unroll[2].tready;
        4'd3:  axis_sink_tready = axis_host_sink_unroll[3].tready;
        4'd4:  axis_sink_tready = axis_host_sink_unroll[4].tready;
        4'd5:  axis_sink_tready = axis_host_sink_unroll[5].tready;
        4'd6:  axis_sink_tready = axis_host_sink_unroll[6].tready;
        4'd7:  axis_sink_tready = axis_host_sink_unroll[7].tready;
        4'd8:  axis_sink_tready = axis_host_sink_unroll[8].tready;
        4'd9:  axis_sink_tready = axis_host_sink_unroll[9].tready;
        4'd10: axis_sink_tready = axis_host_sink_unroll[10].tready;
        4'd11: axis_sink_tready = axis_host_sink_unroll[11].tready;
        4'd12: axis_sink_tready = axis_host_sink_unroll[12].tready;
        4'd13: axis_sink_tready = axis_host_sink_unroll[13].tready;
        4'd14: axis_sink_tready = axis_host_sink_unroll[14].tready;
        4'd15: axis_sink_tready = axis_host_sink_unroll[15].tready;
    endcase
end

`endif

// Generating a histogram of access latencies
simple_histogram simple_histogram_inst(
    .aclk(aclk),
    .aresetn(aresetn),
    
    // AXI Lite to read histogram
    //.axi_l(axi_ctrl), // Was running into issues using the struct and multiple net drivers, just deconstructing it here
    .axi_l_arvalid(axi_ctrl.arvalid),
    .axi_l_arready(axi_ctrl.arready),
    .axi_l_araddr(axi_ctrl.araddr),
    .axi_l_rresp(axi_ctrl.rresp),
    .axi_l_rready(axi_ctrl.rready),
    .axi_l_rvalid(axi_ctrl.rvalid),
    .axi_l_rdata(axi_ctrl.rdata),
    
    // Signifies when a request is sent out and when corresponding data is coming abck
    .axis_host_sink_t_valid(axis_sink_tvalid),
    .axis_host_sink_t_ready(axis_sink_tready),
    .axis_host_sink_t_last(axis_sink_tlast),
    .rd_req_user_t_valid(rd_req_user.valid),
    .rd_req_user_t_ready(rd_req_user.ready),
    .num_requests(num_requests << ptr) // if payloads are pointed to we will do 2x the requests
);


endmodule


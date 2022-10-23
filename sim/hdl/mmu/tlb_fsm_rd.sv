/**
 *	TLB FSM read
 *
 * Request channels
 * @param:
 * 	- RDWR : 	Read(0) or write(1) request channel
 */ 

import lynxTypes::*;

//`define DEBUG_TLB_FSM_RD

module tlb_fsm_rd #(
	parameter integer ID_REG = 0,
	parameter integer RDWR = 0
) (
	input logic							aclk,    
	input logic 						aresetn,

	// TLBs
	tlbIntf.m 							lTlb,
	tlbIntf.m							sTlb,

	// User logic
	cnfgIntf.s   						cnfg,

	// Requests
	reqIntf.s 							req_in,

	// DMA - host
`ifdef EN_STRM
	dmaIntf.m   						HDMA, // Host
`endif

	// DMA - card
`ifdef EN_DDR
	dmaIntf.m 							DDMA, // Card
	dmaIsrIntf.m 	    				IDMA, // Page fault, sync
`endif

	// Mutex
	output logic 						lock,
	output logic 						unlock,
	input  logic [1:0]					mutex
);

// ----------------------------------------------------------------------------------------------------------
// -- Decl
// ----------------------------------------------------------------------------------------------------------

// -- Constants
localparam integer PG_L_SIZE = 1 << PG_L_BITS;
localparam integer PG_S_SIZE = 1 << PG_S_BITS;
localparam integer HASH_L_BITS = TLB_L_ORDER;
localparam integer HASH_S_BITS = TLB_S_ORDER;
localparam integer TAG_L_BITS = VADDR_BITS - HASH_L_BITS - PG_L_BITS;
localparam integer TAG_S_BITS = VADDR_BITS - HASH_S_BITS - PG_S_BITS;
localparam integer PHY_L_BITS = PADDR_BITS - PG_L_BITS;
localparam integer PHY_S_BITS = PADDR_BITS - PG_S_BITS;
localparam integer TLB_PHY_S_BITS = 40 - PG_S_BITS; // Eddie added this becuase I increased PADDR_BITS and that messed up the TLB comparison
localparam integer TLB_HIT_PADDR_PAD_BITS = TLB_DATA_BITS - TLB_PHY_S_BITS; // This is the number of bits we need to pad the PADDR when we get a hit in the TLB
localparam integer HIT_L_IDX_BITS = $clog2(N_L_ASSOC);
localparam integer HIT_S_IDX_BITS = $clog2(N_S_ASSOC);

// -- FSM ---------------------------------------------------------------------------------------------------
typedef enum logic[3:0]  {ST_IDLE, ST_MUTEX, ST_CHECK,
					      ST_HIT_LARGE, ST_HIT_SMALL, ST_CALC_LARGE, ST_CALC_SMALL, // timing extra states
`ifdef EN_STRM
                          ST_HOST_SEND,
`endif
`ifdef EN_DDR
						  ST_ISR_WAIT,
                          ST_CARD_SEND, ST_SYNC_SEND, ST_ISR_SEND,
`endif
                          ST_MISS} state_t;
(* mark_debug = "true" *) logic [3:0] state_C, state_N;

// -- Internal registers ------------------------------------------------------------------------------------
// Request
(* mark_debug = "true" *) logic overlap_request_sent_N, overlap_request_sent_C;
(* mark_debug = "true" *) logic [1:0] cache_mode_N, cache_mode_C;
(* mark_debug = "true" *) logic [1:0] at_N, at_C;
logic [LEN_BITS-1:0] len_C, len_N;
(* mark_debug = "true" *) logic [VADDR_BITS-1:0] vaddr_C, vaddr_N;
logic sync_C, sync_N;
logic ctl_C, ctl_N;
logic strm_C, strm_N;
logic [3:0] dest_C, dest_N;

// TLB data
logic [TLB_DATA_BITS-1:0] data_host_C, data_host_N;
logic [TLB_DATA_BITS-1:0] data_card_C, data_card_N;

// Page fault
logic unlock_C, unlock_N;
(* mark_debug = "true" *) logic miss_C, miss_N;
(* mark_debug = "true" *) logic [LEN_BITS-1:0] len_miss_C, len_miss_N;
(* mark_debug = "true" *) logic [VADDR_BITS-1:0] vaddr_miss_C, vaddr_miss_N;
(* mark_debug = "true" *) logic isr_C, isr_N;

// -- Out
logic [LEN_BITS-1:0] plen_C, plen_N;
logic [PADDR_BITS-1:0] paddr_host_C, paddr_host_N;
logic [PADDR_BITS-1:0] paddr_card_C, paddr_card_N;

// -- Internal signals --------------------------------------------------------------------------------------
logic [N_L_ASSOC-1:0] tag_cmp_card_l;
logic [N_S_ASSOC-1:0] tag_cmp_card_s;

logic [N_L_ASSOC-1:0] tag_cmp_host_l;
logic [N_S_ASSOC-1:0] tag_cmp_host_s;

logic hitL;
logic hitS;

// Eddie added to keep track of what is being missed
logic hitL_card;
logic hitS_card;
logic hitL_host;
logic hitS_host;

logic [HIT_L_IDX_BITS-1:0] hitL_card_idx;
logic [HIT_S_IDX_BITS-1:0] hitS_card_idx;

logic [HIT_L_IDX_BITS-1:0] hitL_host_idx;
logic [HIT_S_IDX_BITS-1:0] hitS_host_idx;

// ----------------------------------------------------------------------------------------------------------
// -- Def
// ----------------------------------------------------------------------------------------------------------

// REG
always_ff @(posedge aclk, negedge aresetn) begin: PROC_REG
if (aresetn == 1'b0) begin
	state_C <= ST_IDLE;

    // ISR
	miss_C <= 0;
	unlock_C <= 0;
    isr_C <= 0;
end
else
	state_C <= state_N;

    // Requests
    overlap_request_sent_C <= overlap_request_sent_N;
    cache_mode_C <= cache_mode_N;
    at_C <= at_N;
	len_C <= len_N;
	vaddr_C <= vaddr_N;
	sync_C <= sync_N;
	ctl_C <= ctl_N;
	strm_C <= strm_N;
	dest_C <= dest_N;
    // TLB
	plen_C <= plen_N;
	paddr_host_C <= paddr_host_N;
	data_host_C <= data_host_N;	
`ifdef EN_DDR
    paddr_card_C <= paddr_card_N;
	data_card_C <= data_card_N;	
`endif
    // ISR
	miss_C <= miss_N;
	unlock_C <= unlock_N;
    isr_C <= isr_N;
    len_miss_C <= len_miss_N;
	vaddr_miss_C <= vaddr_miss_N;
end

// NSL
always_comb begin: NSL
	state_N = state_C;

	case(state_C)
		// Wait until request queue is not empty
		ST_IDLE: 
			state_N = (req_in.valid) ? ST_MUTEX : ST_IDLE;
		
        // Obtain mutex
        ST_MUTEX:
			state_N = ((mutex[1] == RDWR) && (mutex[0] == 1'b0)) ? ST_CHECK : ST_MUTEX;

		// Check hits
		// NOTE: cache_mode_C == NO_CACHE can be set if using ATS, and currently can only be used for 4KiB pages.
		// If we are using Cache Overlap, we are going to miss on the first one, but then overlap_request_sent
		// is going to be set high, and we will hit
		ST_CHECK:
            state_N = (cache_mode_C == NO_CACHE || overlap_request_sent_C) ? ST_HIT_SMALL : (hitL ? ST_HIT_LARGE : hitS ? ST_HIT_SMALL : ST_MISS);

        // Page parsing
		ST_HIT_LARGE:
			state_N = ST_CALC_LARGE;
		ST_HIT_SMALL:
			state_N = ST_CALC_SMALL;
		
		// Calc.
		ST_CALC_LARGE:
`ifdef EN_STRM
    `ifdef EN_DDR
			if(strm_C) 
				state_N = ST_HOST_SEND;
			else
				state_N = (isr_C & cnfg.migration & !sync_C) ? ST_ISR_SEND : sync_C ? ST_SYNC_SEND : hitS_host ? ST_HOST_SEND : ST_CARD_SEND; // Eddie updated to not have redundant data copies
    `else
			state_N = ST_HOST_SEND;
    `endif
`else
			state_N = (isr_C & cnfg.migration & !sync_C) ? ST_ISR_SEND : sync_C ? ST_SYNC_SEND : hitS_host ? ST_HOST_SEND : ST_CARD_SEND; // Eddie updated to not have redundant data copies
`endif
		ST_CALC_SMALL:
`ifdef EN_STRM
	`ifdef EN_DDR
			if(strm_C) 
				state_N = ST_HOST_SEND;
			else
				state_N = (isr_C & cnfg.migration & !sync_C) ? ST_ISR_SEND : sync_C ? ST_SYNC_SEND : hitS_host ? ST_HOST_SEND : ST_CARD_SEND; // Eddie updated to not have redundant data copies
	`else
			state_N = ST_HOST_SEND;
	`endif
`else
			state_N = (isr_C & cnfg.migration & !sync_C) ? ST_ISR_SEND : sync_C ? ST_SYNC_SEND : hitS_host ? ST_HOST_SEND : ST_CARD_SEND; // Eddie updated to not have redundant data copies
`endif

        // Send DMA requests
`ifdef EN_STRM
		ST_HOST_SEND:
			if(HDMA.ready)
				state_N = len_C ? ST_MUTEX : ST_IDLE;
`endif

`ifdef EN_DDR
		ST_CARD_SEND:
            if(DDMA.ready)
                state_N = len_C ? ST_MUTEX : ST_IDLE;    
        ST_SYNC_SEND: 
            if(IDMA.ready) 
                state_N = len_C ? ST_MUTEX : ST_IDLE;
        ST_ISR_SEND:
            if(IDMA.ready)
                state_N = len_C ? ST_MUTEX : ST_ISR_WAIT;

		// Wait until data is fetched
		ST_ISR_WAIT:
            state_N = IDMA.done && IDMA.isr_return ? ST_MUTEX : ST_ISR_WAIT;
`endif
		
		// Page fault
		ST_MISS: begin
			state_N = cnfg.restart ? ST_CHECK : ST_MISS;
        end

	endcase // state_C
end

// DP
always_comb begin: DP
	// Requests
	overlap_request_sent_N = overlap_request_sent_C;
	cache_mode_N = cache_mode_C;
	at_N = at_C;
    len_N = len_C;
	vaddr_N = vaddr_C;
	sync_N = sync_C;
	ctl_N = ctl_C;
	strm_N = strm_C;
	dest_N = dest_C;

	// TLB
    data_host_N = data_host_C;
`ifdef EN_DDR
    data_card_N = data_card_C;
`endif
    
	// Out
	plen_N = plen_C;
	paddr_host_N = paddr_host_C;
`ifdef EN_DDR
    paddr_card_N = paddr_card_C;
`endif

    // ISR
	unlock_N = 1'b0;
	miss_N = 1'b0;
	vaddr_miss_N = vaddr_miss_C;
    len_miss_N = len_miss_C;
    isr_N = isr_C;

	// mutex
	lock = 1'b0;
	unlock = unlock_C;

	// Requests
	req_in.ready = 1'b0;

	// Config
`ifdef EN_STRM
    cnfg.done_host = HDMA.done;
`else
	cnfg.done_host = 1'b0;
`endif

`ifdef EN_DDR
    cnfg.done_card = DDMA.done;
	cnfg.done_sync = IDMA.done & ~IDMA.isr_return;
`else
	cnfg.done_card = 1'b0;
	cnfg.done_sync = 1'b0;
`endif

	cnfg.pf.miss = miss_C;
	cnfg.pf.vaddr = vaddr_miss_C;
	cnfg.pf.len = len_miss_C;

	// TLB
	lTlb.addr = vaddr_C;
	sTlb.addr = vaddr_C;

`ifdef EN_STRM
	// HDMA
	HDMA.req.rsrvd_high = 0;
	HDMA.req.at = at_C;//(cache_mode_C != STANDARD_CACHE) ? 2'b00 : 2'b10; // AT bits in PCIe ATS, 2'b00 is untranslated read (VA when IOMMU is on), 2'b10 is translated read (PA)
	HDMA.req.paddr = paddr_host_C;
	HDMA.req.len = plen_C;
	HDMA.req.ctl = 1'b0;
	HDMA.req.dest = dest_C;
	HDMA.req.rsrvd = 0;
	HDMA.valid = 1'b0;
`endif

`ifdef EN_DDR
	// DDMA
	DDMA.req.paddr = paddr_card_C;
	DDMA.req.len = plen_C;
	DDMA.req.ctl = 1'b0;
	DDMA.req.dest = dest_C;
	DDMA.req.rsrvd = 0;
	DDMA.req.at = 0; // TODO: JUST PUTTING THIS AS A PALCE HODLER
	DDMA.valid = 1'b0;

	// IDMA
	IDMA.req.paddr_card = { paddr_card_C[PADDR_BITS-1:PG_S_BITS], {PG_S_BITS{1'b0}} }; // Eddie changed this to transfer an entire page
    IDMA.req.paddr_host = { paddr_host_C[PADDR_BITS-1:PG_S_BITS], {PG_S_BITS{1'b0}} }; // Eddie changed this to transfer an entire page
	IDMA.req.len = plen_C;
	IDMA.req.ctl = 1'b0;
	IDMA.req.dest = dest_C;
    IDMA.req.isr = 1'b0;
	IDMA.req.rsrvd = 0;
	IDMA.valid = 1'b0;
`endif

	case(state_C)
		ST_IDLE: begin			
			isr_N = 1'b0;
			req_in.ready = 1'b1;
            if(req_in.valid) begin // RR
				// Lock the mutex
                lock = 1'b1;

                // Request
                cache_mode_N = req_in.req.cache_mode;
				len_N = req_in.req.len;
				vaddr_N = req_in.req.vaddr;
				sync_N = req_in.req.sync;
				ctl_N = req_in.req.ctl;
				strm_N = req_in.req.stream;
				dest_N = req_in.req.dest;
				overlap_request_sent_N = 1'b0;
			end
		end
		
		ST_MUTEX: 
			lock = 1'b1;

		ST_CHECK:
`ifdef EN_STRM
	`ifdef EN_DDR
			if((cache_mode_C == NO_CACHE) || hitS || hitL) begin
				if(strm_C)
					unlock_N = 1'b1;
				else
					unlock_N = ((isr_C & cnfg.migration) || sync_C) ? 1'b0 : 1'b1; // Eddie updated this to only hold onto the lock when we need to migrate
			    
			end
	`else
			if((cache_mode_C == NO_CACHE || overlap_request_sent_C) || hitS || hitL) begin
				unlock_N = 1'b1;
			end
	`endif
`else
			if((cache_mode_C == NO_CACHE) || hitS || hitL) begin
				unlock_N = (isr_C || sync_C) ? 1'b0 : 1'b1;
			end
`endif
			else begin
				miss_N = 1'b1;
				overlap_request_sent_N = (cache_mode_C == CACHE_OVERLAP) ? 1'b1 : 1'b0;
				vaddr_miss_N = vaddr_C;
				len_miss_N = len_C;
				isr_N = 1'b1;
			end

		ST_HIT_LARGE: begin
			data_host_N = lTlb.data[hitL_host_idx];
`ifdef EN_DDR
			data_card_N = lTlb.data[hitL_card_idx];
`endif
		end

		ST_HIT_SMALL: begin
		// If cache mode is standard cache, set to TLB contents as we know
		// it is a hit. If cache mode is no_cache set to virtual address, 
		// if cache mode is cache overlap, set to vaddr if miss, and paddr if hit
            data_host_N = (cache_mode_C == NO_CACHE || overlap_request_sent_C == 1'b1 ) ? vaddr_C[VADDR_BITS-1:PG_S_BITS] : {{TLB_HIT_PADDR_PAD_BITS{1'b0}}, sTlb.data[hitS_host_idx][TLB_PHY_S_BITS-1:0]};
            at_N = (cache_mode_C == NO_CACHE || overlap_request_sent_C == 1'b1 ) ? 2'b00 : 2'b10;
            overlap_request_sent_N = 1'b0;
`ifdef EN_DDR
			data_card_N = sTlb.data[hitS_card_idx];
`endif
		end

		ST_CALC_LARGE: begin
			paddr_host_N = {data_host_C[PHY_L_BITS-1:0], vaddr_C[PG_L_BITS-1:0]};
`ifdef EN_DDR
			paddr_card_N = {data_card_C[PHY_L_BITS-1:0], vaddr_C[PG_L_BITS-1:0]};
`endif
			if(len_C + vaddr_C[PG_L_BITS-1:0] > PG_L_SIZE) begin
				plen_N = PG_L_SIZE - vaddr_C[PG_L_BITS-1:0];
				len_N = len_C - (PG_L_SIZE - vaddr_C[PG_L_BITS-1:0]);
				vaddr_N += PG_L_SIZE - vaddr_C[PG_L_BITS-1:0];
			end
			else begin
				plen_N = (isr_C & cnfg.migration) ? PG_S_SIZE : len_C; // Eddie changed this, because the other way is not migrating the entire page
				len_N = 0;
			end
		end

		ST_CALC_SMALL: begin
		    paddr_host_N = {data_host_C[PHY_S_BITS-1:0], vaddr_C[PG_S_BITS-1:0]};
`ifdef EN_DDR
            paddr_host_N = ((isr_C & cnfg.migration) | sync_C) ? {cnfg.host_paddr[PHY_S_BITS-1:0], vaddr_C[PG_S_BITS-1:0]} : {data_host_C[PHY_S_BITS-1:0], vaddr_C[PG_S_BITS-1:0]}; // Eddie added this to get host addr from reg
			paddr_card_N = {data_card_C[PHY_S_BITS-1:0], vaddr_C[PG_S_BITS-1:0]};
`else
            // If we are not using the cache or we missed and our bypassing the cache, we can just use the virtual address
            paddr_host_N = {data_host_C[PHY_S_BITS-1:0], vaddr_C[PG_S_BITS-1:0]};
`endif
			if(len_C + vaddr_C[PG_S_BITS-1:0] > PG_S_SIZE) begin
				plen_N = PG_S_SIZE - vaddr_C[PG_S_BITS-1:0];
				len_N = len_C - (PG_S_SIZE - vaddr_C[PG_S_BITS-1:0]);
				vaddr_N += PG_S_SIZE - vaddr_C[PG_S_BITS-1:0];
			end
			else begin
				plen_N = (isr_C & cnfg.migration) ? PG_S_SIZE : len_C; // Eddie changed this, because the other way is not migrating the entire page
				len_N = 0;
			end
		end

`ifdef EN_STRM
		ST_HOST_SEND: begin
			HDMA.valid = HDMA.ready;
			HDMA.req.ctl = HDMA.valid && !len_C && ctl_C;
		end
`endif

`ifdef EN_DDR
        ST_CARD_SEND: begin
            DDMA.valid = DDMA.ready;
            DDMA.req.ctl = DDMA.valid && !len_C && ctl_C;
        end

        ST_SYNC_SEND: begin
            IDMA.valid = IDMA.ready;
            IDMA.req.ctl = IDMA.valid && !len_C && ctl_C;
            IDMA.req.isr = 1'b0;
			unlock_N = IDMA.valid && !len_C;
        end

        ST_ISR_SEND: begin
            IDMA.valid = IDMA.ready;
            IDMA.req.ctl = IDMA.valid && !len_C;
            IDMA.req.isr = 1'b1;
			unlock_N = IDMA.valid && !len_C;
        end

        ST_ISR_WAIT: begin
            vaddr_N = vaddr_miss_C;
            len_N = len_miss_C;
            isr_N = 1'b0;
			lock = IDMA.done && IDMA.isr_return;
        end
`endif

        default: ;

	endcase // state_C
end

assign hitS = hitS_card | hitS_host;
assign hitL = hitL_card | hitL_host;

// Hit/Miss combinational logic
always_comb begin

	//	hitL = 1'b0;
    //	hitS = 1'b0;
    hitS_card = 1'b0;
    hitS_host = 1'b0;
    hitL_card = 1'b0;
    hitL_host = 1'b0;

	hitL_host_idx = 0;
	hitS_host_idx = 0;

	tag_cmp_host_s = 0;
	tag_cmp_host_l = 0;

`ifdef EN_DDR
	hitL_card_idx = 0;
	hitS_card_idx = 0;

	tag_cmp_card_s = 0;
	tag_cmp_card_l = 0;
`endif

	// Small pages
	for (int i = 0; i < N_S_ASSOC; i++) begin
        // tag cmp host
        tag_cmp_host_s[i] = 
			(sTlb.data[i][TAG_S_BITS+TLB_PHY_S_BITS-1:TLB_PHY_S_BITS] == vaddr_C[VADDR_BITS-1:HASH_S_BITS+PG_S_BITS]) && // tag hit
			sTlb.data[i][TLB_DATA_BITS-1] && // valid
            ~sTlb.data[i][TLB_DATA_BITS-2]; // host hit

		if(tag_cmp_host_s[i]) begin
            hitS_host = 1'b1;
            hitS_host_idx = i;
        end

`ifdef EN_DDR
		// tag cmp card
		tag_cmp_card_s[i] = 
			(sTlb.data[i][TAG_S_BITS+TLB_PHY_S_BITS-1:TLB_PHY_S_BITS] == vaddr_C[VADDR_BITS-1:HASH_S_BITS+PG_S_BITS]) && // tag hit
			sTlb.data[i][TLB_DATA_BITS-1] && // valid
            sTlb.data[i][TLB_DATA_BITS-2]; // card hit

        if(tag_cmp_card_s[i]) begin
            hitS_card = 1'b1;
            hitS_card_idx = i;
        end
`endif

	end
	// Large pages
	for (int i = 0; i < N_L_ASSOC; i++) begin
        // tag cmp host
		tag_cmp_host_l[i] = 
			(lTlb.data[i][TAG_L_BITS+PHY_L_BITS-1:PHY_L_BITS] == vaddr_C[VADDR_BITS-1:HASH_L_BITS+PG_L_BITS]) && // tag hit 
			lTlb.data[i][TLB_DATA_BITS-1] && // valid
            ~lTlb.data[i][TLB_DATA_BITS-2]; // host hit

		if(tag_cmp_host_l[i]) begin
            hitL_host = 1'b1;
            hitL_host_idx = i;
        end

`ifdef EN_DDR
		// tag cmp card
		tag_cmp_card_l[i] = 
			(lTlb.data[i][TAG_L_BITS+PHY_L_BITS-1:PHY_L_BITS] == vaddr_C[VADDR_BITS-1:HASH_L_BITS+PG_L_BITS]) && // tag hit 
			lTlb.data[i][TLB_DATA_BITS-1] && // valid
            lTlb.data[i][TLB_DATA_BITS-2]; // card hit
		
		if(tag_cmp_card_l[i]) begin
            hitL_card = 1'b1;
            hitL_card_idx = i;
        end
`endif
        
	end
end

// ILA ******************************************************************
`ifdef DEBUG_TLB_FSM_RD
if(ID_REG == 0) begin
    logic [15:0] cnt_req_in;

    always @( posedge aclk ) begin
        if ( aresetn == 1'b0 ) begin
            cnt_req_in <= 0;
        end
        else begin
            cnt_req_in <= (req_in.valid & req_in.ready) ? cnt_req_in + 1 : cnt_req_in;
        end
     end

    ila_fsm_rd inst_ila_rd (
        .clk(aclk),
        .probe0(state_C),
        .probe1(len_C),
        .probe2(vaddr_C),
        .probe3(sync_C),
        .probe4(0),
        .probe5(data_host_C),
        .probe6(data_card_C),
        .probe7(vaddr_miss_C),
        .probe8(len_miss_C),
        .probe9(isr_C),
        .probe10(unlock_C),
        .probe11(miss_C),
        .probe12(plen_C),
        .probe13(paddr_host_C),
        .probe14(paddr_card_C),
        .probe15(DDMA.valid),
        .probe16(DDMA.ready),
        .probe17(DDMA.req.ctl),
        .probe18(IDMA.valid),
        .probe19(IDMA.ready),
        .probe20(IDMA.req.ctl),
        .probe21(cnt_req_in),
        .probe22(DDMA.done),
        .probe23(IDMA.done),
        .probe24(IDMA.isr_return)
    );
 end
`endif
// **********************************************************************

endmodule
`define EN_STRM
`define EN_BPSS
`define EN_AVX
`define EN_DDR

package lynxTypes;

	// AXI
	parameter integer AXIL_DATA_BITS = 64;
	parameter integer AVX_DATA_BITS = 256;
	parameter integer AXI_DATA_BITS = 512;
	parameter integer AXI_ADDR_BITS = 64;

	// TLB ram
	parameter integer TLB_S_ORDER = 10;
	parameter integer PG_S_BITS = 12;
	parameter integer N_S_ASSOC = 4;

	parameter integer TLB_L_ORDER = 6;
	parameter integer PG_L_BITS = 21;
	parameter integer N_L_ASSOC = 2;

	// Data
	parameter integer ADDR_BITS = 64;
	parameter integer PADDR_BITS = 48; // Changed so I can make accesses to virtual addresses and physical
	parameter integer VADDR_BITS = 48;
	parameter integer LEN_BITS = 28;
	parameter integer TLB_DATA_BITS = 64;

	// Queue depth
	parameter integer QUEUE_DEPTH = 8;
	parameter integer N_OUTSTANDING = 8;

 // Slices
	parameter integer N_REG_HOST_S0 = 2;
	parameter integer N_REG_HOST_S1 = 2;
	parameter integer N_REG_HOST_S2 = 2;
	parameter integer N_REG_CARD_S0 = 2;
	parameter integer N_REG_CARD_S1 = 2;
	parameter integer N_REG_CARD_S2 = 2;

 // Network
	parameter integer FV_REQ_BITS = 256;
	parameter integer PMTU_BITS = 1408;
	
	// Flow
	parameter integer STANDARD_CACHE   = 0;
	parameter integer NO_CACHE         = 1;
	parameter integer CACHE_OVERLAP    = 2;

 // -----------------------------------------------------------------
 // Dynamic
 // -----------------------------------------------------------------

 // Flow
	parameter integer N_DDR_CHAN = 1;
	parameter integer N_CHAN = 2; 
	parameter integer N_REGIONS = 1;
	parameter integer PR_FLOW = 0;
	parameter integer AVX_FLOW = 1;
	parameter integer BPSS_FLOW = 1;
	parameter integer DDR_FLOW = 1;
	parameter integer FV_FLOW = 0;
	parameter integer FV_VERBS = 0;
	parameter integer N_REGIONS_BITS = $clog2(2);
	parameter integer N_REQUEST_BITS = 4;

// ----------------------------------------------------------------------------
// -- Structs
// ----------------------------------------------------------------------------
typedef struct packed {
    logic [5:0] rsrvd_high;
    logic [1:0] cache_mode;
    logic [VADDR_BITS-1:0] vaddr;
    logic [LEN_BITS-1:0] len;
    logic stream;
    logic sync;
    logic ctl;
    logic [3:0] dest;
    logic [12:0] rsrvd;
} req_t;

typedef struct packed {
    logic [VADDR_BITS-1:0] vaddr;
    logic [LEN_BITS-1:0] len;
    logic stream;
    logic sync;
    logic ctl;
    logic [3:0] dest;
    logic [N_REQUEST_BITS-1:0] id;
    logic host;
    logic [7:0] rsrvd;
} rdma_req_t;

typedef struct packed {
    logic [5:0] rsrvd_high;
    logic [1:0] at;
    logic [PADDR_BITS-1:0] paddr;
    logic [LEN_BITS-1:0] len;
    logic ctl;
    logic [3:0] dest;
    logic [14:0] rsrvd;
} dma_req_t;

typedef struct packed {
    logic [PADDR_BITS-1:0] paddr_card;
    logic [PADDR_BITS-1:0] paddr_host;
    logic [LEN_BITS-1:0] len;
    logic ctl;
    logic [3:0] dest;
    logic isr;
    logic [13:0] rsrvd;
} dma_isr_req_t;

typedef struct packed {
    logic miss;
    logic [VADDR_BITS-1:0] vaddr;
    logic [LEN_BITS-1:0] len;
} pf_t;

typedef struct packed {
    logic [N_REGIONS_BITS-1:0] id;
    logic [LEN_BITS-1:0] len;
} mux_t;

endpackage



`timescale 1 ns / 1 ps

module coyote_qdma_tkeep_calc_v1_0
(
    input   wire [5:0]    qdma_mty,
    input   wire          qdma_zero_byte,
    
    output  wire [63:0]   coyote_tkeep
);

    // Will store the tkeep if zer_byte is 1
    reg [63:0] coyote_tkeep_temp;

    // If zero-byte is high than we are not sending any data
    assign coyote_tkeep = coyote_tkeep_temp & ~{64{qdma_zero_byte}};
    
    integer i;
    
    // Setting tkeep based on the number of invalid bytes (mty)
    always@(*) begin
        for(i = 0; i < 64; i = i + 1) begin
            if(i <= (6'd63 - qdma_mty)) begin
                coyote_tkeep_temp[i] <=  1'b1;
            end
            else begin
                coyote_tkeep_temp[i] <= 1'b0;
            end
        end
    end
    
    


endmodule

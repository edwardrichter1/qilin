`timescale 1ns / 1ps
  


module receive_controller(
    input  wire clk,
    input  wire aresetn,
    input  wire arvalid,
    input  wire rready,
    output reg arready,
    output reg rvalid
);

    reg [2:0]   state, state_n;
    reg         arready_n;
    reg         rvalid_n;

    localparam WAIT_STATE = 0, AR_STATE = 1, BRAM_DELAY_STATE_1 = 2, BRAM_DELAY_STATE_2 = 3, R_STATE = 4;


    // Registered Mealy FSM
    always@(*) begin
        case(state)
            WAIT_STATE: begin
                rvalid_n    <= 1'b0;
                if(~arvalid) begin
                    arready_n   <= 1'b0;
                    state_n     <= WAIT_STATE;
                end
                else begin
                    arready_n   <= 1'b1;
                    state_n     <= AR_STATE;
                end

            end

            AR_STATE: begin
                arready_n   <= 1'b0;
                rvalid_n    <= 1'b0;
                state_n     <= BRAM_DELAY_STATE_1;
            end
            
            // Adding this because we added an additional flop on the BRAM to ease timing
            BRAM_DELAY_STATE_1: begin
                arready_n   <= 1'b0;
                rvalid_n    <= 1'b0;
                state_n     <= BRAM_DELAY_STATE_2;
            end
            
            // Adding this because we added an additional flop on the BRAM to ease timing
            BRAM_DELAY_STATE_2: begin
                arready_n   <= 1'b0;
                rvalid_n    <= 1'b1;
                state_n     <= R_STATE;
            end

            R_STATE: begin
                arready_n   <= 1'b0;
                if(~rready) begin
                    rvalid_n    <= 1'b1;
                    state_n     <= R_STATE;
                end
                else begin
                    rvalid_n    <= 1'b0;
                    state_n     <= WAIT_STATE;
                end
            end
            
            default: begin
                arready_n   <= 1'b0;
                rvalid_n    <= 1'b0;
                state_n     <= WAIT_STATE;
            end
        endcase
    end


    always@(posedge clk) begin
        if(~aresetn) begin
            state       <= WAIT_STATE;
            arready     <= 1'b0;
            rvalid      <= 1'b0;
        end
        else begin
            state       <= state_n;
            arready     <= arready_n;
            rvalid      <= rvalid_n;
        end
    end


endmodule
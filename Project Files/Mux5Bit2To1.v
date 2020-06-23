`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - Mux5Bit2To1.v
// Description - Use the sel input signal to choose which 5-bit inputs should be at the output
//              - sel = 1, out = inA
//              - sel = 0, out = inB
////////////////////////////////////////////////////////////////////////////////

module Mux5Bit2To1(out, inA, inB, sel);

    output reg [4:0] out;
    
    input [4:0] inA;
    input [4:0] inB;
    input sel;

    always @(sel, inA, inB) begin
        if (sel == 0) begin
            out <= inB;
        end else begin
            out <= inA;
        end
    end

endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - Mux1Bit2To1.v
// Description - Use the sel input signal to choose which 1-bit inputs should be at the output
//              - sel = 1, out = inA
//              - sel = 0, out = inB
////////////////////////////////////////////////////////////////////////////////

module Mux1Bit2To1(out, inA, inB, sel);

    output reg out;
    
    input inA;
    input inB;
    input sel;

    always @(sel, inA, inB) begin
        if (sel == 0) begin
            out <= inB;
        end else begin
            out <= inA;
        end
    end

endmodule

`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ZeroExtension.v
// Description - Zero extension module.   
//create the 32-bit "out" output by making out[4:0] equal to "in" and make other bits (bits 6 to 31) to 0
////////////////////////////////////////////////////////////////////////////////
module ZeroExtension(in, out);

    /* A 5-Bit input word */
    input [4:0] in;
    
    /* A 32-Bit output word */
    output reg [31:0] out;   //using always @
    
    parameter ZEROES = 27'd0;
    
    always @(in) begin
        out <= {ZEROES, in};
    end

endmodule

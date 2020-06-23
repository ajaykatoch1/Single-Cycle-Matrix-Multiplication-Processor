`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2018 11:46:37 AM
// Design Name: 
// Module Name: AddLeftShift32
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module AddLeftShift32(AddIn, ALSHIn, Out);
    input [31:0] AddIn, ALSHIn;
    output reg [31:0] Out;
    
    always @(AddIn, ALSHIn) begin
        Out <= (ALSHIn << 2) + AddIn;
    end
endmodule

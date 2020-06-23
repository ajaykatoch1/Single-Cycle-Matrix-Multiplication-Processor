`timescale 1ns / 1ps
//`include "E:\ECE_274A_Labs\lab_5\lab_5.srcs\sources_1\new\Datapath.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2018 12:19:21 PM
// Design Name: 
// Module Name: Datapath_tb
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


module Datapath_tb();
    
    reg Clk, Reset;
    wire [31:0] Writedata;
    
    Datapath DUT(Clk, Reset, Writedata);
    
    always begin
        Clk <= 0;
        #10;
        Clk <= 1;
        #10;
    end
    
    initial begin
        Reset <= 1;
        @(posedge Clk);
        #10;
        Reset <= 0;
    end
    
endmodule

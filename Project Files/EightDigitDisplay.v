`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: R. Thamvichai
// 
// Create Date: 09/01/2015 01:15:14 PM
// Design Name: 
// Module Name: TwoDigitDisplay
//////////////////////////////////////////////////////////////////////////////////
module EightDigitDisplay(Clk, Number, out7, en_out);
    input  Clk;
    input  [31:0] Number;
    output [6:0] out7; //seg a, b, ... g
    output reg [7:0] en_out;
             
    reg  [3:0] in4;        
    reg  [3:0] digit [7:0];
    
    //--------- --------- --------- --------- //
    //-- to use the module SevenSegment 
         SevenSegment m1(in4, out7);
    //--------- --------- --------- --------- //
         
    //-- divider counter for ~95.3Hz refresh rate (with 100MHz main clock)
    reg  [19:0] cnt;
    always @(posedge Clk) begin
        cnt <= cnt + 1;
    end
    
    //-- to seperate each decimal digit for display
    always @(Number) begin
            if (Number < 100000000)
                begin
                    digit[0] <= (Number/1)%10;
                    digit[1] <= (Number/10)%10;
                    digit[2] <= (Number/100)%10;
                    digit[3] <= (Number/1000)%10;
                    digit[4] <= (Number/10000)%10;
                    digit[5] <= (Number/100000)%10;
                    digit[6] <= (Number/1000000)%10;
                    digit[7] <= (Number/10000000)%10;
                end 
             else
             begin
                    digit[0] <= 4'b1111;
                    digit[1] <= 4'b1111;
                    digit[2] <= 4'b1111;
                    digit[3] <= 4'b1111;
                    digit[4] <= 4'b1111;
                    digit[5] <= 4'b1111;
                    digit[6] <= 4'b1111;
                    digit[7] <= 4'b1111;
             end
    end
    
    //-- to display the number in the appropriate 7-segment digit
    always @(cnt) begin
        case(cnt[19:17])  //100MHz/(2^20) = 95.3 Hz
            3'b000: begin en_out <= 8'b11111110; in4 <= digit[0]; end
            3'b001: begin en_out <= 8'b11111101; in4 <= digit[1]; end
            3'b010: begin en_out <= 8'b11111011; in4 <= digit[2]; end
            3'b011: begin en_out <= 8'b11110111; in4 <= digit[3]; end
            3'b100: begin en_out <= 8'b11101111; in4 <= digit[4]; end
            3'b101: begin en_out <= 8'b11011111; in4 <= digit[5]; end
            3'b110: begin en_out <= 8'b10111111; in4 <= digit[6]; end
            3'b111: begin en_out <= 8'b01111111; in4 <= digit[7]; end
            default: begin en_out <= 8'b11111111; in4 <= 4'b1111; end
        endcase
     end
     
     
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Arizona
// Engineer: R. Thamvichai
// 
// Create Date: 09/03/2015 09:55:38 AM
// Design Name: 
// Module Name: SevenSegment
// 
// Template for lab 2
//////////////////////////////////////////////////////////////////////////////////

module SevenSegment(numin, segout);
    input	[3:0] numin;
    output	reg [6:0] segout;//segout[6] - seg_a, segout[5] - seg_b, segout[4] - seg_c,
                          //segout[3] - seg_d, segout[2] - seg_e, segout[1] - seg_f, segout[0] - seg_g
    always @(numin)
    begin
	   //segment a
        segout[6] <=    (numin[3]& numin[1]) |(numin[3]& numin[2]) | 
                    (numin[2]& ~numin[1]& ~numin[0]) | (~numin[3]& ~numin[2]& ~numin[1]& numin[0]);
    
        //segment b
        segout[5] <=    (numin[2]& ~numin[1]& numin[0]) | (numin[2]& numin[1]& ~numin[0]) |
            (numin[3]& numin[1]) |(numin[3]& numin[2]);
    
        //segment c
        segout[4] <=    (~numin[2]& numin[1]& ~numin[0]) | (numin[3]& numin[1]) |(numin[3]& numin[2]);
    
        //segment d
        segout[3] <=    (~numin[3]& ~numin[2]& ~numin[1]& numin[0]) | (numin[2]& ~numin[1]& ~numin[0]) |
            (numin[2]& numin[1]& numin[0]) | (numin[3]& numin[1]) |(numin[3]& numin[2]);
    
        //segment e
        segout[2] <=    numin[0] | (numin[2]& ~numin[1]) | (numin[3]& numin[1]);
    
        //segment f
        segout[1] <=    (~numin[2]& numin[1]) | (~numin[3]& ~numin[2]& numin[0]) |
            (numin[3]& numin[1]) |(numin[3]& numin[2]) | (numin[1]& numin[0]);
    
        //segment g
        segout[0] <=    (~numin[3] & ~numin[2]& ~numin[1]) | (numin[2]& numin[1]& numin[0]) |
            (numin[3]& numin[1]) |(numin[3]& numin[2]);
		
    end

endmodule

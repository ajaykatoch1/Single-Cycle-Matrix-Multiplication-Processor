`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: 4-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports a set of arithmetic and 
// logical operaitons. The 'ALUResult' will output the corresponding 
// result of the operation based on the 32-Bit inputs, 'A', and 'B'. 
// The 'Zero' flag is high when 'ALUResult' is '0'. 
// The 'ALUControl' signal determines the function of the ALU based 
// on the table below. 

// Op|'ALUControl' value  | Description | Notes
// ==========================
// ADDITION       | 0000 | ALUResult = A + B
// SUBRACTION     | 0001 | ALUResult = A - B
// MULTIPLICATION | 0010 | ALUResult = A * B        (see notes below)
// AND            | 0011 | ALUResult = A and B
// OR             | 0100 | ALUResult = A or B
// SET LESS THAN  | 0101 | ALUResult =(A < B)? 1:0  (see notes below)
// SET EQUAL      | 0110 | ALUResult =(A=B)  ? 1:0
// SET NOT EQUAL  | 0111 | ALUResult =(A!=B) ? 1:0
// LEFT SHIFT     | 1000 | ALUResult = A << B       (see notes below)
// RIGHT SHIFT    | 1001 | ALUResult = A >> B	    (see notes below)
// ROTATE RIGHT   | 1010 | ALUResult = A ROTR B     (see notes below)
// COUNT ONES     | 1011 | ALUResult = A CLO        (see notes below)
// COUNT ZEROS    | 1100 | ALUResult = A CLZ        (see notes below)
//
// NOTES:-
// MULTIPLICATION : 32-bit signed multiplication results with 64-bit output.
//                  ALUResult will be set to lower 32 bits of the product value. 
//
// SET LESS THAN : ALUResult is '32'h000000001' if A < B.
// 
// LEFT SHIFT: The contents of the 32-bit "A" input are shifted left, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
// RIGHT SHIFT: The contents of the 32-bit "A" input are shifted right, 
//             inserting zeros into the emptied bits by the amount 
//             specified in B.
//
// ROTR: logical right-rotate of a word by a fixed number of bits. 
//       The contents of the 32-bit "A" input are rotated right. 
//       The bit-rotate amount is specified by "B".
//	     ((A >> B) | (A << (32-B)))
//
// CLO: Count the number of leading ones in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
// 
// CLZ: Count the number of leading zeros in a word.
//      Bits 31..0 of the input "A" are scanned from most significant to 
//      least significant bit.  
//
// 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero);
    
	input [3:0] ALUControl; // control bits for ALU operation
	input [31:0] A, B;	    // inputs
    
	output reg [31:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
    
    parameter ADD = 4'b0000, SUB = 4'b0001, MUL = 4'b0010, AND = 4'b0011;
    parameter ORR = 4'b0100, SLT = 4'b0101, SEQ = 4'b0110, SNE = 4'b0111;
    parameter LSH = 4'b1000, RSH = 4'b1001, RTR = 4'b1010, CLO = 4'b1011;
    parameter CLZ = 4'b1100;
    
    reg [31:0] RotTemp1, RotTemp2;
    reg [4:0] RotMag; //0-31 are only unique values
    
    reg CountDone;
    reg signed [5:0] Count;
    
    always @(ALUControl, A, B) begin
        case (ALUControl)
            ADD: begin
                ALUResult = A + B;
            end
            SUB: begin
                ALUResult = A - B;
            end
            MUL: begin
                ALUResult = A * B;
            end
            AND: begin
                ALUResult = A & B;
            end
            ORR: begin
                ALUResult = A | B;
            end
            SLT: begin
                if (A < B) begin
                    ALUResult = 32'd1;
                end else begin
                    ALUResult = 32'd0;
                end
            end
            SEQ: begin
                if (A == B) begin
                    ALUResult = 32'd1;
                end else begin
                    ALUResult = 32'd0;
                end
            end
            SNE: begin
                if (A != B) begin
                    ALUResult = 32'd1;
                end else begin
                    ALUResult = 32'd0;
                end
            end
            LSH: begin
                ALUResult = A << B;
            end
            RSH: begin
                ALUResult = A >> B;
            end
            RTR: begin
                RotMag = B;
                RotTemp1 = A >> RotMag;
                RotTemp2 = A << (5'd32 - RotMag);
                ALUResult = RotTemp1 + RotTemp2;
            end
            CLO: begin
                Count = 6'sd31;
                CountDone = 0;
                while (A[Count] == 1 && !CountDone) begin
                    if (Count <= 0) begin
                        CountDone = 1;
                    end
                    Count = Count - 1;
                end
                ALUResult = 32'sd31 - Count;
            end
            CLZ: begin
                Count = 6'sd31;
                CountDone = 0;
                while (A[Count] == 0 && !CountDone) begin
                    if (Count <= 0) begin
                        CountDone = 1;
                    end
                    Count = Count - 1;
                end
                ALUResult = 32'sd31 - Count;
            end
        endcase
        
        if (ALUResult == 0) begin
            Zero = 1;
        end else begin
            Zero = 0;
        end
    end

endmodule


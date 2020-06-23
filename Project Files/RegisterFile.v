`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//                          (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 
//
// NOTE:-
// We will design the register file such that the contents of registers do not 
// change for a pre-specified time before the falling edge of the clock arrives 
// to allow for data multiplexing and setup time.
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(Reset, ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, debug_Reg19, debug_Reg20, debug_Reg21, debug_Reg22, debug_Reg23);

	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	input [31:0] WriteData;
	input RegWrite, Clk, Reset;
	
	output reg [31:0] ReadData1, ReadData2;
	
	output [31:0] debug_Reg19, debug_Reg20, debug_Reg21, debug_Reg22, debug_Reg23;
	
	parameter MAXADDR = 31; 
	
	(* mark_debug = "true" *) reg [31:0] RegFile [MAXADDR:0];
	reg [31:0] initaddr;
	
	initial begin
	   for (initaddr = 0; initaddr <= MAXADDR; initaddr = initaddr + 1) begin
	       RegFile[initaddr] <= 32'h0;
	   end
	end
	
	always @(negedge Clk) begin
        ReadData1 <= RegFile[ReadRegister1];
        ReadData2 <= RegFile[ReadRegister2];
    end
    
    always @(posedge Clk) begin
        if (Reset) begin
            for (initaddr = 0; initaddr <= MAXADDR; initaddr = initaddr + 1) begin
                RegFile[initaddr] <= 32'h0;
            end
        end
        else if (RegWrite) begin
            RegFile[WriteRegister] <= WriteData;
        end
	end
	
    assign debug_Reg19 = RegFile[19];
    assign debug_Reg20 = RegFile[20];
    assign debug_Reg21 = RegFile[21];
    assign debug_Reg22 = RegFile[22];
    assign debug_Reg23 = RegFile[23];

endmodule

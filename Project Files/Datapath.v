`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2018 11:08:51 AM
// Design Name: 
// Module Name: Datapath
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


module Datapath(ClkIn, Reset, out7, en_out);
    
    input ClkIn, Reset;
    wire [31:0] MuxOut_DataMem;
    
    (* mark_debug = "true" *) wire [31:0] debug_Reg19, debug_Reg20, debug_Reg21, debug_Reg22, debug_Reg23;
    
    wire RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, Zero, ShmtCtrl, PCSrcSrc, Mux6D, Clk;
    wire [3:0] ALUOp;
    wire [4:0] Mux0D, Mux5D;
    wire [31:0] Instruction, ReadData1, ReadData2, ExtInst, Mux1D, Mux2D, Mux4D, ALUResult, MemReadData, PCResult, PCAddResult, ALSHResult, ExtShmt;
    output wire [6:0] out7;
    output wire [7:0] en_out;
    
    ClkDiv              CD      (ClkIn, 0, Clk);
    Controller          Ctrller (Instruction[31:26], Instruction[5:0], RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc, ShmtCtrl, PCSrcSrc);
    ProgramCounter      PgmCtr  (Mux2D, PCResult, Reset, Clk);
    PCAdder             PCAdd   (PCResult, PCAddResult);
    InstructionMemory   InstMem (PCResult, Instruction);
    AddLeftShift32      ALSH    (PCAddResult, ExtInst, ALSHResult);
    Mux5Bit2To1         Mux0    (Mux0D, Instruction[15:11], Instruction[20:16], RegDst);
    Mux32Bit2To1        Mux1    (Mux1D, ExtInst, ReadData2, ALUSrc);
    Mux32Bit2To1        Mux2    (Mux2D, ALSHResult, PCAddResult, Mux6D);
    Mux32Bit2To1        Mux3    (MuxOut_DataMem, MemReadData, ALUResult, MemtoReg);
    Mux32Bit2To1        Mux4    (Mux4D, ExtShmt, Mux1D, ShmtCtrl);
    Mux5Bit2To1         Mux5    (Mux5D, Instruction[20:16], Instruction[25:21], ShmtCtrl);
    Mux1Bit2To1         Mux6    (Mux6D, Zero, PCSrc, PCSrcSrc);
    SignExtension       SE      (Instruction[15:0], ExtInst);
    ZeroExtension       ZE      (Instruction[10:6], ExtShmt);
    RegisterFile        Regs    (Reset, Mux5D, Instruction[20:16], Mux0D, MuxOut_DataMem, RegWrite, Clk, ReadData1, ReadData2, debug_Reg19, debug_Reg20, debug_Reg21, debug_Reg22, debug_Reg23);
    ALU32Bit            ALU     (ALUOp, ReadData1, Mux4D, ALUResult, Zero);
    DataMemory          DataMem (ALUResult, ReadData2, Clk, MemWrite, MemRead, MemReadData);
    EightDigitDisplay   Display (ClkIn, debug_Reg23, out7, en_out);
    
endmodule

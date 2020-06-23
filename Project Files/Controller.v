`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/05/2018 11:18:34 AM
// Design Name: 
// Module Name: Controller
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


module Controller(Opcode, Func, RegDst, RegWrite, ALUSrc, ALUOp, MemRead, MemWrite, MemtoReg, PCSrc, ShmtCtrl, PCSrcSrc);
    
    input [5:0] Opcode, Func;
    output reg RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, ShmtCtrl, PCSrcSrc;
    output reg [3:0] ALUOp;
    
    //ALU Opcodes
    parameter ALU_ADD = 4'b0000, ALU_SUB = 4'b0001, ALU_MUL = 4'b0010, ALU_AND = 4'b0011;
    parameter ALU_ORR = 4'b0100, ALU_SLT = 4'b0101, ALU_SEQ = 4'b0110, ALU_SNE = 4'b0111;
    parameter ALU_LSH = 4'b1000, ALU_RSH = 4'b1001, ALU_RTR = 4'b1010, ALU_CLO = 4'b1011;
    parameter ALU_CLZ = 4'b1100;
    
    always @(Opcode, Func) begin
        case (Opcode)
            6'b000000: begin
                ALUSrc <= 0;
                RegDst <= 1;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0; 
                PCSrc <= 0;
                PCSrcSrc <= 0;
                case (Func)
                    6'b100000: begin
                        ALUOp <= ALU_ADD;
                        ShmtCtrl <= 0;
                    end
                    6'b100010: begin
                        ALUOp <= ALU_SUB;
                        ShmtCtrl <= 0;
                    end
                    6'b100100: begin
                        ALUOp <= ALU_AND;
                        ShmtCtrl <= 0;
                    end
                    6'b100101: begin
                        ALUOp <= ALU_ORR;
                        ShmtCtrl <= 0;
                    end
                    6'b101010: begin
                        ALUOp <= ALU_SLT;
                        ShmtCtrl <= 0;
                    end
                    6'b000000: begin
                        ALUOp <= ALU_LSH;
                        ShmtCtrl <= 1;
                    end
                    6'b000010: begin
                        ALUOp <= ALU_RSH;
                        ShmtCtrl <= 1;
                    end
                    default: begin
                        ALUOp <= 0;
                        ShmtCtrl <= 0;
                    end
                endcase
            end
            6'b011100: begin
                ALUSrc <= 0;
                RegDst <= 1;
                RegWrite <= 1;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0; 
                PCSrc <= 0;
                PCSrcSrc <= 0;
                ShmtCtrl <= 0;
                case (Func)
                    6'b100001: begin
                        ALUOp <= ALU_CLO;
                    end
                    6'b100000: begin
                        ALUOp <= ALU_CLZ;
                    end
                    6'b000010: begin
                        ALUOp <= ALU_MUL;
                    end
                    default: begin
                        ALUOp <= 0;
                    end
                endcase
            end
            6'b001000: begin
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 1;
                ALUOp <= ALU_ADD;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0; 
                PCSrc <= 0;
                PCSrcSrc <= 0;
                ShmtCtrl <= 0;
            end
            6'b001101: begin
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 1;
                ALUOp <= ALU_ORR;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0; 
                PCSrc <= 0;
                PCSrcSrc <= 0;
                ShmtCtrl <= 0;
            end
            6'b000101: begin //bne
                ALUSrc <= 0;
                RegDst <= 0;
                RegWrite <= 0;
                ALUOp <= ALU_SEQ;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0; 
                PCSrc <= 0;
                PCSrcSrc <= 1;
                ShmtCtrl <= 0;
            end
            6'b100011: begin //lw
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 1;
                ALUOp <= ALU_ADD;
                MemRead <= 1;
                MemWrite <= 0;
                MemtoReg <= 1; 
                PCSrc <= 0;
                PCSrcSrc <= 0;
                ShmtCtrl <= 0;
            end
            6'b101011: begin //sw
                ALUSrc <= 1;
                RegDst <= 0;
                RegWrite <= 0;
                ALUOp <= ALU_ADD;
                MemRead <= 0;
                MemWrite <= 1;
                MemtoReg <= 0; 
                PCSrc <= 0;
                PCSrcSrc <= 0;
                ShmtCtrl <= 0;
            end
            default: begin
                ALUSrc <= 0;
                RegDst <= 0;
                RegWrite <= 0;
                ALUOp <= 0;
                MemRead <= 0;
                MemWrite <= 0;
                MemtoReg <= 0; 
                PCSrc <= 0;
                PCSrcSrc <= 0;
                ShmtCtrl <= 0;
            end
        endcase
    end
    
endmodule

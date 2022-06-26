`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 15:30:25
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0]A,
    input [31:0]B,
    input [3:0]ALU_operation,
    output reg[31:0]res,
    output zero
);
       
    always @(*)
        case(ALU_operation)
        4'b0000: res = A & B;
        4'b0001: res = A | B;
        4'b0010: res = A + B;
        4'b1100: res = A ^ B;//xor
        4'b0100: res = ~(A | B);
        4'b1101: res = A >> B[4:0];//srl
        4'b0110: res = A - B;
        4'b0111: if(A[31] == 0 && B[31] == 1)begin
                     res = 32'b0;
                 end
                 else if(A[31] == 1 && B[31] == 0)begin
                     res = 32'b1;
                 end
                 else if(A[30:0] < B[30:0])begin
                     res = 32'b1;
                 end
                 else begin
                     res = 32'b0;
                 end
        4'b1001: res = (A < B)? 32'b1: 32'b0;//sltu        
        4'b1110: res = A << B[4:0];//sll
        4'b1111: res = (A >> B[4:00]) + ({32{A[31]}} << (32 - B[4:0]));//sra
        endcase
    assign zero = (res == 0)?1:0;
endmodule

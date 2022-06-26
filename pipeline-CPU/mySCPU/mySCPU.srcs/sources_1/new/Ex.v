`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 21:51:11
// Design Name: 
// Module Name: Ex
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


module Ex(
    input [31:0]PC_in_EX,
    input [31:0]Rs1_in_EX,
    input [31:0]Rs2_in_EX,
    input [31:0]Imm_in_EX,
    input ALUSrc_A_in_EX,
    input ALUSrc_B_in_EX,
    input [3:0]ALU_control_in_EX,
    output [31:0]PC4_out_EX,
    output [31:0]PC_out_EX,
    output [31:0]ALU_out_EX,
    output zero_out_EX
);
    wire [31:0] A;
    wire [31:0] B;
    assign A = ALUSrc_A_in_EX? PC_in_EX: Rs1_in_EX;
    assign B = ALUSrc_B_in_EX? Imm_in_EX: Rs2_in_EX;
    ALU U1(
        .A(A),
        .B(B),
        .ALU_operation(ALU_control_in_EX),
        .res(ALU_out_EX),
        .zero(zero_out_EX)
    );
    assign PC4_out_EX = PC_in_EX + 32'b100;
    assign PC_out_EX = PC_in_EX + Imm_in_EX;
endmodule

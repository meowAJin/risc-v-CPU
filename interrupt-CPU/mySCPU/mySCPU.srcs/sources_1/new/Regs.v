`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 15:31:36
// Design Name: 
// Module Name: Regs
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


module Regs(
    input clk, rst, RegWrite,
    input [4:0] Wt_addr, Rs1_addr, Rs2_addr,
    input [31:0] Wt_data,
    output [31:0] Rs1_data, Rs2_data,
    output [31:0] R1,
    output [31:0] R2,
    output [31:0] R3,
    output [31:0] R4,
    output [31:0] R5,
    output [31:0] R6,
    output [31:0] R7,
    output [31:0] R8,
    output [31:0] R9,
    output [31:0] R10,
    output [31:0] R11,
    output [31:0] R12,
    output [31:0] R13,
    output [31:0] R14,
    output [31:0] R15,
    output [31:0] R16,
    output [31:0] R17,
    output [31:0] R18,
    output [31:0] R19,
    output [31:0] R20,
    output [31:0] R21,
    output [31:0] R22,
    output [31:0] R23,
    output [31:0] R24,
    output [31:0] R25,
    output [31:0] R26,
    output [31:0] R27,
    output [31:0] R28,
    output [31:0] R29,
    output [31:0] R30,
    output [31:0] R31
    );
    reg [31:0] register [1:31]; // r1 - r31
    
    assign R1 = register[1];
    assign R2 = register[2];
    assign R3 = register[3];
    assign R4 = register[4];   
    assign R5 = register[5];
    assign R6 = register[6];
    assign R7 = register[7];
    assign R8 = register[8];
    assign R9 = register[9];
    assign R10 = register[10];
    assign R11 = register[11];
    assign R12 = register[12];   
    assign R13 = register[13];
    assign R14 = register[14];
    assign R15 = register[15];
    assign R16 = register[16];
    assign R17 = register[17];
    assign R18 = register[18];
    assign R19 = register[19];
    assign R20 = register[20];   
    assign R21 = register[21];
    assign R22 = register[22];
    assign R23 = register[23];
    assign R24 = register[24];
    assign R25 = register[25];
    assign R26 = register[26];
    assign R27 = register[27];
    assign R28 = register[28];   
    assign R29 = register[29];
    assign R30 = register[30];
    assign R31 = register[31];
    
    assign Rs1_data = (Rs1_addr == 0) ? 0 : register[Rs1_addr];
    assign Rs2_data = (Rs2_addr == 0) ? 0 : register[Rs2_addr];
    
    integer i;
    always @(posedge clk or posedge rst) begin
        if (rst==1)
            for (i=1; i<32; i=i+1) register[i] <= 0; // reset
        else if ((Wt_addr != 0) && (RegWrite == 1)) 
            register[Wt_addr] <= Wt_data; // write
    end
endmodule
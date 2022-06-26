`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 11:21:35
// Design Name: 
// Module Name: ExMem
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


module ExMem(
    input clk_EXMem,
    input rst_EXMem,
    input en_EXMem,
    input [31:0]PC_in_EXMem,
    input [31:0]PC4_in_EXMem,
    input [4:0]Rd_addr_in_EXMem,
    input zero_in_EXMem,
    input [31:0]ALU_in_EXMem,
    input [31:0]Rs2_in_EXMem,
    input Branch_in_EXMem,
    input Branch_condition_in_EXMem,
    input MemRW_in_EXMem,
    input Jump_in_EXMem,
    input JumpR_in_EXMem,
    input [1:0]MemtoReg_in_EXMem,
    input RegWrite_in_EXMem,
    input is_lui_in_EXMem,
    input [2:0]loadstore_condition_in_EXMem,
    input [31:0]Imm_in_EXMem,
    
    output reg [31:0]PC_out_EXMem,
    output reg [31:0]PC4_out_EXMem,
    output reg [4:0]Rd_addr_out_EXMem,
    output reg zero_out_EXMem,
    output reg [31:0]ALU_out_EXMem,
    output reg [31:0]Rs2_out_EXMem,
    output reg Branch_out_EXMem,
    output reg Branch_condition_out_EXMem,
    output reg MemRW_out_EXMem,
    output reg Jump_out_EXMem,
    output reg JumpR_out_EXMem,
    output reg [1:0]MemtoReg_out_EXMem,
    output reg RegWrite_out_EXMem,
    output reg is_lui_out_EXMem,
    output reg [2:0]loadstore_condition_out_EXMem,
    output reg [31:0]Imm_out_EXMem
);
    always @(negedge clk_EXMem or posedge rst_EXMem)begin
        if(rst_EXMem)begin
            PC_out_EXMem <= 32'b0;
            PC4_out_EXMem <= 32'b0;
            Rd_addr_out_EXMem <= 5'b0;
            zero_out_EXMem <= 1'b0;
            ALU_out_EXMem <= 32'b0;
            Rs2_out_EXMem <= 32'b0;
            Branch_out_EXMem <= 1'b0;
            Branch_condition_out_EXMem <= 1'b0;
            MemRW_out_EXMem <= 1'b0;
            Jump_out_EXMem <= 1'b0;
            JumpR_out_EXMem <= 1'b0;
            MemtoReg_out_EXMem <= 2'b0;
            RegWrite_out_EXMem <= 1'b0;
            is_lui_out_EXMem <= 1'b0;
            loadstore_condition_out_EXMem <= 3'b0;
            Imm_out_EXMem <= 32'b0;
        end
        else begin
            PC_out_EXMem <= PC_in_EXMem;
            PC4_out_EXMem <=  PC4_in_EXMem;
            Rd_addr_out_EXMem <= Rd_addr_in_EXMem;
            zero_out_EXMem <= zero_in_EXMem;
            ALU_out_EXMem <= ALU_in_EXMem;
            Rs2_out_EXMem <= Rs2_in_EXMem;
            Branch_out_EXMem <= Branch_in_EXMem;
            Branch_condition_out_EXMem <= Branch_condition_in_EXMem;
            MemRW_out_EXMem <= MemRW_in_EXMem;
            Jump_out_EXMem <= Jump_in_EXMem;
            JumpR_out_EXMem <= JumpR_in_EXMem;
            MemtoReg_out_EXMem <= MemtoReg_in_EXMem;
            RegWrite_out_EXMem <= RegWrite_in_EXMem;
            is_lui_out_EXMem <= is_lui_in_EXMem;
            loadstore_condition_out_EXMem <= loadstore_condition_in_EXMem;
            Imm_out_EXMem <= Imm_in_EXMem;
        end
    end
endmodule

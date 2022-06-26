`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 16:43:59
// Design Name: 
// Module Name: IDEx
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


module IDEx(
    input clk_IDEX,
    input rst_IDEX,
    input NOP_IDEX,
    input en_IDEX,
    input [31:0]PC_in_IDEX,
    input [4:0]Rd_addr_in_IDEX,
    input [31:0]Rs1_in_IDEX,
    input [31:0]Rs2_in_IDEX,
    input [31:0]Imm_in_IDEX,
    input ALUSrc_B_in_IDEX,
    input [3:0]ALU_control_in_IDEX,
    input Branch_in_IDEX,
    input Branch_condition_in_IDEX,
    input MemRW_in_IDEX,
    input Jump_in_IDEX,
    input JumpR_in_IDEX,
    input [1:0]MemtoReg_in_IDEX,
    input RegWrite_in_IDEX,
    input is_auipc_in_IDEX,
    input is_lui_in_IDEX,
    input [2:0]loadstore_condition_in_IDEX,
    output reg [31:0]PC_out_IDEX,
    output reg [4:0]Rd_addr_out_IDEX,
    output reg [31:0]Rs1_out_IDEX,
    output reg [31:0]Rs2_out_IDEX,
    output reg [31:0]Imm_out_IDEX,
    output reg ALUSrc_B_out_IDEX,
    output reg [3:0]ALU_control_out_IDEX,
    output reg Branch_out_IDEX,
    output reg Branch_condition_out_IDEX,
    output reg MemRW_out_IDEX,
    output reg Jump_out_IDEX,
    output reg JumpR_out_IDEX,
    output reg [1:0]MemtoReg_out_IDEX,
    output reg RegWrite_out_IDEX,
    output reg is_auipc_out_IDEX,
    output reg is_lui_out_IDEX,
    output reg [2:0]loadstore_condition_out_IDEX
);
    always @(negedge clk_IDEX or posedge rst_IDEX)begin
        if(rst_IDEX | NOP_IDEX)begin
            PC_out_IDEX <= 32'b0;
            Rd_addr_out_IDEX <= 5'b0;
            Rs1_out_IDEX <= 32'b0;
            Rs2_out_IDEX <= 32'b0;
            Imm_out_IDEX <= 32'b0;
            ALUSrc_B_out_IDEX <= 1'b0;
            ALU_control_out_IDEX <= 4'b0;
            Branch_out_IDEX <= 1'b0;
            Branch_condition_out_IDEX <= 1'b0;
            MemRW_out_IDEX <= 1'b0;
            Jump_out_IDEX <= 1'b0;
            JumpR_out_IDEX <= 1'b0;
            MemtoReg_out_IDEX <= 2'b0;
            RegWrite_out_IDEX <= 1'b0;
            is_auipc_out_IDEX <= 1'b0;
            is_lui_out_IDEX <= 1'b0;
            loadstore_condition_out_IDEX <= 3'b0;
        end
        else begin
            PC_out_IDEX <= PC_in_IDEX;
            Rd_addr_out_IDEX <= Rd_addr_in_IDEX;
            Rs1_out_IDEX <= Rs1_in_IDEX;
            Rs2_out_IDEX <= Rs2_in_IDEX;
            Imm_out_IDEX <= Imm_in_IDEX;
            ALUSrc_B_out_IDEX <= ALUSrc_B_in_IDEX;
            ALU_control_out_IDEX <= ALU_control_in_IDEX;
            Branch_out_IDEX <= Branch_in_IDEX;
            Branch_condition_out_IDEX <= Branch_condition_in_IDEX;
            MemRW_out_IDEX <= MemRW_in_IDEX;
            Jump_out_IDEX <= Jump_in_IDEX;
            JumpR_out_IDEX <= JumpR_in_IDEX;
            MemtoReg_out_IDEX <= MemtoReg_in_IDEX;
            RegWrite_out_IDEX <= RegWrite_in_IDEX;
            is_auipc_out_IDEX <= is_auipc_in_IDEX;
            is_lui_out_IDEX <= is_lui_in_IDEX;
            loadstore_condition_out_IDEX <= loadstore_condition_in_IDEX;
        end
    end
endmodule

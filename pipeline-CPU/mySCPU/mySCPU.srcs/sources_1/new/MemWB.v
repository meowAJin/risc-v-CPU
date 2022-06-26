`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 17:04:42
// Design Name: 
// Module Name: MemWB
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


module MemWB(
    input clk_MemWB,
    input rst_MemWB,
    input en_MemWB,
    input [31:0]ALU_in_MemWB,
    input [31:0]DMem_data_in_MemWB,
    input [31:0]PC4_in_MemWB,
    input [31:0]Imm_in_MemWB,
    input [1:0]MemtoReg_in_MemWB,
    input [4:0]Rd_addr_in_MemWB,
    input RegWrite_in_MemWB,
    
    output reg [31:0]ALU_out_MemWB,
    output reg [31:0]DMem_data_out_MemWB,
    output reg [31:0]PC4_out_MemWB,
    output reg [31:0]Imm_out_MemWB,
    output reg [1:0]MemtoReg_out_MemWB,
    output reg [4:0]Rd_addr_out_MemWB,
    output reg RegWrite_out_MemWB
);
    always @(negedge clk_MemWB or posedge rst_MemWB)begin
        if(rst_MemWB)begin
            ALU_out_MemWB <= 32'b0;
            DMem_data_out_MemWB <= 32'b0;
            PC4_out_MemWB <= 32'b0;
            Imm_out_MemWB <= 32'b0;
            MemtoReg_out_MemWB <= 2'b0;
            Rd_addr_out_MemWB <= 5'b0;
            RegWrite_out_MemWB <= 1'b0;
        end
        else begin
            ALU_out_MemWB <= ALU_in_MemWB;
            DMem_data_out_MemWB <= DMem_data_in_MemWB;
            PC4_out_MemWB <= PC4_in_MemWB;
            Imm_out_MemWB <= Imm_in_MemWB;
            MemtoReg_out_MemWB <= MemtoReg_in_MemWB;
            Rd_addr_out_MemWB <= Rd_addr_in_MemWB;
            RegWrite_out_MemWB <= RegWrite_in_MemWB;
        end
    end
endmodule

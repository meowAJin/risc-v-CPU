`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 14:08:52
// Design Name: 
// Module Name: Mem
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


module Mem(
    input zero_in_Mem,
    input Branch_in_Mem,
    input Branch_condition_in_Mem,
    input Jump_in_Mem,
    input JumpR_in_Mem,
    input [1:0]BYTE_in_Mem,
    input [31:0]DMem_data_in_Mem,
    input [31:0]Rs2_in_Mem,
    input [2:0]loadstore_condition_in_Mem,
    input MemRW_in_Mem,
    output [31:0]Rs2_out_Mem,
    output [31:0]DMem_data_out_Mem,
    output [1:0]PCSrc_out_Mem,
    output [3:0]wea_out_Mem
);
    assign PCSrc_out_Mem[1] = JumpR_in_Mem? 1'b1: 1'b0; 
    assign PCSrc_out_Mem[0] = Branch_in_Mem & !(Branch_condition_in_Mem ^ zero_in_Mem) | Jump_in_Mem;
    READMUX U1(
        .BYTE(BYTE_in_Mem),
        .load_condition(loadstore_condition_in_Mem),
        .Data_in(DMem_data_in_Mem),
        .read_data(DMem_data_out_Mem)
    );
    WEAMUX U2(
        .Data_out_in(Rs2_in_Mem),
        .BYTE(BYTE_in_Mem),
        .MemRW(MemRW_in_Mem),
        .store_condition(loadstore_condition_in_Mem[1:0]),
        .wea(wea_out_Mem),
        .Data_out(Rs2_out_Mem)
    );
endmodule

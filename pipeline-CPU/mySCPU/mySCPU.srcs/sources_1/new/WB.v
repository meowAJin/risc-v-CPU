`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/23 19:46:39
// Design Name: 
// Module Name: WB
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


module WB(
    input [31:0]ALU_in_WB,
    input [31:0]DMem_data_in_WB,
    input [31:0]PC4_in_WB,
    input [31:0]Imm_in_WB,
    input [1:0]MemtoReg_in_WB,
    output [31:0]Data_out_WB
);
    MUX4T1 U1(
        .I0(ALU_in_WB),
        .I1(DMem_data_in_WB),
        .I2(PC4_in_WB),
        .I3(Imm_in_WB),
        .s(MemtoReg_in_WB),
        .o(Data_out_WB)
    );
endmodule

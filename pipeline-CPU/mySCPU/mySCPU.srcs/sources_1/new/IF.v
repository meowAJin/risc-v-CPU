`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 12:31:08
// Design Name: 
// Module Name: IF
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


module IF(
    input clk_IF,
    input rst_IF,
    input en_IF,
    input [31:0]PC1_in_IF,
    input [31:0]PC2_in_IF,
    input [1:0]PCSrc_in_IF,
    output [31:0]PC_out_IF
);
    wire [31:0]PCout;
    MUX4T1 U1(
        .s(PCSrc_in_IF),
        .I0(PC_out_IF + 32'b100),
        .I1(PC1_in_IF),
        .I2(PC2_in_IF),
        .o(PCout)
    );
    PC U2(
        .clk(clk_IF),
        .rst(rst_IF),
        .CE(en_IF),
        .D(PCout),
        .Q(PC_out_IF)
    );
endmodule

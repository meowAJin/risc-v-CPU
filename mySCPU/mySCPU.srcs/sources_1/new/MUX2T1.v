`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 15:29:17
// Design Name: 
// Module Name: MUX2T1
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


module MUX2T1(
    input s,
    input[31:0] I0,
    input[31:0] I1,
    output[31:0] o
);
    assign o = (s == 1'b0)? I0: I1;
endmodule


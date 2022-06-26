`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 03:31:08
// Design Name: 
// Module Name: PC
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


module PC(
    input clk,
    input rst,
    input CE,
    input[31:0] D,
    output reg[31:0] Q
);
    always @(posedge clk or posedge rst)begin
        if(rst) Q <= 32'b0;
        else if(CE == 1'b0) Q <= Q;
        else Q <= D;
    end
endmodule

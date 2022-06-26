`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/21 23:20:27
// Design Name: 
// Module Name: IFID
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 16:26:57
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


module IFID(
    input clk_IFID,
    input rst_IFID,
    input en_IFID,
    input NOP_IFID,
    input [31:0]PC_in_IFID,
    input [31:0]inst_in_IFID,
    output reg [31:0]PC_out_IFID,
    output reg [31:0]inst_out_IFID
);
    always @(negedge clk_IFID or posedge rst_IFID)begin
        if(rst_IFID)begin
            PC_out_IFID <= 32'b0;
            inst_out_IFID <= 32'b0;
        end
        else if(en_IFID == 1'b0)begin
            PC_out_IFID <= PC_out_IFID;
            inst_out_IFID <= inst_out_IFID;
        end
        else if(NOP_IFID)begin
            PC_out_IFID <= PC_out_IFID;
            inst_out_IFID <= 32'h00000033;
        end
        else begin
            PC_out_IFID <= PC_in_IFID;
            inst_out_IFID <= inst_in_IFID;
        end
    end
endmodule


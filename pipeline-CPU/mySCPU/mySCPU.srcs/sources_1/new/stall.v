`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/31 16:51:16
// Design Name: 
// Module Name: stall
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


module stall(
    input rst_stall,
    /***/
    input [4:0]OPcode_out_IFID,
    input [4:0]Rs1_addr_out_IFID,
    input [4:0]Rs2_addr_out_IFID,
    input RegWrite_out_IDEX,
    input [4:0]Rd_addr_out_IDEX,
    input RegWrite_out_EXMem,
    input [4:0]Rd_addr_out_EXMem,
    input RegWrite_out_MemWB,
    input [4:0]Rd_addr_out_MemWB,
    /***/
    input Branch_out_ID,
    input JumpR_out_ID,
    input Jump_out_ID,
    input Branch_out_IDEX,
    input JumpR_out_IDEX,
    input Jump_out_IDEX,
    /***/
    output reg en_IF,//0 pc<=pc 1 pc<=pc+4
    output reg en_IFID,//0 output<=output 1 output<=input 
    output reg NOP_IDEX,//1 MemRW<=0 RegWrite<=0 branch<=0 jump<=0 jumpr<=0
    output reg NOP_IFID//1 out_inst<=in_inst 1 out_inst<=add x0,x0,x0
);
    wire Rs1_used = (OPcode_out_IFID == 5'b01100) || (OPcode_out_IFID == 5'b00100) || (OPcode_out_IFID == 5'b00000) || (OPcode_out_IFID == 5'b01000) || (OPcode_out_IFID == 5'b11000) || (OPcode_out_IFID == 5'b11001);
    wire Rs2_used = (OPcode_out_IFID == 5'b01100) || (OPcode_out_IFID == 5'b01000) || (OPcode_out_IFID == 5'b11000);
    always@* begin
        if(rst_stall)begin
            en_IF <= 1'b1;
            en_IFID <= 1'b1;
            NOP_IFID <= 1'b0;
            NOP_IDEX <= 1'b0;
        end
        else begin
            if((RegWrite_out_IDEX && Rd_addr_out_IDEX && (Rs1_addr_out_IFID == Rd_addr_out_IDEX && Rs1_used || Rs2_addr_out_IFID == Rd_addr_out_IDEX && Rs2_used)) || (RegWrite_out_EXMem == 1'b1 && Rd_addr_out_EXMem && (Rs1_addr_out_IFID == Rd_addr_out_EXMem && Rs1_used || Rs2_addr_out_IFID == Rd_addr_out_EXMem && Rs2_used)) || (RegWrite_out_MemWB == 1'b1 && Rd_addr_out_MemWB && (Rs1_addr_out_IFID == Rd_addr_out_MemWB && Rs1_used || Rs2_addr_out_IFID == Rd_addr_out_MemWB && Rs2_used)))begin
                en_IF <= 1'b0;//
                en_IFID <= 1'b0;//
                NOP_IFID <= 1'b0;
                NOP_IDEX <= 1'b1;//
            end
            else if(Branch_out_ID == 1'b1 || JumpR_out_ID == 1'b1 || Jump_out_ID == 1'b1 || Branch_out_IDEX == 1'b1 || JumpR_out_IDEX == 1'b1 || Jump_out_IDEX == 1'b1)begin
                en_IF <= 1'b0;//
                en_IFID <= 1'b1;
                NOP_IFID <= 1'b1;//
                NOP_IDEX <= 1'b0;
            end
            else begin
                en_IF <= 1'b1;
                en_IFID <= 1'b1;
                NOP_IFID <= 1'b0;
                NOP_IDEX <= 1'b0;
            end
        end
    end
endmodule

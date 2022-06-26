`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/22 14:57:55
// Design Name: 
// Module Name: ID
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


module ID(
    input clk_ID,
    input rst_ID,
    input RegWrite_in_ID,
    input [4:0]Rd_addr_in_ID,
    input [31:0]Wt_data_in_ID,
    input [31:0]Inst_in_ID,
    output [31:0]Rd_addr_out_ID,
    output [31:0]Rs1_out_ID,
    output [31:0]Rs2_out_ID,
    output [31:0]Imm_out_ID,
    output ALUSrc_B_out_ID,
    output [3:0]ALU_control_out_ID,
    output Branch_out_ID,
    output Branch_condition_out_ID,
    output MemRW_out_ID,
    output Jump_out_ID,
    output JumpR_out_ID,
    output [1:0]MemtoReg_out_ID,
    output RegWrite_out_ID,
    output is_auipc_out_ID,
    output is_lui_out_ID,
    output [2:0]loadstore_condition_out_ID,
    output [31:0]R1,
    output [31:0]R2,
    output [31:0]R3,
    output [31:0]R4,
    output [31:0]R5,
    output [31:0]R6,
    output [31:0]R7,
    output [31:0]R8,
    output [31:0]R9,
    output [31:0]R10,
    output [31:0]R11,
    output [31:0]R12,
    output [31:0]R13,
    output [31:0]R14,
    output [31:0]R15,
    output [31:0]R16,
    output [31:0]R17,
    output [31:0]R18,
    output [31:0]R19,
    output [31:0]R20,
    output [31:0]R21,
    output [31:0]R22,
    output [31:0]R23,
    output [31:0]R24,
    output [31:0]R25,
    output [31:0]R26,
    output [31:0]R27,
    output [31:0]R28,
    output [31:0]R29,
    output [31:0]R30,
    output [31:0]R31
);
    assign Rd_addr_out_ID = Inst_in_ID[11:7];
    wire [2:0]ImmSel;
    myctrl U1(
        .ecallebreak(Inst_in_ID[20]),
        .srlisrai(Inst_in_ID[30]),
        .OPcode(Inst_in_ID[6:2]),
        .Fun3(Inst_in_ID[14:12]),
        .Fun7(Inst_in_ID[30]),
        
        .ImmSel(ImmSel),
        .ALUSrc_B(ALUSrc_B_out_ID),
        .MemtoReg(MemtoReg_out_ID),
        .Jump(Jump_out_ID),
        .JumpR(JumpR_out_ID),
        .Branch(Branch_out_ID),
        .branch_condition(Branch_condition_out_ID),
        .RegWrite(RegWrite_out_ID),
        .MemRW(MemRW_out_ID),
        .ALU_Control(ALU_control_out_ID),
        .loadstore_condition(loadstore_condition_out_ID),
        .is_auipc(is_auipc_out_ID),
        .is_lui(is_lui_out_ID)
    );
    ImmGen U2(
        .ImmSel(ImmSel),
        .inst_field(Inst_in_ID),
        
        .Imm_out(Imm_out_ID)
    );
    Regs U3(
        .clk(clk_ID),
        .rst(rst_ID),
        .Rs1_addr(Inst_in_ID[19:15]),
        .Rs2_addr(Inst_in_ID[24:20]),
        .Wt_addr(Rd_addr_in_ID),
        .Wt_data(Wt_data_in_ID),
        .RegWrite(RegWrite_in_ID),
        
        .Rs1_data(Rs1_out_ID),
        .Rs2_data(Rs2_out_ID),
        .R1(R1),
        .R2(R2),
        .R3(R3),
        .R4(R4),
        .R5(R5),
        .R6(R6),
        .R7(R7),
        .R8(R8),
        .R9(R9),
        .R10(R10),
        .R11(R11),
        .R12(R12),
        .R13(R13),
        .R14(R14),
        .R15(R15),
        .R16(R16),
        .R17(R17),
        .R18(R18),
        .R19(R19),
        .R20(R20),
        .R21(R21),
        .R22(R22),
        .R23(R23),
        .R24(R24),
        .R25(R25),
        .R26(R26),
        .R27(R27),
        .R28(R28),
        .R29(R29),
        .R30(R30),
        .R31(R31)
    );
endmodule

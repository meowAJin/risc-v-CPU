`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 15:25:40
// Design Name: 
// Module Name: mypath
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


module mypath(
    input MemRW,//
    input Branch,
    input branch_condition,
    input Jump,
    input JumpR,
    input[31:0] Data_in,//dmem_o_data
    input[2:0] loadstore_condition,
    input[1:0] MemtoReg,
    input ALUSrc_B,
    input[2:0] ImmSel,
    input[31:0] inst_field,
    input[3:0] ALU_Control,
    input RegWrite,
    input clk,
    input rst,
    input is_auipc,
    input is_lui,
    output [31:0]ALU_out,//dmem_addr //alu_res
    output [31:0]Data_out,
    output [31:0]PC_out,

    output [31:0]Addr_out,//*************************************
    output [4:0]rs1,//rs1
    output [4:0]rs2,//rs2
    output [4:0]rd,//rd
    output [31:0]Rs1_data,//rs1_val
    output [31:0]Rs2_data,//rs2_val
    output [3:0]wea,//*****************************************************
    output [31:0]Wt_data,//reg_i_data
    output [31:0]Imm_out,//imm
    output [31:0]op1,//a_val
    output [31:0]op2,//b_val
    output do_branch,//do_branch
    output [31:0]pc_branch,//pc_branch
    
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
    wire zero;
    wire[31:0] branch_out;
    wire[31:0] jump_out;
    wire[31:0] jumpr_out;
    wire CE;
    wire[31:0] load_res;
    
    assign Addr_out = ALU_out;
    ImmGen ImmGenerator(
        .ImmSel(ImmSel),
        .inst_field(inst_field),
        .Imm_out(Imm_out)
    );
    
    assign do_branch = (branch_condition == 1'b1)? Branch & zero: Branch & ~zero;
    assign pc_branch = PC_out + Imm_out;
    MUX2T1 ifbranch(
        .I0(PC_out + 32'b100),
        .I1(pc_branch),
        .s(do_branch),
        .o(branch_out)
    );
    
    MUX2T1 ifjump(
        .I0(branch_out),
        .I1(pc_branch),
        .s(Jump),
        .o(jump_out)
    );
    
    MUX2T1 ifjumpr(
        .I0(jump_out),
        .I1(ALU_out),
        .s(JumpR),
        .o(jumpr_out)
    );
    
    MUX4T1 memory_to_register(
        .s(MemtoReg),
        .I0(ALU_out),
        .I1(load_res),
        .I2(PC_out + 32'b100),
        .I3(Imm_out),
        .o(Wt_data)
    );
    
    READMUX loadmux(
        .BYTE(Addr_out[1:0]),
        .load_condition(loadstore_condition),
        .Data_in(Data_in),
        .read_data(load_res)
    );
    
    WEAMUX storemux(
        .Data_out_in(Rs2_data),
        .BYTE(Addr_out[1:0]),
        .MemRW(MemRW),
        .store_condition(loadstore_condition[1:0]),
        .wea(wea),
        .Data_out(Data_out)
    );
    
    MUX2T1 operand1(
        .I0(Rs1_data),
        .I1(PC_out),
        .s(is_auipc),
        .o(op1)
    );

    MUX2T1 operand2(
        .I0(Rs2_data),
        .I1(Imm_out),
        .s(ALUSrc_B),
        .o(op2)
    );
    
    ALU ALU_U(
        .A(op1),
        .B(op2),
        .ALU_operation(ALU_Control),
        .res(ALU_out),
        .zero(zero)
    );
    
    assign CE = 1'b1;
    PC PCout(
        .clk(clk),
        .rst(rst),
        .CE(CE),
        .D(jumpr_out),
        .Q(PC_out)
    );
    
    assign rs1 = inst_field[19:15];
    assign rs2 = inst_field[24:20];
    assign rd = inst_field[11:7];
    
    Regs Register(
        .clk(clk),
        .rst(rst),
        .Rs1_addr(rs1),
        .Rs2_addr(rs2),
        .Wt_addr(rd),
        .Wt_data(Wt_data),
        .RegWrite(RegWrite),
        .Rs1_data(Rs1_data),
        .Rs2_data(Rs2_data),
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


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 15:24:18
// Design Name: 
// Module Name: mySCPU
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


module mySCPU(
    input INT0,
    input clk,
    input rst,
    input MIO_ready,
    input[31:0] inst_in,
    input[31:0] Data_in,
    output CPU_MIO,
    output MemRW,           //mem_wen
    output[3:0] wea,        //*****************************************************************
    output[31:0] PC_out,    //pc
    output[31:0] Data_out,
    output[31:0] Addr_out,  //dmem_addr dmem_i_data和dmem_o_data的输入不直接来自CPU
    
    output[4:0] rs1,
    output[4:0] rs2,
    output[4:0] rd,
    output[31:0] rs1_val,
    output[31:0] rs2_val,
    output[31:0] reg_i_data,
    output reg_wen,
    output is_imm,
    output is_auipc,
    output is_lui,
    output[31:0] imm,
    output[31:0] a_val,
    output[31:0] b_val,
    output[3:0] alu_ctrl,
    output[2:0] cmp_ctrl,//暂时为空 不知道用法 位数未定
    output[31:0] alu_res,
    output cmp_res, //暂时为空 不知道用法 位数未定
    output is_branch,
    output is_jal,
    output is_jalr, 
    output do_branch,
    output[31:0] pc_branch,
    output mem_ren, //暂时为空
    
    output [31:0] R1,
    output [31:0] R2,
    output [31:0] R3,
    output [31:0] R4,
    output [31:0] R5,
    output [31:0] R6,
    output [31:0] R7,
    output [31:0] R8,
    output [31:0] R9,
    output [31:0] R10,
    output [31:0] R11,
    output [31:0] R12,
    output [31:0] R13,
    output [31:0] R14,
    output [31:0] R15,
    output [31:0] R16,
    output [31:0] R17,
    output [31:0] R18,
    output [31:0] R19,
    output [31:0] R20,
    output [31:0] R21,
    output [31:0] R22,
    output [31:0] R23,
    output [31:0] R24,
    output [31:0] R25,
    output [31:0] R26,
    output [31:0] R27,
    output [31:0] R28,
    output [31:0] R29,
    output [31:0] R30,
    output [31:0] R31,
    
    output [31:0]mtvec,
    output [31:0]mcause,
    output [31:0]mepc,
    output [31:0]mtval,
    output [31:0]mie,
    output ecall,
    output mret,
    output ill_instr
);
    wire[2:0] ImmSel;
    wire[1:0] MemtoReg;
    wire branch_condition;
    wire[2:0] loadstore_condition;

    
    myctrl U1(
        .ecallmret(inst_in[29]),
        .srlisrai(inst_in[30]),
        .OPcode(inst_in[6:2]),
        .Fun3(inst_in[14:12]),
        .Fun7(inst_in[30]),
        .MIO_ready(MIO_ready),
        .ImmSel(ImmSel),
        .ALUSrc_B(is_imm),  //
        .MemtoReg(MemtoReg),
        .Jump(is_jal),//
        .JumpR(is_jalr),
        .Branch(is_branch),  //
        .branch_condition(branch_condition),
        .RegWrite(reg_wen),  //
        .MemRW(MemRW),
        .ALU_Control(alu_ctrl),  //
        .CPU_MIO(CPU_MIO),
        .loadstore_condition(loadstore_condition),
        .is_auipc(is_auipc),
        .is_lui(is_lui),
        .ecall(ecall),
        .mret(mret),
        .ill_instr(ill_instr)
    );
    mypath U2(
        .ecall(ecall),
        .mret(mret),
        .ill_instr(ill_instr),
        .INT(INT0),
        .MemRW(MemRW),
        .ALUSrc_B(is_imm),  //
        .ALU_Control(alu_ctrl), //
        .ALU_out(alu_res),
        .Addr_out(Addr_out),
        .Branch(is_branch),  //
        .branch_condition(branch_condition),
        .Data_in(Data_in),
        .Data_out(Data_out),  //
        .ImmSel(ImmSel),
        .Jump(is_jal),//
        .JumpR(is_jalr),
        .MemtoReg(MemtoReg),
        .PC_out(PC_out),
        .RegWrite(reg_wen),  //
        .clk(clk),
        .inst_field(inst_in),
        .rst(rst),
        .loadstore_condition(loadstore_condition),
        .is_auipc(is_auipc),
        .is_lui(is_lui),
        
        .wea(wea),//***********************************************************
        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),
        .Rs1_data(rs1_val),
        .Rs2_data(rs2_val),
        .Wt_data(reg_i_data),
        .Imm_out(imm),
        .op1(a_val),
        .op2(b_val),
        .do_branch(do_branch),
        .pc_branch(pc_branch),
        
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
        .R31(R31),
        
        .mtvec(mtvec),
        .mcause(mcause),
        .mepc(mepc),
        .mtval(mtval),
        .mie(mie)
    );
    
    
endmodule

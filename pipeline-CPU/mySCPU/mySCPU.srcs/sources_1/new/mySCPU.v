`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/19 15:33:55
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
    input clk,
    input rst,
    input [31:0]inst_in_IFID,//inst_IF
    input [31:0]DMem_data_in_Mem,//Data_in
    /***/
    output en_IF,
    output en_IFID,
    output NOP_IFID,
    output NOP_IDEX,
    /***/
    output [31:0]PC_out_IF,//PC_out_IF
    /***/
    output [31:0]PC_out_IFID,//PC_out_ID
    output [31:0]inst_out_IFID,//inst_ID
    /***/
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
    output [31:0]R31,
    /***/
    output [31:0]PC_out_IDEX,
    output [4:0]Rd_addr_out_IDEX,
    output [31:0]Rs1_out_IDEX,
    output [31:0]Rs2_out_IDEX,
    output [31:0]Imm_out_IDEX,
    output ALUSrc_B_out_IDEX,
    output [3:0]ALU_control_out_IDEX,
    output Branch_out_IDEX,
    output Branch_condition_out_IDEX,
    output MemRW_out_IDEX,//MemRW_EX
    output Jump_out_IDEX,
    output JumpR_out_IDEX,
    output [1:0]MemtoReg_out_IDEX,
    output RegWrite_out_IDEX,
    output is_auipc_out_IDEX,
    output is_lui_out_IDEX,
    output [2:0]loadstore_condition_out_IDEX,
    /***/
    output [31:0]PC4_out_EX,
    output [31:0]PC_out_EX,//PC_out_EX
    output [31:0]ALU_out_EX,
    output zero_out_EX,
    /***/
    output [31:0]PC_out_EXMem,
    output [31:0]PC4_out_EXMem,
    output [4:0]Rd_addr_out_EXMem,
    output zero_out_EXMem,
    output [31:0]ALU_out_EXMem,//Addr_out
    output [31:0]Rs2_out_EXMem,//Data_out
    output Branch_out_EXMem,
    output Branch_condition_out_EXMem,
    output MemRW_out_EXMem,//MemRW_Mem
    output Jump_out_EXMem,
    output JumpR_out_EXMem,
    output [1:0]MemtoReg_out_EXMem,
    output RegWrite_out_EXMem,
    output is_lui_out_EXMem,
    output [2:0]loadstore_condition_out_EXMem,
    output [31:0]Imm_out_EXMem,
    /***/
    output [31:0]Rs2_out_Mem,
    output [31:0]DMem_data_out_Mem,
    output [1:0]PCSrc_out_Mem,
    output [3:0]wea_out_Mem,//wea
    /***/
    output [31:0]ALU_out_MemWB,
    output [31:0]DMem_data_out_MemWB,
    output [31:0]PC4_out_MemWB,
    output [31:0]Imm_out_MemWB,
    output [1:0]MemtoReg_out_MemWB,
    output [4:0]Rd_addr_out_MemWB,
    output RegWrite_out_MemWB,
    /***/
    output [31:0]Data_out_WB//Data_out_WB
);
    stall U0(
        .rst_stall(rst),
        /***/
        .OPcode_out_IFID(inst_out_IFID[6:2]),
        .Rs1_addr_out_IFID(inst_out_IFID[19:15]),
        .Rs2_addr_out_IFID(inst_out_IFID[24:20]),
        .RegWrite_out_IDEX(RegWrite_out_IDEX),
        .Rd_addr_out_IDEX(Rd_addr_out_IDEX),
        .RegWrite_out_EXMem(RegWrite_out_EXMem),
        .Rd_addr_out_EXMem(Rd_addr_out_EXMem),
        .RegWrite_out_MemWB(RegWrite_out_MemWB),
        .Rd_addr_out_MemWB(Rd_addr_out_MemWB),
        /***/
        .Branch_out_ID(Branch_out_ID),
        .JumpR_out_ID(JumpR_out_ID),
        .Jump_out_ID(Jump_out_ID),
        .Branch_out_IDEX(Branch_out_IDEX),
        .JumpR_out_IDEX(JumpR_out_IDEX),
        .Jump_out_IDEX(Jump_out_IDEX),
        /***/
        .en_IF(en_IF),
        .en_IFID(en_IFID),
        .NOP_IFID(NOP_IFID),
        .NOP_IDEX(NOP_IDEX)
    );
    IF U1(
        .clk_IF(clk),
        .rst_IF(rst),
        .en_IF(en_IF),
        .PC1_in_IF(PC_out_EXMem),
        .PC2_in_IF(ALU_out_EXMem),
        .PCSrc_in_IF(PCSrc_out_Mem),
        
        .PC_out_IF(PC_out_IF)
    );
    IFID U2(
        .clk_IFID(clk),
        .rst_IFID(rst),
        .en_IFID(en_IFID),
        .NOP_IFID(NOP_IFID),
        .PC_in_IFID(PC_out_IF),
        .inst_in_IFID(inst_in_IFID),
        
        .PC_out_IFID(PC_out_IFID),
        .inst_out_IFID(inst_out_IFID)
    );
    ID U3(
        .clk_ID(clk),
        .rst_ID(rst),
        .RegWrite_in_ID(RegWrite_out_MemWB),
        .Rd_addr_in_ID(Rd_addr_out_MemWB),
        .Wt_data_in_ID(Data_out_WB),
        .Inst_in_ID(inst_out_IFID),
        
        .Rd_addr_out_ID(Rd_addr_out_ID),
        .Rs1_out_ID(Rs1_out_ID),
        .Rs2_out_ID(Rs2_out_ID),
        .Imm_out_ID(Imm_out_ID),
        .ALUSrc_B_out_ID(ALUSrc_B_out_ID),
        .ALU_control_out_ID(ALU_control_out_ID),
        .Branch_out_ID(Branch_out_ID),
        .Branch_condition_out_ID(Branch_condition_out_ID),
        .MemRW_out_ID(MemRW_out_ID),
        .Jump_out_ID(Jump_out_ID),
        .JumpR_out_ID(JumpR_out_ID),
        .MemtoReg_out_ID(MemtoReg_out_ID),
        .RegWrite_out_ID(RegWrite_out_ID),
        .is_auipc_out_ID(is_auipc_out_ID),
        .is_lui_out_ID(is_lui_out_ID),
        .loadstore_condition_out_ID(loadstore_condition_out_ID),
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
    IDEx U4(
        .clk_IDEX(clk),
        .rst_IDEX(rst),
        .en_IDEX(1'b1),
        .NOP_IDEX(NOP_IDEX),
        .PC_in_IDEX(PC_out_IFID),
        .Rd_addr_in_IDEX(Rd_addr_out_ID),
        .Rs1_in_IDEX(Rs1_out_ID),
        .Rs2_in_IDEX(Rs2_out_ID),
        .Imm_in_IDEX(Imm_out_ID),
        .ALUSrc_B_in_IDEX(ALUSrc_B_out_ID),
        .ALU_control_in_IDEX(ALU_control_out_ID),
        .Branch_in_IDEX(Branch_out_ID),
        .Branch_condition_in_IDEX(Branch_condition_out_ID),
        .MemRW_in_IDEX(MemRW_out_ID),
        .Jump_in_IDEX(Jump_out_ID),
        .JumpR_in_IDEX(JumpR_out_ID),
        .MemtoReg_in_IDEX(MemtoReg_out_ID),
        .RegWrite_in_IDEX(RegWrite_out_ID),
        .is_auipc_in_IDEX(is_auipc_out_ID),
        .is_lui_in_IDEX(is_lui_out_ID),
        .loadstore_condition_in_IDEX(loadstore_condition_out_ID),
        
        .PC_out_IDEX(PC_out_IDEX),
        .Rd_addr_out_IDEX(Rd_addr_out_IDEX),
        .Rs1_out_IDEX(Rs1_out_IDEX),
        .Rs2_out_IDEX(Rs2_out_IDEX),
        .Imm_out_IDEX(Imm_out_IDEX),
        .ALUSrc_B_out_IDEX(ALUSrc_B_out_IDEX),
        .ALU_control_out_IDEX(ALU_control_out_IDEX),
        .Branch_out_IDEX(Branch_out_IDEX),
        .Branch_condition_out_IDEX(Branch_condition_out_IDEX),
        .MemRW_out_IDEX(MemRW_out_IDEX),
        .Jump_out_IDEX(Jump_out_IDEX),
        .JumpR_out_IDEX(JumpR_out_IDEX),
        .MemtoReg_out_IDEX(MemtoReg_out_IDEX),
        .RegWrite_out_IDEX(RegWrite_out_IDEX),
        .is_auipc_out_IDEX(is_auipc_out_IDEX),
        .is_lui_out_IDEX(is_lui_out_IDEX),
        .loadstore_condition_out_IDEX(loadstore_condition_out_IDEX)
    );
    Ex U5(
        .PC_in_EX(PC_out_IDEX),
        .Rs1_in_EX(Rs1_out_IDEX),
        .Rs2_in_EX(Rs2_out_IDEX),
        .Imm_in_EX(Imm_out_IDEX),
        .ALUSrc_A_in_EX(is_auipc_out_IDEX),
        .ALUSrc_B_in_EX(ALUSrc_B_out_IDEX),
        .ALU_control_in_EX(ALU_control_out_IDEX),
        
        .PC4_out_EX(PC4_out_EX),
        .PC_out_EX(PC_out_EX),
        .ALU_out_EX(ALU_out_EX),
        .zero_out_EX(zero_out_EX)
    );
    ExMem U6(
        .clk_EXMem(clk),
        .rst_EXMem(rst),
        .en_EXMem(1'b1),
        .PC_in_EXMem(PC_out_EX),
        .PC4_in_EXMem(PC4_out_EX),
        .Rd_addr_in_EXMem(Rd_addr_out_IDEX),
        .zero_in_EXMem(zero_out_EX),
        .ALU_in_EXMem(ALU_out_EX),
        .Rs2_in_EXMem(Rs2_out_IDEX),
        .Branch_in_EXMem(Branch_out_IDEX),
        .Branch_condition_in_EXMem(Branch_condition_out_IDEX),
        .MemRW_in_EXMem(MemRW_out_IDEX),
        .Jump_in_EXMem(Jump_out_IDEX),
        .JumpR_in_EXMem(JumpR_out_IDEX),
        .MemtoReg_in_EXMem(MemtoReg_out_IDEX),
        .RegWrite_in_EXMem(RegWrite_out_IDEX),
        .is_lui_in_EXMem(is_lui_out_IDEX),
        .loadstore_condition_in_EXMem(loadstore_condition_out_IDEX),
        .Imm_in_EXMem(Imm_out_IDEX),
        
        .PC_out_EXMem(PC_out_EXMem),
        .PC4_out_EXMem(PC4_out_EXMem),
        .Rd_addr_out_EXMem(Rd_addr_out_EXMem),
        .zero_out_EXMem(zero_out_EXMem),
        .ALU_out_EXMem(ALU_out_EXMem),
        .Rs2_out_EXMem(Rs2_out_EXMem),
        .Branch_out_EXMem(Branch_out_EXMem),
        .Branch_condition_out_EXMem(Branch_condition_out_EXMem),
        .MemRW_out_EXMem(MemRW_out_EXMem),
        .Jump_out_EXMem(Jump_out_EXMem),
        .JumpR_out_EXMem(JumpR_out_EXMem),
        .MemtoReg_out_EXMem(MemtoReg_out_EXMem),
        .RegWrite_out_EXMem(RegWrite_out_EXMem),
        .is_lui_out_EXMem(is_lui_out_EXMem),
        .loadstore_condition_out_EXMem(loadstore_condition_out_EXMem),
        .Imm_out_EXMem(Imm_out_EXMem)
    );
    Mem U7(
        .zero_in_Mem(zero_out_EXMem),
        .Branch_in_Mem(Branch_out_EXMem),
        .Branch_condition_in_Mem(Branch_condition_out_EXMem),
        .Jump_in_Mem(Jump_out_EXMem),
        .JumpR_in_Mem(JumpR_out_EXMem),
        .BYTE_in_Mem(ALU_out_EXMem[1:0]),
        .Rs2_in_Mem(Rs2_out_EXMem),
        .DMem_data_in_Mem(DMem_data_in_Mem),
        .loadstore_condition_in_Mem(loadstore_condition_out_EXMem),
        .MemRW_in_Mem(MemRW_out_EXMem),
         
        .Rs2_out_Mem(Rs2_out_Mem),
        .DMem_data_out_Mem(DMem_data_out_Mem),
        .PCSrc_out_Mem(PCSrc_out_Mem),
        .wea_out_Mem(wea_out_Mem)
    );
    MemWB U8(
        .clk_MemWB(clk),
        .rst_MemWB(rst),
        .en_MemWB(1'b1),
        .ALU_in_MemWB(ALU_out_EXMem),
        .DMem_data_in_MemWB(DMem_data_out_Mem),
        .PC4_in_MemWB(PC4_out_EXMem),
        .Imm_in_MemWB(Imm_out_EXMem),
        .MemtoReg_in_MemWB(MemtoReg_out_EXMem),
        .Rd_addr_in_MemWB(Rd_addr_out_EXMem),
        .RegWrite_in_MemWB(RegWrite_out_EXMem),
        
        .ALU_out_MemWB(ALU_out_MemWB),
        .DMem_data_out_MemWB(DMem_data_out_MemWB),
        .PC4_out_MemWB(PC4_out_MemWB),
        .Imm_out_MemWB(Imm_out_MemWB),
        .MemtoReg_out_MemWB(MemtoReg_out_MemWB),
        .Rd_addr_out_MemWB(Rd_addr_out_MemWB),
        .RegWrite_out_MemWB(RegWrite_out_MemWB)
    );
    WB U9(
        .ALU_in_WB(ALU_out_MemWB),
        .DMem_data_in_WB(DMem_data_out_MemWB),
        .PC4_in_WB(PC4_out_MemWB),
        .Imm_in_WB(Imm_out_MemWB),
        .MemtoReg_in_WB(MemtoReg_out_MemWB),
        
        .Data_out_WB(Data_out_WB)
    );
endmodule

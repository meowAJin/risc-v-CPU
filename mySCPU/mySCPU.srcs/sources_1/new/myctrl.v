`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/13 15:25:03
// Design Name: 
// Module Name: myctrl
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


module myctrl(
    input ecallebreak,//ecall0 ebreak1
    input srlisrai,//srli0 srai1
    input[4:0] OPcode,
    input[2:0] Fun3,
    input Fun7,
    input MIO_ready,
    output reg[2:0]ImmSel,//000I，001S，010B，011J, 100U
    output reg ALUSrc_B,//0两寄存器，1寄存器立即数                                      //is_imm
    output reg [1:0]MemtoReg,//00ALU结果，01内存读出，10PC+4
    output reg Jump,//0非jal，1jal                                                     //is_jal
    output reg JumpR,                                                                  //is_jalr
    output reg Branch,//0非branch，1branch                                             //is_branch
    output reg branch_condition,
    output reg RegWrite,//0寄存器读，1寄存器写                                          //reg_wen
    output reg MemRW,//0内存读，1内存写                                                 //mem_wen
    output reg [3:0]ALU_Control,                                                       //alu_ctrl
    output reg [2:0] loadstore_condition,
    output reg is_auipc,
    output reg is_lui,
    output CPU_MIO//
);
    assign CPU_MIO = 0;
    reg [1:0]ALUop;//00SI地址加减，10R多种操作，01B比较操作，11I型操作
    always @* begin
        loadstore_condition = Fun3;
        case(OPcode)
            5'b01100: begin//R-ALU
                ALUSrc_B = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b10;
                ImmSel = 3'b000;
                is_auipc = 1'b0;
                is_lui = 1'b0;
            end
            5'b00000: begin//I-load
                ALUSrc_B = 1'b1;
                MemtoReg = 2'b01;
                RegWrite = 1'b1;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b00;
                is_auipc = 1'b0;
                is_lui = 1'b0; 
                ImmSel = 3'b000;
            end
            5'b01000: begin//S-store
                ALUSrc_B = 1'b1;
                MemtoReg = 2'b00;
                RegWrite = 1'b0;
                MemRW = 1'b1;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b00;
                ImmSel = 3'b001;
                is_auipc = 1'b0;
                is_lui = 1'b0;
            end 
            5'b11000: begin//B-beq
                ALUSrc_B = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b0;
                MemRW = 1'b0;
                Branch = 1'b1;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b01;
                ImmSel = 3'b010;
                is_auipc = 1'b0;
                is_lui = 1'b0;   
            end
            5'b11011: begin//J-jump
                ALUSrc_B = 1'b0;
                MemtoReg = 2'b10;
                RegWrite = 1'b1;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b1;
                JumpR = 1'b0;
                ALUop = 2'b00;
                ImmSel = 3'b011;
                is_auipc = 1'b0;
                is_lui = 1'b0;  
            end          
            5'b00100: begin//I-ALU(addi;;;;)
                ALUSrc_B = 1'b1;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b11;
                ImmSel = 3'b000; 
                is_auipc = 1'b0;
                is_lui = 1'b0;
            end
            5'b11001: begin//jalr
                ALUSrc_B = 1'b1;
                MemtoReg = 2'b10;
                RegWrite = 1'b1;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b1;
                ALUop = 2'b00;
                ImmSel = 3'b000;
                is_auipc = 1'b0;
                is_lui = 1'b0;   
            end 
            5'b01101: begin//lui
                ALUSrc_B = 1'b0;
                MemtoReg = 2'b11;
                RegWrite = 1'b1;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b00;
                ImmSel = 3'b100;
                is_auipc = 1'b0;
                is_lui = 1'b1;   
            end 
            5'b00101: begin//auipc
                ALUSrc_B = 1'b1;
                MemtoReg = 2'b00;
                RegWrite = 1'b1;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b00;
                ImmSel = 3'b100;
                is_auipc = 1'b1;
                is_lui = 1'b0;  
            end 
            default: begin
                ALUSrc_B = 1'b0;
                MemtoReg = 2'b00;
                RegWrite = 1'b0;
                MemRW = 1'b0;
                Branch = 1'b0;
                Jump = 1'b0;
                JumpR = 1'b0;
                ALUop = 2'b00;
                ImmSel = 3'b000;
                is_auipc = 1'b0;
                is_lui = 1'b0; 
            end
        endcase
    end
    
    always @* begin
        case(ALUop)
        2'b00: begin
            ALU_Control = 4'b0010;//地址加 add
            branch_condition = 1'b0;
        end
        2'b01://B型
            case(Fun3)
                3'b000: begin
                    ALU_Control = 4'b0110;//beq
                    branch_condition = 1'b1;
                end
                3'b001: begin
                    ALU_Control = 4'b0110;//bne
                    branch_condition = 1'b0;
                end
                3'b100: begin
                    ALU_Control = 4'b0111;//blt
                    branch_condition = 1'b0;
                end
                3'b101: begin
                    ALU_Control = 4'b0111;//bge
                    branch_condition = 1'b1;
                end
                3'b110: begin
                    ALU_Control = 4'b1001;//bltu
                    branch_condition = 1'b0;
                end
                3'b111: begin
                    ALU_Control = 4'b1001;//bgeu
                    branch_condition = 1'b1;
                end
                default: begin
                    ALU_Control = 4'bxxxx;
                    branch_condition = 1'bx;
                end
            endcase
        2'b10: begin//多种操作
            branch_condition = 1'b0;
            case({Fun3, Fun7})
                4'b0000: ALU_Control = 4'b0010;//add
                4'b0001: ALU_Control = 4'b0110;//sub
                4'b1110: ALU_Control = 4'b0000;//and
                4'b1100: ALU_Control = 4'b0001;//or
                4'b1000: ALU_Control = 4'b1100;//xor
                4'b0100: ALU_Control = 4'b0111;//slt
                4'b1010: ALU_Control = 4'b1101;//srl
                4'b0010: ALU_Control = 4'b1110;//sll
                4'b0110: ALU_Control = 4'b1001;//sltu
                4'b1011: ALU_Control = 4'b1111;//sra
                default: ALU_Control = 4'bxxxx;
            endcase
        end
        2'b11: begin
            branch_condition = 1'b0;
            case(Fun3)
                3'b000: ALU_Control = 4'b0010;//addi
                3'b111: ALU_Control = 4'b0000;//andi
                3'b110: ALU_Control = 4'b0001;//ori
                3'b100: ALU_Control = 4'b1100;//xori
                3'b010: ALU_Control = 4'b0111;//slti
                3'b001: ALU_Control = 4'b1110;//slli
                3'b011: ALU_Control = 4'b1001;//sltiu
                3'b101: 
                    case(srlisrai)
                        1'b0: ALU_Control = 4'b1101;//srli
                        1'b1: ALU_Control = 4'b1111;//srai
                    endcase
                default: ALU_Control = 4'bxxxx;
            endcase
        end
        default: begin
            branch_condition = 1'bx;
            ALU_Control = 4'bxxxx; 
        end
        endcase  
    end 
endmodule

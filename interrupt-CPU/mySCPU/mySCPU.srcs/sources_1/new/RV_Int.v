`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/05/11 00:11:24
// Design Name: 
// Module Name: RV_Int
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


module RV_Int(
    input clk,
    input rst,
    input INT,
    input ecall,
    input mret,
    input ill_instr,
    input [31:0]inst,
    input [31:0]pc_next,
    output reg[31:0] pc,
    output reg[31:0] mtvec,//�洢�ж����� 00���ж� 04ill 08ecall 0cint
    output reg[31:0] mcause,//�洢�ж�ԭ�� 0���ж� 1ill 2ecall 3int
    output reg[31:0] mepc,//�жϺ��쳣����pc��ֵ
    output reg[31:0] mtval,//�洢�����쳣��ָ��ֵ
    output reg[31:0] mie//0���ж� 1�ж�
);

    always@(negedge clk or posedge rst)begin
        if(rst) begin 
            mtvec <= 32'b0;
            mcause <= 32'b0;
            mepc <= 32'b0;
            mtval <= 32'b0;
            mie <= 32'b0;
            pc <= 32'b0;
        end
        else begin
            if(mie == 32'b0) begin//Ŀǰ״̬���ж�
                case({mret, INT, ecall, ill_instr})
                    4'b0000: begin//���ж�
                        mtvec <= 32'b0;
                        mcause <= 32'b0;
                        mepc <= 32'b0;
                        mtval <= 32'b0;
                        mie <= 32'b0;
                        pc <= pc_next;
                    end
                    4'b0001: begin//ill_instr
                        mtvec <= 32'b0100;
                        mcause <= 32'h1;
                        mepc <= pc_next;
                        mtval <= inst;
                        mie <= 32'b1;
                        pc <= 32'b100;
                    end
                    4'b0010: begin//ecall
                        mtvec <= 32'b1000;
                        mcause <= 32'h2;
                        mepc <= pc_next;
                        mtval <= 32'b0;
                        mie <= 32'b1;
                        pc <= 32'b1000;
                    end
                    4'b0100: begin//int
                        mtvec <= 32'b1100;
                        mcause <= 32'h80000003;
                        mepc <= pc_next;
                        mtval <= 32'b0;
                        mie <= 32'b1;
                        pc <= 32'b1100;
                    end
                    4'b1000: begin//mret
                        mtvec <= 32'b0000;
                        mcause <= 32'h0;
                        mepc <= 32'b0;
                        mtval <= 32'b0;
                        mie <= 32'b0;
                        pc <= mepc;
                    end
                    default: begin
                        mtvec <= 32'bx;
                        mcause <= 32'bx;
                        mepc <= 32'bx;
                        mtval <= 32'bx;
                        mie <= 32'bx;
                        pc <= 32'bx;
                    end
                endcase
            end
            else begin//�ж�״̬�޷��ٴδ��������ж�,ֻ�������ж�
                if(mret == 1'b1) begin
                    mtvec <= 32'b0;
                    mcause <= 32'b0;
                    mepc <= 32'b0;
                    mtval <= 32'b0;
                    mie <= 32'b0;
                    pc <= mepc;
                end
                else begin
                    pc <= pc_next;
                end
            end
        end
    end
endmodule

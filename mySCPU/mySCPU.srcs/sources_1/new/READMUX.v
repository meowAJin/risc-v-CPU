`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/28 15:23:10
// Design Name: 
// Module Name: READMUX
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


module READMUX(
    input [1:0]BYTE,
    input [2:0]load_condition,
    input [31:0]Data_in,
    output reg[31:0]read_data
);
    always @* begin
        case(load_condition)
            3'b000://lb
                case(BYTE)
                    2'b00: read_data = {{24{Data_in[7]}}, Data_in[7:0]};
                    2'b01: read_data = {{24{Data_in[15]}}, Data_in[15:8]};
                    2'b10: read_data = {{24{Data_in[23]}}, Data_in[23:16]};
                    2'b11: read_data = {{24{Data_in[31]}}, Data_in[31:24]};
                endcase    
            3'b001://lh
                case(BYTE)
                    2'b00: read_data = {{16{Data_in[15]}}, Data_in[15:0]};
                    2'b01: read_data = {{16{Data_in[23]}}, Data_in[23:8]};
                    2'b10: read_data = {{16{Data_in[23]}}, Data_in[31:16]};
                    2'b11: read_data = {{24{Data_in[31]}}, Data_in[31:24]};//***
                endcase 
            3'b010://lw
                case(BYTE)
                    2'b00: read_data = Data_in;
                    2'b01: read_data = {{8{Data_in[23]}}, Data_in[31:8]};//***
                    2'b10: read_data = {{16{Data_in[23]}}, Data_in[31:16]};//***
                    2'b11: read_data = {{24{Data_in[31]}}, Data_in[31:24]};//***
                endcase 
            3'b100://lbu
                case(BYTE)
                    2'b00: read_data = {24'b0, Data_in[7:0]};
                    2'b01: read_data = {24'b0, Data_in[15:8]};
                    2'b10: read_data = {24'b0, Data_in[23:16]};
                    2'b11: read_data = {24'b0, Data_in[31:24]};
                endcase 
            3'b101://lhu
                case(BYTE)
                    2'b00: read_data = {16'b0, Data_in[15:0]};
                    2'b01: read_data = {16'b0, Data_in[23:8]};
                    2'b10: read_data = {16'b0, Data_in[31:16]};
                    2'b11: read_data = {24'b0, Data_in[31:24]};//***
                endcase 
        endcase
    end

endmodule

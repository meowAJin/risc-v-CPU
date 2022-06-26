`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/28 00:44:10
// Design Name: 
// Module Name: WEAMUX
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


module WEAMUX(
    input [32:0]Data_out_in,
    input [1:0]BYTE,
    input MemRW,
    input [1:0]store_condition,
    output reg [3:0]wea,
    output reg [32:0]Data_out
);
    always @* begin
        case(MemRW)
            1'b0: begin
                wea = 4'b0000;
                Data_out = Data_out_in;
            end
            1'b1: begin
                case(BYTE)
                    2'b00: begin
                        Data_out = Data_out_in;
                        case(store_condition)
                            2'b00: wea = 4'b0001;//sb
                            2'b01: wea = 4'b0011;//sh
                            2'b10: wea = 4'b1111;//sw
                        endcase
                    end
                    2'b01: begin
                        Data_out = {Data_out_in[23:0], 8'b0};
                        case(store_condition)
                            2'b00: wea = 4'b0010;//sb
                            2'b01: wea = 4'b0110;//sh
                        endcase
                    end
                    2'b10: begin
                        Data_out = {Data_out_in[15:0], 16'b0};
                        case(store_condition)
                            2'b00: wea = 4'b0100;//sb
                            2'b01: wea = 4'b1100;//sh
                        endcase
                    end
                    2'b11: begin
                        Data_out = {Data_out_in[7:0], 24'b0};
                        case(store_condition)
                            2'b00: wea = 4'b1000;//sb
                        endcase
                    end
                endcase
            end  
        endcase
    end

endmodule

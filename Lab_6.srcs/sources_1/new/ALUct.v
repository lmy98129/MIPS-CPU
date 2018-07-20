`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/02 10:48:37
// Design Name: 
// Module Name: ALUct
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


module ALUct(
    input rst,
    input[5:0] funct,
    input[7:0] alu_ct_op,
    output reg[3:0] alu_ct
    );
    always@(*)
        if(!rst)
            alu_ct <= 0;
        else begin
            case(alu_ct_op)
                8'b00000000: alu_ct = 4'b0010;//执行加法操作
                8'b00000001: alu_ct = 4'b1000;//lui指令扩展
                8'b00000010: alu_ct = 4'b0110;//执行减法操作，beq也依赖这个完成跳转
                8'b00000100: alu_ct = 4'b1001;//ori指令扩展
                8'b00001000: begin case(funct)//r型指令
                    6'b100001: alu_ct = 4'b0010;//执行加法操作
                    6'b000100: alu_ct = 4'b0111;//sllv指令扩展
                    6'b100011: alu_ct = 4'b0110;//执行减法操作
                    6'b011010: alu_ct = 4'b1011;//执行除法操作
                    6'b100100: alu_ct = 4'b1100;//执行与操作
                    6'b100101: alu_ct = 4'b1001;//执行或操作
                    6'b100110: alu_ct = 4'b1101;//执行异或操作
                    6'b100111: alu_ct = 4'b1110;//执行或非操作
                    6'b101010: alu_ct = 4'b1111;//执行比较操作
                    default:begin
                    end
                endcase end
                8'b00010000: begin case (funct)//r型指令扩展
                    6'b000010: alu_ct = 4'b1010;//执行乘法操作
                    default: begin
                    end
                endcase end
                8'b00100000: alu_ct = 4'b1100;//andi指令扩展
                8'b01000000: alu_ct = 4'b1101;//xori指令扩展
                8'b10000000: alu_ct = 4'b1111;//slti指令扩展
                default: begin
                end
            endcase
        end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/02 08:52:14
// Design Name: 
// Module Name: ALU
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


module ALU(
    input rst,
    input[3:0] alu_ct,
    input[31:0] alu_src1,alu_src2,
    output alu_zero,
    output reg [31:0] alu_res
    );
    assign alu_zero = (alu_res==0)?1:0;//输出ALU结果是否为0的信号
    always@(*)
        if(!rst) begin
            alu_res = 32'bz;//复位
        end else begin
            case(alu_ct)
            4'b0010: alu_res = alu_src1 + alu_src2;//加法功能，add、addui
            4'b0110: alu_res = alu_src1 - alu_src2;//减法功能，beq也依赖这个完成跳转
            4'b0111: alu_res = (alu_src1 << alu_src2);//扩展指令sllv，移位功能
            4'b1000: alu_res = (alu_src2 << 16);//扩展指令lui，高16位置位、低16位置零功能
            4'b1001: alu_res = (alu_src2 | alu_src1);//扩展指令ori、or，两操作数相或
            4'b1010: alu_res = (alu_src2 * alu_src1);//扩展指令mul，两操作数相乘
            4'b1011: alu_res = (alu_src2 / alu_src1);//扩展指令div，两操作数相除
            4'b1100: alu_res = (alu_src2 & alu_src1);//扩展指令and、andi，两操作数相与
            4'b1101: alu_res = (alu_src2 ^ alu_src1);//扩展指令xor，两操作数相异或
            4'b1110: alu_res = ~(alu_src2 | alu_src1);//扩展指令nor，两操作数或非
            4'b1111: alu_res = (alu_src2 < alu_src1)?1:0;//扩展指令slt，两操作数比较大小
            default: begin
            end
            endcase
        end
endmodule

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
    assign alu_zero = (alu_res==0)?1:0;//���ALU����Ƿ�Ϊ0���ź�
    always@(*)
        if(!rst) begin
            alu_res = 32'bz;//��λ
        end else begin
            case(alu_ct)
            4'b0010: alu_res = alu_src1 + alu_src2;//�ӷ����ܣ�add��addui
            4'b0110: alu_res = alu_src1 - alu_src2;//�������ܣ�beqҲ������������ת
            4'b0111: alu_res = (alu_src1 << alu_src2);//��չָ��sllv����λ����
            4'b1000: alu_res = (alu_src2 << 16);//��չָ��lui����16λ��λ����16λ���㹦��
            4'b1001: alu_res = (alu_src2 | alu_src1);//��չָ��ori��or�������������
            4'b1010: alu_res = (alu_src2 * alu_src1);//��չָ��mul�������������
            4'b1011: alu_res = (alu_src2 / alu_src1);//��չָ��div�������������
            4'b1100: alu_res = (alu_src2 & alu_src1);//��չָ��and��andi��������������
            4'b1101: alu_res = (alu_src2 ^ alu_src1);//��չָ��xor���������������
            4'b1110: alu_res = ~(alu_src2 | alu_src1);//��չָ��nor�������������
            4'b1111: alu_res = (alu_src2 < alu_src1)?1:0;//��չָ��slt�����������Ƚϴ�С
            default: begin
            end
            endcase
        end
endmodule

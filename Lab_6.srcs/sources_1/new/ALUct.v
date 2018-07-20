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
                8'b00000000: alu_ct = 4'b0010;//ִ�мӷ�����
                8'b00000001: alu_ct = 4'b1000;//luiָ����չ
                8'b00000010: alu_ct = 4'b0110;//ִ�м���������beqҲ������������ת
                8'b00000100: alu_ct = 4'b1001;//oriָ����չ
                8'b00001000: begin case(funct)//r��ָ��
                    6'b100001: alu_ct = 4'b0010;//ִ�мӷ�����
                    6'b000100: alu_ct = 4'b0111;//sllvָ����չ
                    6'b100011: alu_ct = 4'b0110;//ִ�м�������
                    6'b011010: alu_ct = 4'b1011;//ִ�г�������
                    6'b100100: alu_ct = 4'b1100;//ִ�������
                    6'b100101: alu_ct = 4'b1001;//ִ�л����
                    6'b100110: alu_ct = 4'b1101;//ִ��������
                    6'b100111: alu_ct = 4'b1110;//ִ�л�ǲ���
                    6'b101010: alu_ct = 4'b1111;//ִ�бȽϲ���
                    default:begin
                    end
                endcase end
                8'b00010000: begin case (funct)//r��ָ����չ
                    6'b000010: alu_ct = 4'b1010;//ִ�г˷�����
                    default: begin
                    end
                endcase end
                8'b00100000: alu_ct = 4'b1100;//andiָ����չ
                8'b01000000: alu_ct = 4'b1101;//xoriָ����չ
                8'b10000000: alu_ct = 4'b1111;//sltiָ����չ
                default: begin
                end
            endcase
        end
endmodule

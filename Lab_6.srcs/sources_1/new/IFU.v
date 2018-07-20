`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/04/28 18:23:53
// Design Name: 
// Module Name: IFU
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


module IFU(
    input clk,
    input rst,
    input alu_zero,
    input ct_branch,
    input ct_jump,
    output [31:0] inst
    );
    reg[31:0] pc;
    reg[31:0] instRom[65535:0];//ָ��洢���ռ�Ϊ 256KB
    wire[31:0] ext_data;//������չ���ֵ
    
    initial $readmemh("inst.data",instRom);//����ָ���ļ����洢��
    
    assign inst = instRom[pc[31:2]];//ȡָ��
    
    assign ext_data = {{16{inst[15]}},inst[15:0]};//������չ
    
    always @ (posedge clk)
        if(!rst)
            pc <= 0;
        else begin
            if(ct_jump)
                pc <= {pc[31:28], inst[25:0], 2'b00};//ִ����תָ��
            else if(ct_branch && alu_zero)
                pc <= pc + (ext_data[15:0]<<2);//ִ�з�ָ֧��
            else
                pc <= pc + 4;//ȡ��һ��ָ��
        end
        
endmodule

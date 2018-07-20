`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/02 11:23:01
// Design Name: 
// Module Name: Control
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


module Control(
    input rst,
    input[5:0] ct_inst,
    input[5:0] aluct_inst,
    output ct_rf_dst,
    output ct_rf_wen,
    output ct_alu_src,
    output[3:0] ct_alu,
    output ct_mem_wen,
    output ct_mem_ren,
    output ct_data_rf,
    output ct_branch,
    output ct_jump
    );
    wire inst_r, inst_lw, inst_sw, inst_beq, inst_j, inst_addiu, inst_lui, inst_ori, inst_r2, inst_andi, inst_xori, inst_slti;
    wire[7:0] ct_alu_op;
    ALUct aluct0(rst, aluct_inst, ct_alu_op, ct_alu);
    //�����߼�����
    //����
    assign inst_r = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(!ct_inst[2])&&(!ct_inst[1])&&(!ct_inst[0]);
    assign inst_beq = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(ct_inst[2])&&(!ct_inst[1])&&(!ct_inst[0]);
    assign inst_lw = (ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(ct_inst[0]);
    assign inst_sw = (ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(ct_inst[0]);
    assign inst_j = (!ct_inst[5])&&(!ct_inst[4])&&(!ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(!ct_inst[0]);
    assign inst_addiu = (!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(!ct_inst[2])&&(!ct_inst[1])&&(ct_inst[0]);
    assign inst_lui = (!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(ct_inst[2])&&(ct_inst[1])&&(ct_inst[0]);//luiָ����չ
    assign inst_ori = (!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(ct_inst[2])&&(!ct_inst[1])&&(ct_inst[0]);//oriָ����չ
    assign inst_r2 = (!ct_inst[5])&&(ct_inst[4])&&(ct_inst[3])&&(ct_inst[2])&&(!ct_inst[1])&&(!ct_inst[0]);//r��ָ����չ�����mul��ָ��
    assign inst_andi = (!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(ct_inst[2])&&(!ct_inst[1])&&(!ct_inst[0]);//andiָ����չ
    assign inst_xori = (!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(ct_inst[2])&&(ct_inst[1])&&(!ct_inst[0]);//xoriָ����չ
    assign inst_slti = (!ct_inst[5])&&(!ct_inst[4])&&(ct_inst[3])&&(!ct_inst[2])&&(ct_inst[1])&&(!ct_inst[0]);//sltiָ����չ
    
    //����
    assign ct_rf_dst = rst?inst_r:0;
    assign ct_rf_wen = rst?(inst_r||inst_lw||inst_addiu||inst_lui||inst_ori||inst_andi||inst_xori||inst_slti):0;//luiָ����չ��oriָ����չ��andiָ����չ
    assign ct_alu_src = (inst_lw||inst_sw||inst_addiu||inst_lui||inst_ori||inst_andi||inst_xori||inst_slti);//luiָ����չ��oriָ����չ��andiָ����չ
    assign ct_alu_op[7:0] = {inst_slti,inst_xori,inst_andi,inst_r2,inst_r,inst_ori,inst_beq,inst_lui};//luiָ����չ��oriָ����չ��andiָ����չ��addiuָ������ֱ�Ӿ��Ǽӷ����Ծ�Ĭ��Ϊ0000
    assign ct_branch = rst?inst_beq:0;
    assign ct_mem_ren = rst?inst_lw:0;
    assign ct_mem_wen = rst?inst_sw:0;
    assign ct_data_rf = rst?inst_lw:0;
    assign ct_jump = rst?inst_j:0;
    
    //��ǰʵ��ָ�
    //r��ָ�addu, sub, sllv, div, mul, and, or, xor, nor, slt
    //i��ָ�addiu, lw, sw, beq, ori, lui, andi, xori, slti
    //j��ָ�j
    
endmodule

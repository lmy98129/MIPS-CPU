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
    reg[31:0] instRom[65535:0];//指令存储器空间为 256KB
    wire[31:0] ext_data;//符号扩展后的值
    
    initial $readmemh("inst.data",instRom);//加载指令文件到存储器
    
    assign inst = instRom[pc[31:2]];//取指令
    
    assign ext_data = {{16{inst[15]}},inst[15:0]};//符号扩展
    
    always @ (posedge clk)
        if(!rst)
            pc <= 0;
        else begin
            if(ct_jump)
                pc <= {pc[31:28], inst[25:0], 2'b00};//执行跳转指令
            else if(ct_branch && alu_zero)
                pc <= pc + (ext_data[15:0]<<2);//执行分支指令
            else
                pc <= pc + 4;//取下一条指令
        end
        
endmodule

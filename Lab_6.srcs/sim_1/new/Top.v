`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/09 10:51:12
// Design Name: 
// Module Name: Top
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


module Top();
   reg clk, rst;
   CPU cpu0(clk, rst);
   //��ʼ��
   initial begin
   clk = 0;
   rst = 1;
   end
   
   always begin
       #5 clk = ~clk;//ʱ������
   end
   
   initial begin
       #1 rst = 0;
       #20 rst = 1;//��ʼ��
       #1000 $stop;//����ʱ������
   end
endmodule

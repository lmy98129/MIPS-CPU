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
   //初始化
   initial begin
   clk = 0;
   rst = 1;
   end
   
   always begin
       #5 clk = ~clk;//时钟周期
   end
   
   initial begin
       #1 rst = 0;
       #20 rst = 1;//初始化
       #1000 $stop;//运行时间上限
   end
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2025 09:13:32
// Design Name: 
// Module Name: up_dn_cntr
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


module up_dn_cntr (
input clk, rst,
input x, // x=0 -> up couynting, x=1, down counting
output reg [3:0] cntr
    );

always@(posedge clk, posedge rst)
begin
if(rst)
cntr <= 4'b0000;
else
begin
if(x==0)
begin
  if (cntr==4'b1111)
   cntr <=4'b0000 ;
  else if(cntr <4'b1111)
   cntr <= cntr + 1'b1; 
end
else if (x==1)
begin
  if (cntr==4'b0000)
   cntr <= 4'b1111 ;
  else if(cntr > 4'b0000)
   cntr <= cntr - 1'b1; 
end
end
end
endmodule


module tb_up_dn_cntr;
reg clk, rst, x;
wire [3:0] cntr;

up_dn_cntr uut_up_dn_cntr (.clk(clk), .rst(rst), .x(x), .cntr(cntr));

initial
begin
clk=1'b0; rst=1'b1;
#10; rst=1'b0;
end

always
begin
#5; clk=~clk;
end

initial
begin
x=1'b0;
#200;x=1'b1;
#200;x=1'b0;
#50;x=1'b1;
end

initial
begin
#1000; $finish;
end
endmodule

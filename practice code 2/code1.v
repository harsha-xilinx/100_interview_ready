WAP to delay data by 1 clock cycle
------------------------------------------------------
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2025 01:54:37
// Design Name: 
// Module Name: out_next_clk
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


module out_next_clk(
input clk, rst,
input [1:0] data,
output [1:0] data_out
    );

reg [1:0] data_out_reg1, data_out_reg2;
 
always@(posedge clk, posedge rst)
begin
if(rst)
begin
data_out_reg1 <= 'b0;
end
else
begin
data_out_reg1 <= data;
data_out_reg2 <= data_out_reg1;
end
end

assign data_out = data_out_reg2;
endmodule

module tb_out_next_clk;
reg clk, rst;
reg [1:0] data;
wire [1:0] data_out;
out_next_clk uu_out_next_clk (.clk(clk), .rst(rst), .data(data), .data_out(data_out));

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
data=2'b10;
#40; data=2'b01;
#40; data=2'b11;
#40; data=2'b01;
end

initial
begin
#500; $finish;
end
endmodule

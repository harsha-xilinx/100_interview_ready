// wap to detect edge on each clk cycle.
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2025 08:18:37
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
input clk, rst,
input data_in,
output reg rise_pulse,
fall_pulse
    );

reg data_in_1, data_in_2;
always@ (posedge clk, posedge rst)
begin
if (rst)
begin
data_in_1 <= 'b0;
data_in_2 <= 'b0;
end
else
begin
data_in_1 <= data_in;
rise_pulse <= !(data_in_1) & data_in;
fall_pulse <= !(data_in) & data_in_1;
end
end
endmodule


module tb_edge_detector;
reg clk, rst, data_in;
wire rise_pulse, fall_pulse;
edge_detector uut_edge_detector (.clk(clk), .rst(rst), .data_in(data_in), .rise_pulse(rise_pulse), .fall_pulse(fall_pulse));

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
data_in= 1'b1;
#20; data_in=1'b0;
#20; data_in=1'b1;
#20; data_in=1'b0;
end

initial
begin
#500; $finish;
end
endmodule

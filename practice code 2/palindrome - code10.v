`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 15:20:33
// Design Name: 
// Module Name: palindrome
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


module palindrome #(parameter N=9)(
input [N-1:0] data,
output  out
    );

genvar i;
wire [N/2-1:0] chk;

generate
for(i=0; i<N/2; i=i+1)
begin
assign chk[i] = (data[i] == data[N-i-1])? 1'b1: 1'b0;
end
endgenerate

assign out = &chk;

endmodule


module tb_palindrome;
parameter N=15;
reg [N-1:0] data;
wire out;
palindrome  #(.N(15)) uut_palindrome  (.data(data), .out(out));

initial
begin
data=15'b110011001100110;
#20; data=15'b111100010001111;
#20; data=15'b001100101001100;
end

initial
begin
#100; $finish;
end
endmodule

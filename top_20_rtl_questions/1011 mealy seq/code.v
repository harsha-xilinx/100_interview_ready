`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 06:10:24
// Design Name: 
// Module Name: seq_1011_mealy
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


module seq_1011_mealy(
input clk, rst_n,a,
output [3:0] out
    );
localparam [1:0] s0=2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
reg [1:0] state_reg, state_nxt;

always@(posedge clk, negedge rst_n)
 if(rst_n)
 state_reg <= s0;
 else
 state_reg <= state_nxt;
 
always@*
case(state_reg)
s0: if(a)
    state_nxt=s1;
    else
    state_nxt=s0;
s1: if(a)
    state_nxt=s1;
    else
    state_nxt=s2;
s2: if(a)
    state_nxt=s3;
    else
    state_nxt=s0;
s3: if(a)
    state_nxt=s1;
    else
    state_nxt=s2;
endcase

assign out = state_reg;
endmodule


module tb;
reg clk, rst_n, a;
wire [3:0] out;
seq_1011_mealy sm1 (.clk(clk), .rst_n(rst_n), .a(a), .out(out));
initial
begin
clk=1'b0; rst_n=1'b1; 
#10; rst_n = 1'b0;
end

initial
begin
a=1'b0;
#10; a=1'b1;
#10; a=1'b0;
#10; a=1'b1;
#10; a=1'b1;
#10; a=1'b0;
#10; a=1'b1;
#10; a=1'b1;
#10; a=1'b0;
#10; a=1'b0;
#10; a=1'b1;
#10; a=1'b1;
#500; finish;
end


always
begin
#5; clk=~clk;
end
endmodule

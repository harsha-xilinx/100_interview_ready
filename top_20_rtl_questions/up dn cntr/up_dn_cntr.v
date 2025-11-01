`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 05:28:39
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


module up_dn_cntr #(parameter N=4) (
input clk, rst_n, 
input wire dir,
output wire [N-1:0] out
    );
reg [N-1:0] out_reg, out_nxt;
always@(posedge clk, negedge rst_n)
begin
  if(!rst_n)
    out_reg <= {N{1'b0}};
  else
    out_reg <= out_nxt;
end

always@*
begin
  if(dir)  //up counting
  begin
    if (out_reg == {N{1'b1}})
      out_nxt = {N{1'b0}};
    else if (out_reg < {N{1'b1}})
      out_nxt = out_reg+1'b1;
  end
else  // down counting
  begin
    if (out_reg == {N{1'b0}})
      out_nxt = {N{1'b1}};
    else if (out_reg > {N{1'b0}})
      out_nxt = out_reg - 1'b1;
  end
end

assign out = out_reg;
endmodule

module tb;
parameter N=4;
reg clk, rst_n;
reg dir;
wire [N-1:0] out;
up_dn_cntr upd1 (.clk(clk), .rst_n(rst_n), .dir(dir), .out(out));
initial
begin
 clk=1'b0;rst_n=1'b0; dir=1'b1;
 #10; rst_n=1'b1;
 #200; dir=1'b0;
end

always
begin
#5; clk=~clk;
end

initial
begin
#500; $finish;
end
endmodule

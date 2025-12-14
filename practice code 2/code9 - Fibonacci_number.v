📌 Problem Restatement
Generate one Fibonacci number per clock cycle after a start signal is asserted.

📐 Assumptions (State Clearly in Interview)
Synchronous design
Active-low reset
Output is valid every cycle after start
Sequence: 0, 1, 1, 2, 3, 5, 8, ...
Generator keeps running until reset (can be extended with stop)


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.12.2025 13:44:17
// Design Name: 
// Module Name: fibbonacci
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


module fibbonacci(
input clk, rst, start,
output reg [31:0] fib_out,
output reg valid
    );
reg [31:0] fib_out_curr, fib_out_prev;
reg        first;
always @(posedge clk, posedge rst)
begin
  if(rst)
  begin
    fib_out <= 'b0;
    fib_out_curr <= 'b1;
    fib_out_prev <= 'b0;
    valid <= 1'b0;
    first <= 1'b1;
  end
    else if (start) begin
      valid <= 1'b1;

      if (first) begin
        // Output initial 0
        fib_out <= 32'd0;
        first   <= 1'b0;
      end
      else begin
        // Normal Fibonacci progression
        fib_out      <= fib_out + fib_out_curr;
        fib_out_curr <= fib_out;
      end
    end
    else begin
      valid <= 1'b0;
    end
  end
endmodule

module tb_fibbonacci;
reg clk, rst, start;
wire [31:0] fib_out;
wire valid;
fibbonacci u_fibbonacci (.clk(clk), .rst(rst), .fib_out(fib_out), .valid(valid), .start(start));

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
start=1'b0;
#15; start=1'b1;
end

initial
begin
#500;$finish;
end

endmodule

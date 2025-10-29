`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.10.2025 09:05:02
// Design Name: 
// Module Name: multifunction_barrel_shifter
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
// Problem: 

module multifunction_barrel_shifter(
input [7:0] data,
input lr,
input [2:0] ctrl,
output [7:0] out
    );

 reg [7:0] s0, s1, s2;
 
always@*
begin
  if(lr)
  begin
    if (ctrl[0])
    begin
    s0[7:1] = data[6:0];
    s0[0] = data[7];
    end
    else
    s0=data;

    
    if (ctrl[1])
    begin
    s1[7:2] =s0[5:0];
    s1[1:0] =s0[7:6];
    end
    else
    s1=s0;
    
    if (ctrl[2])
    begin
    s2[7:4] = s1[3:0];
    s2[3:0] = s1[7:4];
    end
    else
    s2=s1;
  end // if lr
  else if (~lr)
  begin
    if (ctrl[0])
    begin
    s0[6:0] = data[7:1];
    s0[7] = data[0];
    end
    else
    s0=data;
    
    if (ctrl[1])
    begin
    s1[5:0] =s0[7:2];
    s1[7:6] =s0[1:0];
    end
    else
    s1=s0;
    
    if (ctrl[2])
    begin
    s2[3:0] =s1[7:4];
    s2[7:4] =s1[3:0];
    end
    else
    s2=s1;            
  end
end
assign out=s2;
endmodule


module tb_multifunction_barrel_shifter;
reg [7:0] data;
reg [2:0] ctrl;
reg lr;
wire [7:0] out;
multifunction_barrel_shifter mbr (.data(data), .ctrl(ctrl), .lr(lr), .out(out));


initial begin
    data = 8'b11001100;
    lr   = 1'b1;
    ctrl = 3'b000;

    $display("Starting test...");
    $monitor("Time=%0t | lr=%b | ctrl=%b | data=%b | out=%b",
              $time, lr, ctrl, data, out);

    // Rotate left tests
    repeat(8) begin
        #20 ctrl = ctrl + 1;
    end

    // Change data and direction
    #40;
    data = 8'b11110000;
    lr   = 1'b0;
    ctrl = 3'b000;

    // Rotate right tests
    repeat(8) begin
        #20 ctrl = ctrl + 1;
    end

    #500;
    $finish;
end
endmodule

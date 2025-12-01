`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2025 19:51:28
// Design Name: 
// Module Name: multi_barrel_shifter
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


module multi_barrel_shifter #(parameter WIDTH=32)(
    input  wire [WIDTH-1:0] din,
    input  wire [$clog2(WIDTH)-1:0] shamt, // shift amount (0 .. WIDTH-1)
    input  wire [2:0] mode,                // operation mode (see localparams)
    output wire [WIDTH-1:0] dout
    );

reg [WIDTH-1:0] dout_reg, dout_reg2;
integer amt;
always@*
begin
case (mode)
3'd0: dout_reg = din << shamt;
3'd1: dout_reg = din >> shamt ;
3'd2: dout_reg = din <<< shamt;
3'd3: dout_reg = din >>> shamt ;
3'd4: begin
      if (shamt==0)
       dout_reg = din;
      else
       dout_reg = (din << shamt) | (din >> (WIDTH - shamt));
      end
3'd5: begin
      if (shamt==0)
       dout_reg = din;
      else
       dout_reg = (din >> shamt) | (din << (WIDTH - shamt));
      end      
endcase
end
endmodule

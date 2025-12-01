WAP for priority encoder 4x2, where LSB has the most priority.
  -------------------------------------------------------------------------
  module priority_encoder_8x3(
input [3:0] in,
output reg [1:0] out
    );

always@*
begin
    out = 2'b00;
if (in[0])
  out=2'b00;
else if(in[1])
  out=2'b01;
else if(in[2])
  out=2'b10;
else if(in[3])
  out=2'b11;  
end
endmodule

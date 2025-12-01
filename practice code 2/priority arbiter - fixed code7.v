=============================================================================================================================
=============================================================================================================================
Fixed priority arbiter - non synthesizable:
=============================================================================================================================
=============================================================================================================================
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.12.2025 09:54:04
// Design Name: 
// Module Name: fixed_priority_arbiter
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


module fixed_priority_arbiter #(parameter N=4)(
input [N-1:0] req,
output reg [N-1:0] grant
    );
integer i;
always@*
begin
grant= 'b0;
for(i=0; i<N; i=i+1)
begin: for_req
  if(req[i]==1)
    begin
    grant[i] = 1'b1;
    disable for_req;
    end
  else
    begin
    grant[i] = 1'b0;
    end
end
end
endmodule


=============================================================================================================================
=============================================================================================================================
Fixed priority arbiter - synthesizable:
=============================================================================================================================
=============================================================================================================================
module priority_arbiter #(
    parameter N = 4   // number of request lines
)(
    input  wire [N-1:0] req,    // request vector
    output reg  [N-1:0] grant   // one-hot grant vector
);
integer i;
reg found;
  always@ *
  begin
    found=1'b0;
    grant = {N{1'b0}};
    for (i=0; i<N; i=i+1)
     begin
     if(!found)
     begin
      if(req[i])
       begin  
        grant[i] = 1'b1;
        found=1'b1;
       end
      end
     end
  end 
endmodule


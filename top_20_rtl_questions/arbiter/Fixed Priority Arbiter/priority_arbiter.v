`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.10.2025 07:52:40
// Design Name: 
// Module Name: priority_arbiter
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

module tb_priority_arbiter;
    parameter N = 4;  // can change to any number of requesters
    reg  [N-1:0] req;
    wire [N-1:0] grant;
  priority_arbiter pa1 (.req(req), .grant(grant));
reg found;
  reg [N-1:0] expected_value; 
  integer i,j;  
  initial
    begin
      $display("Time\tReq\tGrant\tExpected\tResult");
      $display("--------------------------------------------");
      for(i=0; i<30; i=i+1)
      begin
          #10; req= $random;
 
    //computing expected values
      expected_value=4'b0;
      found=1'b0;
      for(j=0; j<N; j=j+1)
        begin
          if (req[j])
            if(!found)
            begin
              expected_value[j] = 1'b1;
              found=1'b1;
            end
        end
    if (grant == expected_value)
                $display("%0t\t%b\t%b\t%b\tPASS", $time, req, grant, expected_value);
    else
                $display("%0t\t%b\t%b\t%b\tFAIL", $time, req, grant, expected_value);
    end
  #200; $finish;
  end   

endmodule

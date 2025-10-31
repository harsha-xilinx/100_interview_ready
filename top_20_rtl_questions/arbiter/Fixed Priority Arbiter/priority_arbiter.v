module priority_arbiter #(
    parameter N = 4   // number of request lines
)(
    input  wire [N-1:0] req,    // request vector
    output reg  [N-1:0] grant   // one-hot grant vector
);
  always@ *
  begin
    grant = {N(1'b0)};
    for (i=0; i<N; i=i+1)
     begin
      if(req[i])
       begin  
        grant[i] = 1'b1;
        disable for;
       end
     end
  end 
endmodule

module tb_priority_arbiter;
    parameter N = 4;  // can change to any number of requesters

    reg  [N-1:0] req;
    wire [N-1:0] grant;
  priority_arbiter pa1 (.req(req), .grant(grant));

  reg [N-1:0] expected_value; 
  
  initial
    begin
      $display("Time\tReq\tGrant\tExpected\tResult");
      $display("--------------------------------------------");
      for(i=0; i<30; i=i+1)
      begin
          #10; req= $random;
        
    //computing expected values
      for(j=0; j<N; j=j+1)
        begin
          if (req[j])
            begin
              expected[j] = 1'b1;
            end
        end
    if (grant === expected)
                $display("%0t\t%b\t%b\t%b\tPASS", $time, req, grant, expected);
    else
                $display("%0t\t%b\t%b\t%b\tFAIL", $time, req, grant, expected);
    end
  #200; $finish;
  end   

endmodule

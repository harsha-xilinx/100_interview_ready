module round_robin_arbiter #(parameter N=4)(
  input clk, rst,
  input [N-1:0] data_in,
  output wire [N-1:0] data_out);

  reg [$clog2(N)-1:0] last_grant_reg, last_grant_nxt;
  reg [N-1:0] data_reg, data_nxt;

  always@ (posedge clk, posedge rst)
  begin
    if(rst)
      begin
        data_reg <= N'b0;
        last_grant <= $clog2(N)'b0;
      end
    else
      begin
        data_reg <= data_nxt;
        last_grant_reg <= last_grant_nxt;
      end
  end

  integer i;

  // last grant calculation
  always@*
    begin
      if(last_grant_reg == N-1)
        last_grant_next = 0;
      else
        last_grant_next = last_grant_reg + 1'b1;
    end

  // data out
  always@*
  begin
    data_nxt = N'b0;
      if(data_in[last_grant_reg] == 1'b1)
        data_nxt[last_grant_reg]=1'b1;
      else
        begin
          for (i=last_grant_reg; i < N; i=i+1)
          if(!found)
            begin
              if(data_in[i]==1)
                found=1'b1;
              else if (i==N)
                i= -1;
            end
        end
  end

assign data_out = data_nxt;
endmodule

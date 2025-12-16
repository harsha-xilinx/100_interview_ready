module round_robin_arbiter #(parameter N=6) (
input clk, rst_n,
input [N-1:0] a,
output reg [N-1:0] y);

reg [$clog2(N)-1:0] last_grant_reg, last_grant_nxt;
reg [N-1:0] data_reg, data_nxt;

integer i, idx;
reg found;

always@(posedge clk, negedge rst_n)
begin
  if(!rst_n)
    begin
    data_reg <= 'b0;
    last_grant_reg <= 'b0; 
    end
  else
    begin
    data_reg <= data_nxt;
    last_grant_reg <= last_grant_nxt;
    end
end

always@*
begin
  last_grant_nxt  = last_grant_reg;
  data_nxt ={N{1'b0}};
  found = 1'b0;
  for (i=1; i<=N; i=i+1)
  begin
    if(!found)
    begin
      idx = (last_grant_reg + i)% N;
      if (a[idx])
        begin
         data_nxt[idx]=1'b1;
         last_grant_nxt = idx;
         found = 1'b1;
        end
    end
  end
end
assign y = data_reg;
endmodule

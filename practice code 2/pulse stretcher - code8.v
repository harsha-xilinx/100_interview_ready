module pulse_stretcher #(
parameter N = 4                 // stretch length
)(
input  wire clk,
input  wire rst_n,
input  wire in_pulse,           // 1-cycle pulse
output reg  out_pulse           // N-cycle stretched output
);


reg [$clog2(N):0] count;        // counter to hold stretch duration

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        out_pulse <= 1'b0;
        count     <= 0;
    end else begin
        if (in_pulse) begin
            // Restart stretch window
            out_pulse <= 1'b1;
            count     <= N-1;
        end 
        else if (count != 0) begin
            // Continue stretching
            out_pulse <= 1'b1;
            count     <= count - 1;
        end 
        else begin
            out_pulse <= 1'b0;
        end
    end
end


endmodule

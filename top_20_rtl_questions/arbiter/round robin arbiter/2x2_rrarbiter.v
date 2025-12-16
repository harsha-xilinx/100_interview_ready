module arb_2x2 (
    input        clk,
    input        rst_n,
    input  [1:0] a,
    output reg [1:0] out
);

    reg last_grant_reg; // 0 -> last was a[0], 1 -> last was a[1]

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            last_grant_reg <= 1'b0;
            out            <= 2'b00;
        end
        else begin
            out <= 2'b00;  // default: no grant

            if (last_grant_reg == 1'b0) begin
                // Prefer a[1]
                if (a[1]) begin
                    out            <= 2'b10;
                    last_grant_reg <= 1'b1;
                end
                else if (a[0]) begin
                    out            <= 2'b01;
                    last_grant_reg <= 1'b0;
                end
            end
            else begin
                // Prefer a[0]
                if (a[0]) begin
                    out            <= 2'b01;
                    last_grant_reg <= 1'b0;
                end
                else if (a[1]) begin
                    out            <= 2'b10;
                    last_grant_reg <= 1'b1;
                end
            end
        end
    end

endmodule

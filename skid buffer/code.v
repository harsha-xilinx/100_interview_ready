module skid_buffer_depth1 #(
  parameter N = 32
)(
  input  wire           clk,
  input  wire           rst_n,

  // Upstream
  input  wire           s_valid,
  input  wire [N-1:0]   s_data,
  output wire           s_ready,

  // Downstream
  input  wire           m_ready,
  output wire           m_valid,
  output wire [N-1:0]   m_data
);

  reg [N-1:0] buffer_data;
  reg         buffer_valid;

  // Ready when buffer empty or downstream ready
  assign s_ready = m_ready || ~buffer_valid;

  // Valid when buffer has data or upstream has data
  assign m_valid = buffer_valid || s_valid;

  // Data mux
  assign m_data  = buffer_valid ? buffer_data : s_data;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      buffer_valid <= 1'b0;
    end
    else begin
      // Capture skid data
      if (s_valid && s_ready && !m_ready) begin
        buffer_valid <= 1'b1;
        buffer_data  <= s_data;
      end
      // Drain buffer
      else if (buffer_valid && m_ready) begin
        buffer_valid <= 1'b0;
      end
    end
  end

endmodule

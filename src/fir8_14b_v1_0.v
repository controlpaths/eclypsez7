/**
  Module name:  fir8_14b
  Author: P Trujillo (pablo@controlpaths.com)
  Date: May 2020
  Description: 8th order FIR filter. 14 bits width
  Revision: 1.0 Module created
**/

module fir8_14b_v1_0 (
  input clk,
  input rstn,
  input ce,

  input signed [31:0] is32_coeff_0, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_1, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_2, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_3, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_4, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_5, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_6, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_7, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_8, /* FIR filter coefficient*/

  input signed [13:0] is14_in, /* Filter input */
  output signed [13:0] os14_out /* Filter output */
  );

  reg signed [31:0] rs32_pipe [8:0]; /* Pipeline registers */
  wire signed [(32*2)-1:0] ws64_pipe_coeff [8:0]; /* Multipliers results*/

  /*  Pipeline */
  always @(posedge clk)
    if (!rstn) begin
      rs32_pipe[0] <= 32'd0;
      rs32_pipe[1] <= 32'd0;
      rs32_pipe[2] <= 32'd0;
      rs32_pipe[3] <= 32'd0;
      rs32_pipe[4] <= 32'd0;
      rs32_pipe[5] <= 32'd0;
      rs32_pipe[6] <= 32'd0;
      rs32_pipe[7] <= 32'd0;
      rs32_pipe[8] <= 32'd0;
    end
    else
      if (ce) begin
        rs32_pipe[0] <= {is14_in, 18'd0}; /* Input signal shifted (coefficient_decimal_width - io_decimal_width) = 31-13*/
        rs32_pipe[1] <= rs32_pipe[0];
        rs32_pipe[2] <= rs32_pipe[1];
        rs32_pipe[3] <= rs32_pipe[2];
        rs32_pipe[4] <= rs32_pipe[3];
        rs32_pipe[5] <= rs32_pipe[4];
        rs32_pipe[6] <= rs32_pipe[5];
        rs32_pipe[7] <= rs32_pipe[6];
        rs32_pipe[8] <= rs32_pipe[7];
      end

  /* Multiplier-Accumulator (MAC) structure */
  assign ws64_pipe_coeff[0] = rs32_pipe[0]*is32_coeff_0;
  assign ws64_pipe_coeff[1] = rs32_pipe[1]*is32_coeff_1+ws64_pipe_coeff[0];
  assign ws64_pipe_coeff[2] = rs32_pipe[2]*is32_coeff_2+ws64_pipe_coeff[1];
  assign ws64_pipe_coeff[3] = rs32_pipe[3]*is32_coeff_3+ws64_pipe_coeff[2];
  assign ws64_pipe_coeff[4] = rs32_pipe[4]*is32_coeff_4+ws64_pipe_coeff[3];
  assign ws64_pipe_coeff[5] = rs32_pipe[5]*is32_coeff_5+ws64_pipe_coeff[4];
  assign ws64_pipe_coeff[6] = rs32_pipe[6]*is32_coeff_6+ws64_pipe_coeff[5];
  assign ws64_pipe_coeff[7] = rs32_pipe[7]*is32_coeff_7+ws64_pipe_coeff[6];
  assign ws64_pipe_coeff[8] = rs32_pipe[8]*is32_coeff_8+ws64_pipe_coeff[7];

  assign os14_out = (ws64_pipe_coeff[8]>>>(63-14));

endmodule

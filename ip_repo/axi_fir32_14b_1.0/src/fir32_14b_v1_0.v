/**
  Module name:  fir8_14b
  Author: P Trujillo (pablo@controlpaths.com)
  Date: May 2020
  Description: 8th order FIR filter. 14 bits width
  Revision: 1.0 Module created
**/

module fir32_14b_v1_0 (
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
  input signed [31:0] is32_coeff_9, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_10, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_11, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_12, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_13, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_14, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_15, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_16, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_17, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_18, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_19, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_20, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_21, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_22, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_23, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_24, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_25, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_26, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_27, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_28, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_29, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_30, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_31, /* FIR filter coefficient*/
  input signed [31:0] is32_coeff_32, /* FIR filter coefficient*/

  input signed [13:0] is14_in, /* Filter input */
  output signed [13:0] os14_out /* Filter output */
  );

  reg signed [31:0] rs32_pipe [32:0]; /* Pipeline registers */
  wire signed [(32*2)-1:0] ws64_pipe_coeff [32:0]; /* Multipliers results*/

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
      rs32_pipe[9] <= 32'd0;
      rs32_pipe[10] <= 32'd0;
      rs32_pipe[11] <= 32'd0;
      rs32_pipe[12] <= 32'd0;
      rs32_pipe[13] <= 32'd0;
      rs32_pipe[14] <= 32'd0;
      rs32_pipe[15] <= 32'd0;
      rs32_pipe[16] <= 32'd0;
      rs32_pipe[17] <= 32'd0;
      rs32_pipe[18] <= 32'd0;
      rs32_pipe[19] <= 32'd0;
      rs32_pipe[20] <= 32'd0;
      rs32_pipe[21] <= 32'd0;
      rs32_pipe[22] <= 32'd0;
      rs32_pipe[23] <= 32'd0;
      rs32_pipe[24] <= 32'd0;
      rs32_pipe[25] <= 32'd0;
      rs32_pipe[26] <= 32'd0;
      rs32_pipe[27] <= 32'd0;
      rs32_pipe[28] <= 32'd0;
      rs32_pipe[29] <= 32'd0;
      rs32_pipe[30] <= 32'd0;
      rs32_pipe[31] <= 32'd0;
      rs32_pipe[32] <= 32'd0;

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
        rs32_pipe[9] <= rs32_pipe[8];
        rs32_pipe[10] <= rs32_pipe[9];
        rs32_pipe[11] <= rs32_pipe[10];
        rs32_pipe[12] <= rs32_pipe[11];
        rs32_pipe[13] <= rs32_pipe[12];
        rs32_pipe[14] <= rs32_pipe[13];
        rs32_pipe[15] <= rs32_pipe[14];
        rs32_pipe[16] <= rs32_pipe[15];
        rs32_pipe[17] <= rs32_pipe[16];
        rs32_pipe[18] <= rs32_pipe[17];
        rs32_pipe[19] <= rs32_pipe[18];
        rs32_pipe[20] <= rs32_pipe[19];
        rs32_pipe[21] <= rs32_pipe[20];
        rs32_pipe[22] <= rs32_pipe[21];
        rs32_pipe[23] <= rs32_pipe[22];
        rs32_pipe[24] <= rs32_pipe[23];
        rs32_pipe[25] <= rs32_pipe[24];
        rs32_pipe[26] <= rs32_pipe[25];
        rs32_pipe[27] <= rs32_pipe[26];
        rs32_pipe[28] <= rs32_pipe[27];
        rs32_pipe[29] <= rs32_pipe[28];
        rs32_pipe[30] <= rs32_pipe[29];
        rs32_pipe[31] <= rs32_pipe[30];
        rs32_pipe[32] <= rs32_pipe[31];
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
  assign ws64_pipe_coeff[9] = rs32_pipe[9]*is32_coeff_9+ws64_pipe_coeff[8];
  assign ws64_pipe_coeff[10] = rs32_pipe[10]*is32_coeff_10+ws64_pipe_coeff[9];
  assign ws64_pipe_coeff[11] = rs32_pipe[11]*is32_coeff_11+ws64_pipe_coeff[10];
  assign ws64_pipe_coeff[12] = rs32_pipe[12]*is32_coeff_12+ws64_pipe_coeff[11];
  assign ws64_pipe_coeff[13] = rs32_pipe[13]*is32_coeff_13+ws64_pipe_coeff[12];
  assign ws64_pipe_coeff[14] = rs32_pipe[14]*is32_coeff_14+ws64_pipe_coeff[13];
  assign ws64_pipe_coeff[15] = rs32_pipe[15]*is32_coeff_15+ws64_pipe_coeff[14];
  assign ws64_pipe_coeff[16] = rs32_pipe[16]*is32_coeff_16+ws64_pipe_coeff[15];
  assign ws64_pipe_coeff[17] = rs32_pipe[17]*is32_coeff_17+ws64_pipe_coeff[16];
  assign ws64_pipe_coeff[18] = rs32_pipe[18]*is32_coeff_18+ws64_pipe_coeff[17];
  assign ws64_pipe_coeff[19] = rs32_pipe[19]*is32_coeff_19+ws64_pipe_coeff[18];
  assign ws64_pipe_coeff[20] = rs32_pipe[20]*is32_coeff_20+ws64_pipe_coeff[19];
  assign ws64_pipe_coeff[21] = rs32_pipe[21]*is32_coeff_21+ws64_pipe_coeff[20];
  assign ws64_pipe_coeff[22] = rs32_pipe[22]*is32_coeff_22+ws64_pipe_coeff[21];
  assign ws64_pipe_coeff[23] = rs32_pipe[23]*is32_coeff_23+ws64_pipe_coeff[22];
  assign ws64_pipe_coeff[24] = rs32_pipe[24]*is32_coeff_24+ws64_pipe_coeff[23];
  assign ws64_pipe_coeff[25] = rs32_pipe[25]*is32_coeff_25+ws64_pipe_coeff[24];
  assign ws64_pipe_coeff[26] = rs32_pipe[26]*is32_coeff_26+ws64_pipe_coeff[25];
  assign ws64_pipe_coeff[27] = rs32_pipe[27]*is32_coeff_27+ws64_pipe_coeff[26];
  assign ws64_pipe_coeff[28] = rs32_pipe[28]*is32_coeff_28+ws64_pipe_coeff[27];
  assign ws64_pipe_coeff[29] = rs32_pipe[29]*is32_coeff_29+ws64_pipe_coeff[28];
  assign ws64_pipe_coeff[30] = rs32_pipe[30]*is32_coeff_30+ws64_pipe_coeff[29];
  assign ws64_pipe_coeff[31] = rs32_pipe[31]*is32_coeff_31+ws64_pipe_coeff[30];
  assign ws64_pipe_coeff[32] = rs32_pipe[32]*is32_coeff_32+ws64_pipe_coeff[31];

  assign os14_out = (ws64_pipe_coeff[32]>>>(63-14));

endmodule

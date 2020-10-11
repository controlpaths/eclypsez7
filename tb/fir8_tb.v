`timescale 1ns / 10ps

module fir8_tb();

  reg clk100mhz, rst, ce;
  wire signed [13:0] filter_output;
  wire signed [13:0] filter_output32;

  initial begin
    clk100mhz <= 1'b0;
    forever
    #5 clk100mhz <= ~clk100mhz;
  end

  initial begin
    rst <= 1'b0;
    #100
    rst <= 1'b1;
  end

  initial begin
    ce <= 1'b0;
    forever begin
      #100 ce <= 1'b1;
      #10 ce <= 1'b0;
    end
  end

  mv_avg_filter_8_v1_0 mv_avg_filter_8_inst0(
  .clk(clk100mhz),
  .rst(!rst),
  .i32_prescaler(500),
  .is14_data(14'd1000),
  .os14_data(filter_output)
  );

  // fir8_14b_v1_0 uut_8 (
  // .clk(clk100mhz),
  // .rstn(rst),
  // .ce(ce),
  // .is32_coeff_0(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_1(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_2(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_3(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_4(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_5(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_6(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_7(32'd238609294), /* FIR filter coefficient*/
  // .is32_coeff_8(32'd238609294), /* FIR filter coefficient*/
  // .is14_in(14'd3000), /* Filter input */
  // .os14_out() /* Filter output */
  // );
  //
  // fir32_14b_v1_0 uut_32 (
  // .clk(clk100mhz),
  // .rstn(rst),
  // .ce(ce),
  // .is32_coeff_0(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_1(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_2(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_3(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_4(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_5(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_6(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_7(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_8(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_9(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_10(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_11(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_12(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_13(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_14(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_15(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_16(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_17(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_18(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_19(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_20(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_21(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_22(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_23(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_24(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_25(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_26(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_27(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_28(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_29(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_30(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_31(32'd65619885), /* FIR filter coefficient*/
  // .is32_coeff_32(32'd65619885), /* FIR filter coefficient*/
  // .is14_in(14'd3000), /* Filter input */
  // .os14_out(filter_output32) /* Filter output */
  // );

endmodule

`timescale 1ns / 10ps

module fir8_tb();

  reg clk100mhz, rst, ce;
  wire signed [13:0] filter_output;

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

  fir8_14b_v1_0 UUT (
  .clk(clk100mhz),
  .rstn(rst),
  .ce(ce),
  .is32_coeff_0(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_1(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_2(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_3(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_4(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_5(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_6(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_7(32'd238609294), /* FIR filter coefficient*/
  .is32_coeff_8(32'd238609294), /* FIR filter coefficient*/
  .is14_in(14'd3000), /* Filter input */
  .os14_out(filter_output) /* Filter output */
  );

endmodule

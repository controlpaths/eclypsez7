/*
  Module name:  top_eclypse_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: Feb 2020
  Description:
          Top module for manage DAC output. ZMOD DAC from Digilent
  Revision:
          1.0: Module created.
*/

module top_eclypse_v1_0 (
  input clk125mhz,

  output [13:0] o14_dac_data,
  output o_dac_clkout,
  output o_dac_dclkio,
  output o_dac_fsadji,
  output o_dac_fsadjq,
  output o_dac_sck,
  output o_dac_sdio,
  output o_dac_cs,
  output o_dac_rst,

  input [13:0] i14_adc_data,
  input i_adc_dco,
  output o_adc_clkout_p,
  output o_adc_clkout_n,
  output o_adc_sck,
  inout o_adc_sdio,
  output o_adc_cs,
  output o_adc_sync,

  output reg or_zmod_dac_relay,
  output o_zmod_adc_coupling_h_a,
  output o_zmod_adc_coupling_l_a,
  output o_zmod_adc_coupling_h_b,
  output o_zmod_adc_coupling_l_b,
  output o_zmod_adc_gain_h_a,
  output o_zmod_adc_gain_l_a,
  output o_zmod_adc_gain_h_b,
  output o_zmod_adc_gain_l_b,
  output o_zmod_adc_com_h,
  output o_zmod_adc_com_l,

  // output [7:0] o_ja,
  output reg [2:0] or3_led0,
  output reg [2:0] or3_led1
  );

  /* Clocking wizard signals */
  reg rst_1, rst;
  wire pll_locked;
  wire clk100mhz, clk50mhz;
  wire clk50mhz_ddr;

  /* output clock */

  /* Clock forwarding for DAC. Single anded clock */
  ODDR #(
  .DDR_CLK_EDGE("SAME_EDGE"),
  .INIT(1'b0),
  .SRTYPE("SYNC")
  )ODDR_CLKDAC(
  .Q(o_dac_clkout),
  .C(clk100mhz),
  .CE(1'b1),
  .D1(1'b0),
  .D2(1'b1),
  .R(rst),
  .S(1'b0)
  );

  ODDR #(
  .DDR_CLK_EDGE("SAME_EDGE"),
  .INIT(1'b0),
  .SRTYPE("SYNC")
  )ODDR_DCLKIO(
  .Q(o_dac_dclkio),
  .C(clk100mhz),
  .CE(1'b1),
  .D1(1'b0),
  .D2(1'b1),
  .R(rst),
  .S(1'b0)
  );

  /* Clock forwarding for ADC. Differential clock */
  ODDR #(
  .DDR_CLK_EDGE("SAME_EDGE"),
  .INIT(1'b0),
  .SRTYPE("SYNC")
  )ODDR_CLKADC(
  .Q(clk50mhz_ddr),
  .C(clk50mhz),
  .CE(1'b1),
  .D1(1'b0),
  .D2(1'b1),
  .R(rst),
  .S(1'b0)
  );

  OBUFDS #(
  .IOSTANDARD("DEFAULT"),
  .SLEW("SLOW")
  ) OBUFDS_CLKADC (
  .O(o_adc_clkout_p),
  .OB(o_adc_clkout_n),
  .I(clk50mhz_ddr)
  );

  /* adc data */
  wire [13:0] w14_data_a_adc, w14_data_b_adc;
  wire adc_configured;

  /* reset circuit */
  always @(posedge clk100mhz)
    if (pll_locked) begin
      rst_1 <= 1'b0;
      rst <= rst_1;
    end
    else begin
      rst_1 <= 1'b1;
      rst <= 1'b1;
    end

  /* led management */
  reg [25:0] r26_led_counter;

  always @(posedge clk100mhz)
    if (rst) begin
      or3_led0 <= 3'b000;
      or3_led1 <= 3'b000;
    end
    else begin
      r26_led_counter <= r26_led_counter + 24'd1;
      or3_led0 <= (r26_led_counter>2**25)? 3'b010:3'b100;
      or3_led1 <= {2'b00, adc_configured};
    end

  /* delay for enable output relay */
  reg [23:0] r24_relay_delay_counter;

  always @(posedge clk100mhz)
    if (rst) begin
      r24_relay_delay_counter <= 24'd0;
      or_zmod_dac_relay <= 1'b0;
    end
    else
      if (&r24_relay_delay_counter)
        or_zmod_dac_relay <= 1'b1;
      else
        r24_relay_delay_counter <= r24_relay_delay_counter + 24'd1;

  /* configure dac by gpio */
  assign o_dac_rst = 1'b1; /* SPI_MODE = OFF*/
  assign o_dac_sck = 1'b0; /* CLKIN = DCLKIO*/
  assign o_dac_cs = 1'b0; /* PWRDWN = 0 */
  assign o_dac_sdio = 1'b1; /* INPUT FORMAT = 2's complement */

  /* fullscale dac configuration */
  assign o_dac_fsadji = 1'b0;
  assign o_dac_fsadjq = 1'b0;

  /* Signal memory read */
  reg signed [13:0] m14_signal [127:0];
  reg signed [13:0] rs14_data2write;
  reg [6:0] r7_data_index;
  initial $readmemh("signal.mem", m14_signal);

  always @(posedge clk100mhz)
    if(rst) begin
      r7_data_index <= 7'd0;
      rs14_data2write <= 14'd0;
    end
    else begin
      r7_data_index <= r7_data_index+7'd1;
      rs14_data2write <= m14_signal[r7_data_index];
    end

  /* adc input configuration */
  assign o_zmod_adc_coupling_h_a = 1'b0;
  assign o_zmod_adc_coupling_l_a = 1'b1;
  assign o_zmod_adc_coupling_h_b = 1'b0;
  assign o_zmod_adc_coupling_l_b = 1'b1;
  assign o_zmod_adc_gain_h_a = 1'b0;
  assign o_zmod_adc_gain_l_a = 1'b1;
  assign o_zmod_adc_gain_h_b = 1'b0;
  assign o_zmod_adc_gain_l_b = 1'b1;
  assign o_adc_sync = 1'b0;
  assign o_zmod_adc_com_h = 1'b0;
  assign o_zmod_adc_com_l = 1'b1;

  clk_wiz_0 clk_wiz (
  .clk_out1(clk100mhz),
  .clk_out2(clk50mhz),
  .reset(1'b0),
  .locked(pll_locked),
  .clk_in1(clk125mhz)
  );

  zmod_dac_driver_v1_0 dac_zmod (
  .clk(clk100mhz),
  .rst(rst),
  .is14_data_i(rs14_data2write),
  .is14_data_q(w14_data_a_adc),
  .i_run(1'b1),
  .os14_data(o14_dac_data),
  .clk_spi(clk50mhz), /* spi_clk = clk_spi/4*/
  .rst_spi(1'b1),
  .or_sck(),
  .or_cs(),
  .o_sdo()
  );

  zmod_adc_driver_v1_0 adc_zmod(
  .clk(clk100mhz),
  .rst(rst),
  .o14_data_a(w14_data_a_adc),
  .o14_data_b(w14_data_b_adc),
  .o_adc_configured(adc_configured),
  .i14_data(i14_adc_data),
  .i_dco(i_adc_dco),
  .clk_spi(clk50mhz), /* spi_clk = clk_spi/4*/
  .or_sck(o_adc_sck),
  .or_cs(o_adc_cs),
  .o_sdio(o_adc_sdio)
  );
endmodule

/**
  Module name:  top_eclypse_xfft_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: Feb 2020
  Description: Top module for manage Ecypse board with xFFT IP.
  Revision: 1.0 Module created.
**/

module top_eclypse_xfft_v1_0 (
  input clk125mhz,/* 25Mhz input clock */

  output [13:0] o14_dac_data, /* Parallel DAC data out */
  output o_dac_clkout, /* DAC clock out */
  output o_dac_dclkio, /* DAC output select */
  output o_dac_fsadji, /* DAC full scale select for ch i out*/
  output o_dac_fsadjq, /* DAC full scale select for ch q out*/
  output o_dac_sck, /* DAC SPI clk out*/
  output o_dac_sdio, /* DAC SPI data IO out*/
  output o_dac_cs, /* DAC SPI cs out*/
  output o_dac_rst, /* DAC reset out*/

  input [13:0] i14_adc_data, /* Parallel ADC data in */
  input i_adc_dco, /* ADC data select input */
  output o_adc_clkout_p, /* ADC differential output clock p*/
  output o_adc_clkout_n, /* ADC differential output clock p*/
  output o_adc_sck, /* ADC SPI clk out */
  inout o_adc_sdio, /* ADC SPI data IO  */
  output o_adc_cs, /* ADC SPI cs out */
  output o_adc_sync, /* ADC SYNC out. SIgnal used for select configuration mode */

  output reg or_zmod_dac_relay, /* ZMOD DAC out relay */
  output o_zmod_adc_coupling_h_a, /* ZMOD ADC input coupling select for of channel A. Differential driver */
  output o_zmod_adc_coupling_l_a, /* ZMOD ADC input coupling select for of channel A. Differential driver */
  output o_zmod_adc_coupling_h_b, /* ZMOD ADC input coupling select for of channel B. Differential driver */
  output o_zmod_adc_coupling_l_b, /* ZMOD ADC input coupling select for of channel B. Differential driver */
  output o_zmod_adc_gain_h_a, /* ZMOD ADC input gain select for of channel A. Differential driver */
  output o_zmod_adc_gain_l_a, /* ZMOD ADC input gain select for of channel A. Differential driver */
  output o_zmod_adc_gain_h_b, /* ZMOD ADC input gain select for of channel B. Differential driver */
  output o_zmod_adc_gain_l_b, /* ZMOD ADC input gain select for of channel B. Differential driver */
  output o_zmod_adc_com_h, /* ZMOD ADC commom signal. Differential driver*/
  output o_zmod_adc_com_l, /* ZMOD ADC commom signal. Differential driver*/

  input i_rx, /* uart reception pin. Connected to PMOD A*/
  output o_tx, /* uart transmission pin. Connected to PMOD A*/
  output [2:0] o3_led0, /* Eclypse Z7 led 0*/
  output [2:0] o3_led1  /* Eclypse Z7 led 1*/
  );

  /* Clocking wizard signals */
  reg rst_1; /* Synchronizer reset signal */
  reg rst; /* Synchronizer reset signal */
  wire pll_locked; /* PLL locked signal */
  wire clk100mhz; /* 100mhz clock signal */
  wire clk50mhz; /* 50mhz clock signal */
  wire clk50mhz_ddr; /* 50mhz forwarded clock signal to out*/

  /* output clock */

  /* Clock forwarding for DAC. Single ended clock */
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
  wire [13:0] w14_data_a_adc; /* Channel A ADC data */
  wire [13:0] w14_data_b_adc; /* Channel B ADC data */
  wire adc_configured; /* Configuration done signal */

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
  // reg [25:0] r26_led_counter; /* Led blink prescaler */
  //
  // always @(posedge clk100mhz)
  //   if (rst) begin
  //     o3_led0 <= 3'b000;
  //     or3_led1 <= 3'b000;
  //   end
  //   else begin
  //     r26_led_counter <= r26_led_counter + 24'd1;
  //     o3_led0 <= (r26_led_counter>2**25)? 3'b010:3'b100;
  //     or3_led1 <= {2'b00, adc_configured};
  //   end

  /* delay for enable output relay */
  reg [23:0] r24_relay_delay_counter; /* Delay coungter to enable DAC output relay */

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
  assign o_zmod_adc_com_l = 1'b0;

  /* Uart data */
  /* md::
  This design is managed through uart conected to pmod A.
  ### uart input configuration frame:
  |byte0|byte1|byte2|byte3|byte4|byte5|
  |-|-|-|-|-|-|
  |command|address|data[31:24]|data[23:16]|data[15:8]|data[7:0]|

  ***command***
  - *8'h00*: NOP
  - *8'h01*: Write bram address.
  - *8'h02*: Read output bram.
  - *8'h10*: Start algorithm.
  - *8'h11*: Write CE prescaler
  - *8'h20*: Output off.

  ### uart output configuration frame:
  |byte0|byte1|byte2|byte3|byte4|byte5|
  |-|-|-|-|-|-|
  |status|address|data[31:24]|data[23:16]|data[15:8]|data[7:0]|

  ***status***
  - *8'h01*: Data output ready.
  - *8'h10*: Output state.
  */
  wire [47:0] w48_input_data_uart; /* Data input from uart */
  wire w_uart_data_valid;

  uart_rx_v1_0 #(
  .p_baudrate_prescaler(868), /* 115200 bps */
  .pw_baudrate_prescaler(10),
  .pw_parallel_input_width(48),
  .pw_index_width(6)
  ) uart_rx_inst0 (
  .clk(clk100mhz),
  .rstn(!rst),
  .op_data(w48_input_data_uart),
  .ip_data_frame_width(48),
  .o_data_valid(w_uart_data_valid),
  .i_rx(i_rx)
  );

  wire [47:0] w48_output_data_uart; /* Data input from uart */

  uart_tx_v1_0 #(
  .p_baudrate_prescaler(868),
  .pw_baudrate_prescaler(10),
  .pw_parallel_input_width(48),
  .pw_index_width(6)
  )uart_tx_inst0(
  .clk(clk100mhz),
  .rstn(!rst),
  .ip_data(32'h11223344),
  .ip_data_frame_width(32),
  .i_data_valid(w_uart_data_valid),
  .o_data_ready(),
  .or_tx(o_tx)
  );

  /* Main logic */
  reg [6:0] r7_write_add; /* Addres receied by uart to write */
  reg [31:0] r32_write_data; /* Data received by uart to write */
  reg [6:0] r7_read_add; /* Addres readed by module */
  wire [31:0] w32_read_data; /* Data readed by module */
  reg [31:0] r32_ce_prescaler; /* Prescaler for dac signal */
  reg r_write_enable; /* Write memory request */
  reg r_compute_enable; /* Data valid request*/
  wire m_data_valid; /* Transformation done */
  reg [13:0] r14_dac_data_i; /* Data to write on DAC */
  wire w_ce_dac; /* Clock enable for DAC read memory */

  always @(posedge clk50mhz)
    if (rst) begin
      r7_write_add <= 7'd0;
      r32_write_data <= 32'd0;
      r_write_enable <= 1'b0;
      r_compute_enable <= 1'b0;
      r32_ce_prescaler <= 32'd4;
    end
    else
      if (w_uart_data_valid && (w48_input_data_uart[47-:8] == 8'h01)) begin /* Write memory request received */
        r7_write_add <= w48_input_data_uart[39-:8];
        r32_write_data <= w48_input_data_uart[31-:32];
        r_write_enable <= 1'b1;
      end
      else if (w_uart_data_valid && (w48_input_data_uart[47-:8] == 8'h10)) begin /* Start transformation request received */
        r_compute_enable <= 1'b1;
      end
      else if (w_uart_data_valid && (w48_input_data_uart[47-:8] == 8'h11)) begin /* Start transformation request received */
        r32_ce_prescaler <= w48_input_data_uart[31-:32];
      end
      else begin
        r_compute_enable <= 1'b0;
        r_write_enable <= 1'b0;
      end

  clk_wiz_0 clk_wiz (
  .clk_out1(clk100mhz),
  .clk_out2(clk50mhz),
  .reset(1'b0),
  .locked(pll_locked),
  .clk_in1(clk125mhz)
  );

  bram2xfft2bram_v1_0 #(
  .p_fftfw_ninv(1'b1)
  ) bram2xfft2bram_inst0 (
  .clk(clk100mhz),
  .rstn(!rst),
  .i7_s_bram_s_add(r7_write_add),
  .i32_s_bram_data(r32_write_data),
  .i_s_bram_we(r_write_enable),
  .i_s_data_valid(r_compute_enable),
  .i7_m_bram_s_add(r7_read_add),
  .o32_m_bram_data(w32_read_data),
  .o_m_data_valid(m_data_valid)
  );

  assign o3_led0 = {2'b0, m_data_valid};
  assign o3_led1 = {2'b0, m_data_valid};

  cen_generator_v1_0 cen_generator_inst0(
  .clk(clk100mhz),
  .rstn(!rst),
  .i32_prescaler(r32_ce_prescaler),
  .or_cen(w_ce_dac)
  );

  /* Read bram and send data to DAC */
  always @(posedge clk100mhz)
    if (rst) begin
      r14_dac_data_i <= 14'd0;
      r7_read_add <= 7'd0;
    end
    else
      if (w_ce_dac) begin
        r7_read_add <= r7_read_add+7'd1;
        r14_dac_data_i <= w32_read_data[13:0];
      end

  zmod_dac_driver_v1_0 dac_zmod_inst0 (
  .clk(clk100mhz),
  .rst(rst),
  .is14_data_i(r14_dac_data_i),
  .is14_data_q(14'd0),
  .i_run(1'b1),
  .os14_data(o14_dac_data),
  .clk_spi(clk50mhz), /* spi_clk = clk_spi/4*/
  .rst_spi(1'b1),
  .or_sck(),
  .or_cs(),
  .o_sdo()
  );

  // zmod_adc_driver_v1_0 adc_zmod_inst0 (
  // .clk(clk100mhz),
  // .rst(rst),
  // .o14_data_a(w14_data_a_adc),
  // .o14_data_b(w14_data_b_adc),
  // .o_adc_configured(adc_configured),
  // .i14_data(i14_adc_data),
  // .i_dco(i_adc_dco),
  // .clk_spi(clk50mhz), /* spi_clk = clk_spi/4*/
  // .or_sck(o_adc_sck),
  // .or_cs(o_adc_cs),
  // .o_sdio(o_adc_sdio)
  // );
endmodule

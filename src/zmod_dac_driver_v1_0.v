/**
  Module name:  zmod_dac_driver
  Author: P Trujillo (pablo@controlpaths.com)
  Date: Feb 2020
  Description: Driver for ad9717. ZMOD DAC from Digilent
  Revision: 1.0 Module created.
**/

module zmod_dac_driver_v1_0 (
  input clk, /* Clock input. This signal is corresponding with sample frequency */
  input rst, /* Reset input */

  input signed [13:0] is14_data_i, /* Data for ch i*/
  input signed [13:0] is14_data_q, /* Data for ch q*/
  input i_run, /* DAC enable input */

  output signed [13:0] os14_data, /* Parallel DDR data for ADC*/

  input clk_spi, /* Clock input for SPI communication. clk_spi = clk_spi/4*/
  input rst_spi, /* DAC reset out*/
  output reg or_sck, /* DAC SPI clk out*/
  output reg or_cs, /* DAC SPI cs out*/
  output o_sdo /* DAC SPI data IO out*/
  );

  /* dac controller */
  reg r_dacrun; /* configuration done. DAC run signal. */
  reg r_spi_start; /* SPI start communication */
  reg [15:0] r16_data_out; /* SPI data out */

  /* dac configuration */
  always @(posedge clk)
    if (rst) begin
      r_spi_start <= 1'b0;
      r16_data_out <= 16'd0;
      r_dacrun <= 1'b0;
    end
    else begin
      r_spi_start <= 1'b0;
      r16_data_out <= 16'd0;
      r_dacrun <= i_run;
    end

  /* Output data management */
  generate for(genvar i=0; i<=13; i=i+1)
    ODDR #(
    .DDR_CLK_EDGE("OPPOSITE_EDGE"),
    .INIT(1'b0),
    .SRTYPE("SYNC")
    )ODDR_DACDATA(
    .Q(os14_data[i]),
    .C(clk),
    .CE(1'b1),
    .D1(is14_data_i[i]),
    .D2(is14_data_q[i]),
    .R(rst),
    .S(1'b0)
    );
  endgenerate

  /* SPI controller */
  reg [3:0] r4_spi_state; /* SPI communication state */
  reg [3:0] r4_data_counter; /* SPI data counter */

  always @(posedge clk_spi)
    if (rst_spi) begin
      r4_spi_state <= 3'd0;
      or_sck <= 1'b1;
      or_cs <= 1'b1;
      r4_data_counter <= 4'd15;
    end
    else
      case (r4_spi_state)
        3'd0: begin
          if (r_spi_start) r4_spi_state <= 3'd1;
          else r4_spi_state <= 3'd0;

          or_sck <= 1'b1;
          or_cs <= 1'b1;
          r4_data_counter <= 4'd15;
        end
        3'd1: begin
          r4_spi_state <= 3'd2;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
        end
        3'd2: begin
          r4_spi_state <= 3'd3;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
        end
        3'd3: begin
          r4_spi_state <= 3'd4;

          or_sck <= 1'b0;
          or_cs <= 1'b0;
        end
        3'd4: begin
          r4_spi_state <= 3'd5;

          or_sck <= 1'b0;
          or_cs <= 1'b0;
        end
        3'd5: begin
          r4_spi_state <= 3'd6;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
        end
        3'd6: begin
          if (r4_data_counter == 0) r4_spi_state <= 3'd0;
          else r4_spi_state <= 3'd3;

          or_sck <= 1'b1;
          or_cs <= 1'b0;
          r4_data_counter <= (r4_data_counter>0)? r4_data_counter-4'd1: 0;
        end
      endcase

  assign o_sdo = r16_data_out[r4_data_counter];


endmodule

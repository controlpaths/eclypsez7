/**
  Module name: uart_tx_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: May 2020
  Description: MOdule for implement uart protocol.
  Revision: 1.0 Module created.
**/

module uart_tx_v1_0 #(
  p_baudrate_prescaler = 869,    /* Baudrate prescaler according clk input*/
  pw_baudrate_prescaler = 10,    /* Baudrate prescaler counter width */
  pw_parallel_input_width = 32,  /* Width of maximum frame to send in bits */
  pw_index_width = 10  /* WIdth for the data index. Is corresponding with abs(log2(pw_parallel_input_width*8)+1) */
  )(
  input clk, /* Clock input */
  input rstn, /* Reset input*/

  input [pw_parallel_input_width-1:0] ip_data, /* Data to send */
  input [pw_index_width-1:0] ip_data_frame_width, /* Data to send in bits */
  input i_data_valid, /* Data in ip_data ready to send */
  output o_data_ready, /* Module ready to accept new data */
  output reg or_tx /* Transmission pin */
  );

  /* md::
  uart frame
  |start bit (falling edge)|data[7]|data[6]|data[5]|data[4]|data[3]|data[2]|data[1]|data[0]|stop bit (rising edge)|
  */

  /* Baudrate generator */
  wire w_baudrate_tick; /* Baudrate tick */
  reg [pw_baudrate_prescaler-1:0] rp_baudrate_counter; /* Counter for baudrate prescaler count */

  always @(posedge clk)
    if (!rstn || (r3_state == 3'd0)) rp_baudrate_counter <= 0;
    else rp_baudrate_counter <= (rp_baudrate_counter<p_baudrate_prescaler)? rp_baudrate_counter+1:0;

  assign w_baudrate_tick = (rp_baudrate_counter==p_baudrate_prescaler)? 1'b1: 1'b0;

  /* Module fsm */
  reg [2:0] r3_state; /* State for uart fsm */
  reg [pw_index_width-1:0] rp_data_index; /* Data index to send */
  reg [pw_parallel_input_width-1:0] rp_data; /* Data to send registered */
  reg [2:0] r3_nbit;
  reg [7:0] r8_byte2send;

  always @(posedge clk)
    if (!rstn) begin
      r3_state <= 3'b000;
      rp_data_index <= 0;
      r8_byte2send <= 8'd0;
      r3_nbit <= 3'd0;
      or_tx <= 1'b1;
    end
    else
      case (r3_state)
        3'b000: begin
          if (i_data_valid) r3_state <= 3'b001;
          else r3_state <= 3'b000;

          rp_data_index <= ip_data_frame_width;
          r8_byte2send <= rp_data[rp_data_index-1-:8];
          rp_data <= ip_data;
          r3_nbit <= 3'd0;
          or_tx <= 1'b1;
        end
        3'b001: begin /* Start bit */
          if (w_baudrate_tick) r3_state <= 3'b010;
          else r3_state <= 3'b001;

          r8_byte2send <= rp_data[rp_data_index-1-:8];
          or_tx <= 1'b0;
        end
        3'b010: begin
          r3_state <= 3'b011;

          or_tx <= r8_byte2send[r3_nbit];
          r3_nbit <= r3_nbit+1;
        end
        3'b011: begin
          if (w_baudrate_tick && (r3_nbit != 3'd0)) r3_state <= 3'b010;
          else if (w_baudrate_tick && (r3_nbit == 3'd0)) r3_state <= 3'b100;
          else r3_state <= 3'b011;

        end
        3'b100: begin /* Stop bit 1*/
          if (w_baudrate_tick && (rp_data_index == 8)) r3_state <= 3'b000;
          else if (w_baudrate_tick && (rp_data_index >= 8)) r3_state <= 3'b001;
          else r3_state <= 3'b100;

          or_tx <= 1'b1;
          rp_data_index <= w_baudrate_tick? rp_data_index-8: rp_data_index;
        end
      endcase

  assign o_data_ready = (r3_state > 0)? 1'b0: 1'b1;

endmodule

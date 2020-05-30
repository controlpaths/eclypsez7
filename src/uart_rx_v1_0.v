/**
  Module name: uart_rx_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: May 2020
  Description: Module for implement RS232 protocol.
  Revision: 1.0 Module created.
**/

module uart_rx_v1_0 #(
  p_baudrate_prescaler = 869,    /* Baudrate prescaler according clk input*/
  pw_baudrate_prescaler = 10,    /* Baudrate prescaler counter width */
  pw_parallel_input_width = 32,  /* Width of maximum frame to send in bits */
  pw_index_width = 10  /* WIdth for the data index. Is corresponding with abs(log2(pw_parallel_input_width*8)+1) */
  )(
  input clk, /* Clock input */
  input rstn, /* Reset input*/

  output reg [pw_parallel_input_width-1:0] op_data, /* Data received */
  input [pw_index_width-1:0] ip_data_frame_width, /* Data to receive in bits */
  output reg o_data_valid, /* Data in op_data ready to read */
  input i_rx /* Reception pin */
  );

  /* md::
  RS232 frame
  |start bit (falling edge)|data[7]|data[6]|data[5]|data[4]|data[3]|data[2]|data[1]|data[0]|stop bit (rising edge)|
  */

  /* Baudrate generator */
  wire w_baudrate_tick; /* Baudrate tick */
  reg [pw_baudrate_prescaler-1:0] rp_baudrate_counter; /* Counter for baudrate prescaler count */

  always @(posedge clk)
    if (!rstn || (r4_state == 3'd0)) rp_baudrate_counter <= p_baudrate_prescaler>>1;
    else rp_baudrate_counter <= (rp_baudrate_counter<p_baudrate_prescaler)? rp_baudrate_counter+1:0;

  assign w_baudrate_tick = (rp_baudrate_counter==p_baudrate_prescaler)? 1'b1: 1'b0;

  /* Module fsm */
  reg [3:0] r4_state; /* State for rs232 fsm */
  reg [pw_index_width-1:0] rp_data_index; /* Data index to send */
  reg [pw_parallel_input_width-1:0] rp_data; /* Data to send registered */
  reg [7:0] r8_byte_received; /* Last byte received */
  reg [2:0] r3_nbit;

  always @(posedge clk)
    if (!rstn) begin
      r4_state <= 4'b0000;
      rp_data_index <= 0;
      r3_nbit <= 3'd0;
      op_data <= 0;
      o_data_valid <= 1'b0;
    end
    else
      case (r4_state)
        4'b0000: begin
          if (!i_rx) r4_state <= 4'b0111;
          else r4_state <= 4'b0000;

          rp_data_index <= ip_data_frame_width;
          rp_data <= 0;
          r3_nbit <= 3'd0;
          o_data_valid <= 1'b0;
        end
        4'b0111: begin
          if (w_baudrate_tick) r4_state <= 4'b0001;
          else r4_state <= 4'b0111;

        end
        4'b0001: begin /* Start bit */
          if (w_baudrate_tick) r4_state <= 4'b0010;
          else r4_state <= 4'b0001;

        end
        4'b0010: begin
          r4_state <= 4'b0011;

          r8_byte_received[r3_nbit] <= i_rx;
          r3_nbit <= r3_nbit+1;
        end
        4'b0011: begin
          if (w_baudrate_tick && (r3_nbit != 3'd0)) r4_state <= 4'b0010;
          else if (w_baudrate_tick && (r3_nbit == 3'd0)) r4_state <= 4'b0100;
          else r4_state <= 4'b0011;

        end
        4'b0100: begin /* Stop bit 1*/
          if (w_baudrate_tick) r4_state <= 4'b0110;
          else r4_state <= 4'b0100;


        end
        4'b0110: begin
          if (rp_data_index == 8) r4_state <= 4'b0101;
          else if ((rp_data_index > 8) && !i_rx) r4_state <= 4'b1000;
          else r4_state <= 4'b0110;

          rp_data[rp_data_index-1-:8] <= r8_byte_received;
        end
        4'b1000: begin
          r4_state <= 4'b0001;

          rp_data_index <= rp_data_index-8;
        end
        4'b0101: begin
          r4_state <= 4'b0000;

          o_data_valid <= 1'b1;
          op_data <= rp_data;
        end
      endcase

endmodule

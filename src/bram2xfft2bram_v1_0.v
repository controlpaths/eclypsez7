`timescale 10ns/10ps
/**
  Module name:  xfft_simu
  Author: P Trujillo (pablo@controlpaths.com)
  Date: May 2020
  Description: Module for manage xfft with 2 brams. 128 points, 14 bit
  Revision: 1.0 Module created.
**/

module bram2xfft2bram_v1_0 #(
  parameter p_fftfw_ninv = 1'b1
  )(
  input clk,
  input rstn,

  input [6:0] i7_s_bram_s_add, /* Input bram address */
  input [31:0] i32_s_bram_data, /* Input bram data */
  input i_s_bram_we, /* Input bram write enable */
  input i_s_data_valid, /* Indicates input memory is fullfill */

  input [6:0] i7_m_bram_s_add, /* Output bram addredd*/
  output reg [31:0] o32_m_bram_data, /* Output bram data*/
  output reg o_m_data_valid  /* Indicates output memory is ready to read */
  );

  /* Memories inference */
  reg [31:0] m32x128_input [0:127]; /* Input memory */
  reg [6:0] r7_input_index;
  reg [31:0] m32x128_output [0:127]; /* Output memory */
  reg [6:0] r7_output_index;

  initial begin
    $readmemh("128zeros.mem", m32x128_input);
    $readmemh("128zeros.mem", m32x128_output);
  end

  /* State machine signals */
  reg [2:0] st3_state; /* State machine state*/

  /* xfft signals */
  reg [7:0] s_axis_config_tdata_0;
  reg s_axis_config_tvalid_0;
  wire s_axis_config_tready_0;
  reg [31:0] s_axis_data_tdata_0;
  reg s_axis_data_tvalid_0;
  wire s_axis_data_tready_0;
  reg s_axis_data_tlast_0;
  wire [47:0] m_axis_data_tdata_0;
  wire m_axis_data_tvalid_0;
  reg m_axis_data_tready_0;
  wire m_axis_data_tlast_0;
  wire event_frame_started_0;
  wire event_tlast_unexpected_0;
  wire event_tlast_missing_0;
  wire event_status_channel_halt_0;
  wire event_data_in_channel_halt_0;
  wire event_data_out_channel_halt_0;

  wire [15:0] debug;

  assign debug = m_axis_data_tdata_0[15:0];

  /* input memory fill */
  always @(posedge clk)
    if (i_s_bram_we)
      m32x128_input[i7_s_bram_s_add] <= i32_s_bram_data;

  /* Output memory read*/
  always @(posedge clk)
    if (!rstn)
      o32_m_bram_data <= 32'd0;
    else
      o32_m_bram_data <= m32x128_output[i7_m_bram_s_add];

  /* Main state machine */
  always @(posedge clk)
    if (!rstn) begin
      st3_state <= 3'd0;
      /* Config signals */
      s_axis_config_tdata_0 <= 8'd0;
      s_axis_config_tvalid_0 <= 1'b0;
      /* slave signals */
      s_axis_data_tdata_0 <= 32'd0;
      s_axis_data_tvalid_0 <= 1'b0;
      s_axis_data_tlast_0 <= 1'b0;
      /* Master signals */
      m_axis_data_tready_0 <= 1'b0;
      /* Memories indexes */
      r7_input_index <= 7'd0;
      r7_output_index <= 7'd0;
      /* Module control signals */
      o_m_data_valid <= 1'b0;
    end
    else
      case (st3_state)
        3'd0: begin
          if (s_axis_config_tready_0) st3_state <= 3'd1;
          else st3_state <= 3'd0;

          /* Config signals */
          s_axis_config_tdata_0 <= {7'd0, p_fftfw_ninv}; /* pag[7:1], fft_fwd[1] */
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b0;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= 7'd0;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
        end
        3'd1: begin
          st3_state <= 3'd2;

          /* Config signals */
          s_axis_config_tdata_0 <= {7'd0, 1'b1}; /* pag[7:1], fft_fwd[1] */
          s_axis_config_tvalid_0 <= 1'b1;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b0;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= 7'd0;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
        end
        3'd2: begin
          if (i_s_data_valid && s_axis_data_tready_0) st3_state <= 3'd3;
          else st3_state <= 3'd2;

          /* Config signals */
          s_axis_config_tdata_0 <= 8'd0;
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b0;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= 7'd0;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
        end
        3'd3: begin
          if (&r7_input_index) st3_state <= 3'd4;
          else st3_state <= 3'd3;

          /* Config signals */
          s_axis_config_tdata_0 <= 8'd0;
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= m32x128_input[r7_input_index];
          s_axis_data_tvalid_0 <= 1'b1;
          s_axis_data_tlast_0 <= &r7_input_index;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b0;
          /* Memories indexes */
          r7_input_index <= r7_input_index + 7'd1;
          r7_output_index <= 7'd0;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
        end
        3'd4: begin
          if (m_axis_data_tvalid_0) st3_state <= 3'd5;
          else st3_state <= 3'd4;

          /* Config signals */
          s_axis_config_tdata_0 <= 8'd0;
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b0;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= 7'd0;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
        end
        3'd5: begin
          if (m_axis_data_tlast_0) st3_state <= 3'd6;
          else st3_state <= 3'd5;

          /* Config signals */
          s_axis_config_tdata_0 <= 8'd0;
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b1;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= r7_output_index + 7'd1;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
          /* Output memory fill */
          m32x128_output[r7_output_index] <= {m_axis_data_tdata_0[29:16], m_axis_data_tdata_0[15:0]};
        end
        3'd6: begin
          if (!m_axis_data_tlast_0) st3_state <= 3'd7;
          else st3_state <= 3'd6;

          /* Config signals */
          s_axis_config_tdata_0 <= 8'd0;
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b1;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= r7_output_index + 7'd1;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
          /* Output memory fill */
          m32x128_output[r7_output_index] <= m_axis_data_tdata_0;
        end
        3'd7: begin
          st3_state <= 3'd2;

          /* Config signals */
          s_axis_config_tdata_0 <= 8'd0;
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b1;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= r7_output_index + 7'd1;
          /* Module control signals */
          o_m_data_valid <= 1'b1;
        end
        default: begin
          st3_state <= 3'd0;

          /* Config signals */
          s_axis_config_tdata_0 <= {7'd0, 1'b1}; /* pag[7:1], fft_fwd[1] */
          s_axis_config_tvalid_0 <= 1'b0;
          /* slave signals */
          s_axis_data_tdata_0 <= 32'd0;
          s_axis_data_tvalid_0 <= 1'b0;
          s_axis_data_tlast_0 <= 1'b0;
          /* Master signals */
          m_axis_data_tready_0 <= 1'b0;
          /* Memories indexes */
          r7_input_index <= 7'd0;
          r7_output_index <= 7'd0;
          /* Module control signals */
          o_m_data_valid <= 1'b0;
        end
      endcase

  xfft_0 xfft_inst0 (
  .aclk(clk), /* input wire aclk */
  .aresetn(rstn), /* input wire aresetn */
  .s_axis_config_tdata(s_axis_config_tdata_0), /* input wire [7 : 0] s_axis_config_tdata */
  .s_axis_config_tvalid(s_axis_config_tvalid_0), /* input wire s_axis_config_tvalid */
  .s_axis_config_tready(s_axis_config_tready_0), /* output wire s_axis_config_tready */
  .s_axis_data_tdata(s_axis_data_tdata_0), /* input wire [31 : 0] s_axis_data_tdata */
  .s_axis_data_tvalid(s_axis_data_tvalid_0), /* input wire s_axis_data_tvalid */
  .s_axis_data_tready(s_axis_data_tready_0), /* output wire s_axis_data_tready */
  .s_axis_data_tlast(s_axis_data_tlast_0), /* input wire s_axis_data_tlast */
  .m_axis_data_tdata(m_axis_data_tdata_0), /* output wire [47 : 0] m_axis_data_tdata */
  .m_axis_data_tvalid(m_axis_data_tvalid_0), /* output wire m_axis_data_tvalid */
  .m_axis_data_tready(m_axis_data_tready_0), /* input wire m_axis_data_tready */
  .m_axis_data_tlast(m_axis_data_tlast_0), /* output wire m_axis_data_tlast */
  .event_frame_started(event_frame_started_0), /* output wire event_frame_started */
  .event_tlast_unexpected(event_tlast_unexpected_0), /* output wire event_tlast_unexpected */
  .event_tlast_missing(event_tlast_missing_0), /* output wire event_tlast_missing */
  .event_status_channel_halt(event_status_channel_halt_0), /* output wire event_status_channel_halt */
  .event_data_in_channel_halt(event_data_in_channel_halt_0), /* output wire event_data_in_channel_halt */
  .event_data_out_channel_halt(event_data_out_channel_halt_0)  /* output wire event_data_out_channel_halt */
  );

endmodule

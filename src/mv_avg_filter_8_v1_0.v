/**
  Module name:  mv_avg_filter_8_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: Aug 2020
  Description: 8th order moving average filter
  Revision: 1.0 Module created.
**/

module mv_avg_filter_8_v1_0 (
  input clk,
  input rst,

  input [31:0] i32_prescaler,

  input signed [13:0] is14_data,
  output signed [13:0] os14_data
  );

  reg [31:0] r32_prescaler_counter; /* Counter for prescaler */

  reg signed [14:0] rs14_pipe1; /* Pipeline register */
  reg signed [14:0] rs14_pipe2; /* Pipeline register */
  reg signed [14:0] rs14_pipe3; /* Pipeline register */
  reg signed [14:0] rs14_pipe4; /* Pipeline register */
  reg signed [14:0] rs14_pipe5; /* Pipeline register */
  reg signed [14:0] rs14_pipe6; /* Pipeline register */
  reg signed [14:0] rs14_pipe7; /* Pipeline register */
  reg signed [14:0] rs14_pipe8; /* Pipeline register */

  always @(posedge clk)
    if (rst) begin
      rs14_pipe1 <= 14'd0;
      rs14_pipe2 <= 14'd0;
      rs14_pipe3 <= 14'd0;
      rs14_pipe4 <= 14'd0;
      rs14_pipe5 <= 14'd0;
      rs14_pipe6 <= 14'd0;
      rs14_pipe7 <= 14'd0;
      rs14_pipe8 <= 14'd0;

      r32_prescaler_counter <= 32'd0;
    end
    else
      if (r32_prescaler_counter >= i32_prescaler) begin
        rs14_pipe1 <= is14_data;
        rs14_pipe2 <= rs14_pipe1;
        rs14_pipe3 <= rs14_pipe2;
        rs14_pipe4 <= rs14_pipe3;
        rs14_pipe5 <= rs14_pipe4;
        rs14_pipe6 <= rs14_pipe5;
        rs14_pipe7 <= rs14_pipe6;
        rs14_pipe8 <= rs14_pipe7;
        r32_prescaler_counter <= 0;
      end
      else
        r32_prescaler_counter <= r32_prescaler_counter+32'd1;


  assign os14_data = (rs14_pipe1>>>3) + (rs14_pipe2>>>3) + (rs14_pipe3>>>3) + (rs14_pipe4>>>3) +
                      (rs14_pipe5>>>3) + (rs14_pipe6>>>3) + (rs14_pipe7>>>3) + (rs14_pipe8>>>3);


endmodule

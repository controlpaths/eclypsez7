/**
  Module name:  signal_bram_reader_1k_v1_0
  Author: P Trujillo (pablo@controlpaths.com)
  Date: May 2020
  Description: Module for read a signal stored in 1k bram.
  Revision: 1.0 Module created
**/

module signal_bram_reader_1k_v1_0 (
  input clk, /* Input clock signal */
  input rstn, /* Input reset signal */
  input ce, /* Clock enable signal.*/

  output reg [13:0] o14_signal /* 14 bit output signal. */
  );

  reg [13:0] m14x1024_signal_memory [1023:0]; /* Memory for store signal. ROM infered */

  initial $readmemh("signal2.mem", m14x1024_signal_memory); /* Initialise memory with signal.mem file */

  reg [9:0] r10_mem_index; /* Read index for bram */

  always @(posedge clk)
    if (!rstn) begin
      r10_mem_index <= 10'd0;
      o14_signal <= 14'd0;
    end
    else
      if (ce) begin
        r10_mem_index <= r10_mem_index+10'b1;
        o14_signal <= m14x1024_signal_memory[r10_mem_index];
      end

endmodule

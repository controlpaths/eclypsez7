
`timescale 1 ns / 1 ps

	module axi_fir32_14b_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 8
	)
	(
		// Users to add ports here
		input signed [13:0] is14_input,
		output signed [13:0] os14_output,
		input ce,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready
	);

	wire signed [31:0] ws32_coeff_0;
	wire signed [31:0] ws32_coeff_1;
	wire signed [31:0] ws32_coeff_2;
	wire signed [31:0] ws32_coeff_3;
	wire signed [31:0] ws32_coeff_4;
	wire signed [31:0] ws32_coeff_5;
	wire signed [31:0] ws32_coeff_6;
	wire signed [31:0] ws32_coeff_7;
	wire signed [31:0] ws32_coeff_8;
	wire signed [31:0] ws32_coeff_9;
	wire signed [31:0] ws32_coeff_10;
	wire signed [31:0] ws32_coeff_11;
	wire signed [31:0] ws32_coeff_12;
	wire signed [31:0] ws32_coeff_13;
	wire signed [31:0] ws32_coeff_14;
	wire signed [31:0] ws32_coeff_15;
	wire signed [31:0] ws32_coeff_16;
	wire signed [31:0] ws32_coeff_17;
	wire signed [31:0] ws32_coeff_18;
	wire signed [31:0] ws32_coeff_19;
	wire signed [31:0] ws32_coeff_20;
	wire signed [31:0] ws32_coeff_21;
	wire signed [31:0] ws32_coeff_22;
	wire signed [31:0] ws32_coeff_23;
	wire signed [31:0] ws32_coeff_24;
	wire signed [31:0] ws32_coeff_25;
	wire signed [31:0] ws32_coeff_26;
	wire signed [31:0] ws32_coeff_27;
	wire signed [31:0] ws32_coeff_28;
	wire signed [31:0] ws32_coeff_29;
	wire signed [31:0] ws32_coeff_30;
	wire signed [31:0] ws32_coeff_31;
	wire signed [31:0] ws32_coeff_32;

// Instantiation of Axi Bus Interface S00_AXI
	axi_fir32_14b_v1_0_S00_AXI # (
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) axi_fir32_14b_v1_0_S00_AXI_inst (
		.slv_reg0(ws32_coeff_0),
		.slv_reg1(ws32_coeff_1),
		.slv_reg2(ws32_coeff_2),
		.slv_reg3(ws32_coeff_3),
		.slv_reg4(ws32_coeff_4),
		.slv_reg5(ws32_coeff_5),
		.slv_reg6(ws32_coeff_6),
		.slv_reg7(ws32_coeff_7),
		.slv_reg8(ws32_coeff_8),
		.slv_reg9(ws32_coeff_9),
		.slv_reg10(ws32_coeff_10),
		.slv_reg11(ws32_coeff_11),
		.slv_reg12(ws32_coeff_12),
		.slv_reg13(ws32_coeff_13),
		.slv_reg14(ws32_coeff_14),
		.slv_reg15(ws32_coeff_15),
		.slv_reg16(ws32_coeff_16),
		.slv_reg17(ws32_coeff_17),
		.slv_reg18(ws32_coeff_18),
		.slv_reg19(ws32_coeff_19),
		.slv_reg20(ws32_coeff_20),
		.slv_reg21(ws32_coeff_21),
		.slv_reg22(ws32_coeff_22),
		.slv_reg23(ws32_coeff_23),
		.slv_reg24(ws32_coeff_24),
		.slv_reg25(ws32_coeff_25),
		.slv_reg26(ws32_coeff_26),
		.slv_reg27(ws32_coeff_27),
		.slv_reg28(ws32_coeff_28),
		.slv_reg29(ws32_coeff_29),
		.slv_reg30(ws32_coeff_30),
		.slv_reg31(ws32_coeff_31),
		.slv_reg32(ws32_coeff_32),
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here
	fir32_14b_v1_0 uut_32 (
	.clk(s00_axi_aclk),
	.rstn(s00_axi_aresetn),
	.ce(ce),
	.is32_coeff_0(ws32_coeff_0), /* FIR filter coefficient*/
	.is32_coeff_1(ws32_coeff_1), /* FIR filter coefficient*/
	.is32_coeff_2(ws32_coeff_2), /* FIR filter coefficient*/
	.is32_coeff_3(ws32_coeff_3), /* FIR filter coefficient*/
	.is32_coeff_4(ws32_coeff_4), /* FIR filter coefficient*/
	.is32_coeff_5(ws32_coeff_5), /* FIR filter coefficient*/
	.is32_coeff_6(ws32_coeff_6), /* FIR filter coefficient*/
	.is32_coeff_7(ws32_coeff_7), /* FIR filter coefficient*/
	.is32_coeff_8(ws32_coeff_8), /* FIR filter coefficient*/
	.is32_coeff_9(ws32_coeff_9), /* FIR filter coefficient*/
	.is32_coeff_10(ws32_coeff_10), /* FIR filter coefficient*/
	.is32_coeff_11(ws32_coeff_11), /* FIR filter coefficient*/
	.is32_coeff_12(ws32_coeff_12), /* FIR filter coefficient*/
	.is32_coeff_13(ws32_coeff_13), /* FIR filter coefficient*/
	.is32_coeff_14(ws32_coeff_14), /* FIR filter coefficient*/
	.is32_coeff_15(ws32_coeff_15), /* FIR filter coefficient*/
	.is32_coeff_16(ws32_coeff_16), /* FIR filter coefficient*/
	.is32_coeff_17(ws32_coeff_17), /* FIR filter coefficient*/
	.is32_coeff_18(ws32_coeff_18), /* FIR filter coefficient*/
	.is32_coeff_19(ws32_coeff_19), /* FIR filter coefficient*/
	.is32_coeff_20(ws32_coeff_20), /* FIR filter coefficient*/
	.is32_coeff_21(ws32_coeff_21), /* FIR filter coefficient*/
	.is32_coeff_22(ws32_coeff_22), /* FIR filter coefficient*/
	.is32_coeff_23(ws32_coeff_23), /* FIR filter coefficient*/
	.is32_coeff_24(ws32_coeff_24), /* FIR filter coefficient*/
	.is32_coeff_25(ws32_coeff_25), /* FIR filter coefficient*/
	.is32_coeff_26(ws32_coeff_26), /* FIR filter coefficient*/
	.is32_coeff_27(ws32_coeff_27), /* FIR filter coefficient*/
	.is32_coeff_28(ws32_coeff_28), /* FIR filter coefficient*/
	.is32_coeff_29(ws32_coeff_29), /* FIR filter coefficient*/
	.is32_coeff_30(ws32_coeff_30), /* FIR filter coefficient*/
	.is32_coeff_31(ws32_coeff_31), /* FIR filter coefficient*/
	.is32_coeff_32(ws32_coeff_32), /* FIR filter coefficient*/
	.is14_in(is14_input), /* Filter input */
	.os14_out(os14_output) /* Filter output */
	);
	// User logic ends

	endmodule


`timescale 1 ns / 1 ps

	module axi_fir8_14b_v1_0 #
	(
		// Users to add parameters here

		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 6
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
	wire signed [31:0] ws32_coeff0;
	wire signed [31:0] ws32_coeff1;
	wire signed [31:0] ws32_coeff2;
	wire signed [31:0] ws32_coeff3;
	wire signed [31:0] ws32_coeff4;
	wire signed [31:0] ws32_coeff5;
	wire signed [31:0] ws32_coeff6;
	wire signed [31:0] ws32_coeff7;
	wire signed [31:0] ws32_coeff8;

// Instantiation of Axi Bus Interface S00_AXI
	axi_fir8_14b_v1_0_S00_AXI # (
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) axi_fir8_14b_v1_0_S00_AXI_inst (
		.slv_reg0(ws32_coeff0),
		.slv_reg1(ws32_coeff1),
		.slv_reg2(ws32_coeff2),
		.slv_reg3(ws32_coeff3),
		.slv_reg4(ws32_coeff4),
		.slv_reg5(ws32_coeff5),
		.slv_reg6(ws32_coeff6),
		.slv_reg7(ws32_coeff7),
		.slv_reg8(ws32_coeff8),
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
    fir8_14b_v1_0 fir8_14b_inst0 (
    .clk(s00_axi_aclk),
    .rstn(s00_axi_aresetn),
    .ce(ce),
    .is32_coeff_0(ws32_coeff0),
    .is32_coeff_1(ws32_coeff1),
    .is32_coeff_2(ws32_coeff2),
    .is32_coeff_3(ws32_coeff3),
    .is32_coeff_4(ws32_coeff4),
    .is32_coeff_5(ws32_coeff5),
    .is32_coeff_6(ws32_coeff6),
    .is32_coeff_7(ws32_coeff7),
    .is32_coeff_8(ws32_coeff8),
    .is14_in(is14_input),
    .os14_out(os14_output)
    );
	// User logic ends

	endmodule

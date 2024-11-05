/*
 * Copyright (c) 2024 Sylvain Munaut
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module control (
	// Power
    input  wire       VGND,
    input  wire       VDPWR,    // 1.8v power supply

	// User interface
	input  wire [6:0] usr_addr_in,
	input  wire       usr_addr_hi_clk,
	input  wire       usr_addr_lo_clk,
	input  wire       usr_addr_clk,
	input  wire       usr_data_clk,
	output wire [9:0] usr_data_out,
	input  wire [1:0] usr_data_sel,

	// ROM interface
	output wire [13:0] rom_addr_out,
	input  wire  [9:0] rom_data0_in,
	input  wire  [9:0] rom_data1_in,
	input  wire  [9:0] rom_data2_in
);

	// Note this verilog is for netgen LVS
	// so we can't use advanced verilog constructs ...


	// Signals
	// -------

	// Clocks
	wire addr_hi_clk;
	wire addr_lo_clk;
	wire addr_clk;
	wire data_clk;

	// Pre-load register
	wire [13:0] addr_pre;

	// Address register
	wire [13:0] addr;

	// Mux
	wire [9:0] mux_ref;
	wire [9:0] mux_out;


	// Clock buffers
	// -------------

	sky130_fd_sc_hd__clkbuf_8 addr_hi_clkbuf_I (
		.X    (addr_hi_clk),
		.A    (usr_addr_hi_clk),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_lo_clkbuf_I (
		.X    (addr_lo_clk),
		.A    (usr_addr_lo_clk),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_clkbuf_I (
		.X    (addr_clk),
		.A    (usr_addr_clk),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 data_clkbuf_I (
		.X    (data_clk),
		.A    (usr_data_clk),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);


	// Address preload registers
	// -------------------------

	// [6:0]
	sky130_fd_sc_hd__dfxtp_2 addr_pre_0_I (
		.Q    (addr_pre[0]),
		.CLK  (addr_lo_clk),
		.D    (usr_addr_in[0]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_1_I (
		.Q    (addr_pre[1]),
		.CLK  (addr_lo_clk),
		.D    (usr_addr_in[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_2_I (
		.Q    (addr_pre[2]),
		.CLK  (addr_lo_clk),
		.D    (usr_addr_in[2]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_3_I (
		.Q    (addr_pre[3]),
		.CLK  (addr_lo_clk),
		.D    (usr_addr_in[3]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_4_I (
		.Q    (addr_pre[4]),
		.CLK  (addr_lo_clk),
		.D    (usr_addr_in[4]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_5_I (
		.Q    (addr_pre[5]),
		.CLK  (addr_lo_clk),
		.D    (usr_addr_in[5]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_6_I (
		.Q    (addr_pre[6]),
		.CLK  (addr_lo_clk),
		.D    (usr_addr_in[6]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	// [13:7]
	sky130_fd_sc_hd__dfxtp_2 addr_pre_7_I (
		.Q    (addr_pre[7]),
		.CLK  (addr_hi_clk),
		.D    (usr_addr_in[0]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_8_I (
		.Q    (addr_pre[8]),
		.CLK  (addr_hi_clk),
		.D    (usr_addr_in[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_9_I (
		.Q    (addr_pre[9]),
		.CLK  (addr_hi_clk),
		.D    (usr_addr_in[2]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_10_I (
		.Q    (addr_pre[10]),
		.CLK  (addr_hi_clk),
		.D    (usr_addr_in[3]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_11_I (
		.Q    (addr_pre[11]),
		.CLK  (addr_hi_clk),
		.D    (usr_addr_in[4]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_12_I (
		.Q    (addr_pre[12]),
		.CLK  (addr_hi_clk),
		.D    (usr_addr_in[5]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_pre_13_I (
		.Q    (addr_pre[13]),
		.CLK  (addr_hi_clk),
		.D    (usr_addr_in[6]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);


	// Address register
	// ----------------

	sky130_fd_sc_hd__dfxtp_2 addr_0_I (
		.Q    (addr[0]),
		.CLK  (addr_clk),
		.D    (addr_pre[0]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_1_I (
		.Q    (addr[1]),
		.CLK  (addr_clk),
		.D    (addr_pre[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_2_I (
		.Q    (addr[2]),
		.CLK  (addr_clk),
		.D    (addr_pre[2]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_3_I (
		.Q    (addr[3]),
		.CLK  (addr_clk),
		.D    (addr_pre[3]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_4_I (
		.Q    (addr[4]),
		.CLK  (addr_clk),
		.D    (addr_pre[4]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_5_I (
		.Q    (addr[5]),
		.CLK  (addr_clk),
		.D    (addr_pre[5]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_6_I (
		.Q    (addr[6]),
		.CLK  (addr_clk),
		.D    (addr_pre[6]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_7_I (
		.Q    (addr[7]),
		.CLK  (addr_clk),
		.D    (addr_pre[7]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_8_I (
		.Q    (addr[8]),
		.CLK  (addr_clk),
		.D    (addr_pre[8]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_9_I (
		.Q    (addr[9]),
		.CLK  (addr_clk),
		.D    (addr_pre[9]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_10_I (
		.Q    (addr[10]),
		.CLK  (addr_clk),
		.D    (addr_pre[10]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_11_I (
		.Q    (addr[11]),
		.CLK  (addr_clk),
		.D    (addr_pre[11]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_12_I (
		.Q    (addr[12]),
		.CLK  (addr_clk),
		.D    (addr_pre[12]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 addr_13_I (
		.Q    (addr[13]),
		.CLK  (addr_clk),
		.D    (addr_pre[13]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);


	// Address output buffer
	// ---------------------

	sky130_fd_sc_hd__clkbuf_8 addr_0_buf_I (
		.X    (rom_addr_out[0]),
		.A    (addr[0]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_1_buf_I (
		.X    (rom_addr_out[1]),
		.A    (addr[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_2_buf_I (
		.X    (rom_addr_out[2]),
		.A    (addr[2]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_3_buf_I (
		.X    (rom_addr_out[3]),
		.A    (addr[3]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_4_buf_I (
		.X    (rom_addr_out[4]),
		.A    (addr[4]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_5_buf_I (
		.X    (rom_addr_out[5]),
		.A    (addr[5]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_6_buf_I (
		.X    (rom_addr_out[6]),
		.A    (addr[6]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_7_buf_I (
		.X    (rom_addr_out[7]),
		.A    (addr[7]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_8_buf_I (
		.X    (rom_addr_out[8]),
		.A    (addr[8]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_9_buf_I (
		.X    (rom_addr_out[9]),
		.A    (addr[9]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_10_buf_I (
		.X    (rom_addr_out[10]),
		.A    (addr[10]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_11_buf_I (
		.X    (rom_addr_out[11]),
		.A    (addr[11]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_12_buf_I (
		.X    (rom_addr_out[12]),
		.A    (addr[12]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__clkbuf_8 addr_13_buf_I (
		.X    (rom_addr_out[13]),
		.A    (addr[13]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);


	// Result mux
	// ----------

	// Net gen having issues, so work around it for now
	//assign mux_ref = addr[11:2];

	assign mux_ref[9] = addr[11];
	assign mux_ref[8] = addr[10];
	assign mux_ref[7] = addr[9];
	assign mux_ref[6] = addr[8];
	assign mux_ref[5] = addr[7];
	assign mux_ref[4] = addr[6];
	assign mux_ref[3] = addr[5];
	assign mux_ref[2] = addr[4];
	assign mux_ref[1] = addr[3];
	assign mux_ref[0] = addr[2];

	sky130_fd_sc_hd__mux4_2 mux_0_I (
		.X    (mux_out[0]),
		.A0   (mux_ref[0]),
		.A1   (rom_data0_in[0]),
		.A2   (rom_data1_in[0]),
		.A3   (rom_data2_in[0]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_1_I (
		.X    (mux_out[1]),
		.A0   (mux_ref[1]),
		.A1   (rom_data0_in[1]),
		.A2   (rom_data1_in[1]),
		.A3   (rom_data2_in[1]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_2_I (
		.X    (mux_out[2]),
		.A0   (mux_ref[2]),
		.A1   (rom_data0_in[2]),
		.A2   (rom_data1_in[2]),
		.A3   (rom_data2_in[2]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_3_I (
		.X    (mux_out[3]),
		.A0   (mux_ref[3]),
		.A1   (rom_data0_in[3]),
		.A2   (rom_data1_in[3]),
		.A3   (rom_data2_in[3]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_4_I (
		.X    (mux_out[4]),
		.A0   (mux_ref[4]),
		.A1   (rom_data0_in[4]),
		.A2   (rom_data1_in[4]),
		.A3   (rom_data2_in[4]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_5_I (
		.X    (mux_out[5]),
		.A0   (mux_ref[5]),
		.A1   (rom_data0_in[5]),
		.A2   (rom_data1_in[5]),
		.A3   (rom_data2_in[5]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_6_I (
		.X    (mux_out[6]),
		.A0   (mux_ref[6]),
		.A1   (rom_data0_in[6]),
		.A2   (rom_data1_in[6]),
		.A3   (rom_data2_in[6]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_7_I (
		.X    (mux_out[7]),
		.A0   (mux_ref[7]),
		.A1   (rom_data0_in[7]),
		.A2   (rom_data1_in[7]),
		.A3   (rom_data2_in[7]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_8_I (
		.X    (mux_out[8]),
		.A0   (mux_ref[8]),
		.A1   (rom_data0_in[8]),
		.A2   (rom_data1_in[8]),
		.A3   (rom_data2_in[8]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__mux4_2 mux_9_I (
		.X    (mux_out[9]),
		.A0   (mux_ref[9]),
		.A1   (rom_data0_in[9]),
		.A2   (rom_data1_in[9]),
		.A3   (rom_data2_in[9]),
		.S0   (usr_data_sel[0]),
		.S1   (usr_data_sel[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);


	// Capture register
	// ----------------

	sky130_fd_sc_hd__dfxtp_2 cap_0_I (
		.Q    (usr_data_out[0]),
		.CLK  (data_clk),
		.D    (mux_out[0]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_1_I (
		.Q    (usr_data_out[1]),
		.CLK  (data_clk),
		.D    (mux_out[1]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_2_I (
		.Q    (usr_data_out[2]),
		.CLK  (data_clk),
		.D    (mux_out[2]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_3_I (
		.Q    (usr_data_out[3]),
		.CLK  (data_clk),
		.D    (mux_out[3]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_4_I (
		.Q    (usr_data_out[4]),
		.CLK  (data_clk),
		.D    (mux_out[4]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_5_I (
		.Q    (usr_data_out[5]),
		.CLK  (data_clk),
		.D    (mux_out[5]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_6_I (
		.Q    (usr_data_out[6]),
		.CLK  (data_clk),
		.D    (mux_out[6]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_7_I (
		.Q    (usr_data_out[7]),
		.CLK  (data_clk),
		.D    (mux_out[7]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_8_I (
		.Q    (usr_data_out[8]),
		.CLK  (data_clk),
		.D    (mux_out[8]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

	sky130_fd_sc_hd__dfxtp_2 cap_9_I (
		.Q    (usr_data_out[9]),
		.CLK  (data_clk),
		.D    (mux_out[9]),
		.VPWR (VDPWR),
		.VGND (VGND),
		.VPB  (VDPWR),
		.VNB  (VGND)
	);

`include "control_decap.v"

endmodule

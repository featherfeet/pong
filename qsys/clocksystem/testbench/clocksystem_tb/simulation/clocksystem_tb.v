// clocksystem_tb.v

// Generated using ACDS version 13.0sp1 232 at 2019.03.09.20:36:01

`timescale 1 ps / 1 ps
module clocksystem_tb (
	);

	wire    clocksystem_inst_clk_bfm_clk_clk;       // clocksystem_inst_clk_bfm:clk -> [clocksystem_inst:clk_clk, clocksystem_inst_reset_bfm:clk]
	wire    clocksystem_inst_reset_bfm_reset_reset; // clocksystem_inst_reset_bfm:reset -> clocksystem_inst:reset_reset_n

	clocksystem clocksystem_inst (
		.clk_clk       (clocksystem_inst_clk_bfm_clk_clk),       //     clk.clk
		.reset_reset_n (clocksystem_inst_reset_bfm_reset_reset), //   reset.reset_n
		.vga_clk_clk   ()                                        // vga_clk.clk
	);

	altera_avalon_clock_source #(
		.CLOCK_RATE (50000000),
		.CLOCK_UNIT (1)
	) clocksystem_inst_clk_bfm (
		.clk (clocksystem_inst_clk_bfm_clk_clk)  // clk.clk
	);

	altera_avalon_reset_source #(
		.ASSERT_HIGH_RESET    (0),
		.INITIAL_RESET_CYCLES (50)
	) clocksystem_inst_reset_bfm (
		.reset (clocksystem_inst_reset_bfm_reset_reset), // reset.reset_n
		.clk   (clocksystem_inst_clk_bfm_clk_clk)        //   clk.clk
	);

endmodule

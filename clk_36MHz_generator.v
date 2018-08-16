// Copyright (c) 2017-2018 Roland Coeurjoly
// This program is GPL Licensed. See LICENSE for the full license.

module clk_36MHz_generator(
	     input wire       clk_12MHz,
	     output wire      clk_36MHz
	     );

 parameter FDivider = 62;        // Feedback divider for 16Mhz (default) 83 for 12Mhz.

`ifndef SYNTHESIS
    // SIMULATION
        assign clk_36MHz = clk_12MHz;
`else
    // SYNTHESIS
SB_PLL40_CORE #(
                .FEEDBACK_PATH("SIMPLE"),
                .DIVR(4'b0000),         // DIVR =  0
                .DIVF(7'b0100011),      // DIVF = 35
                .DIVQ(3'b100),          // DIVQ =  4
                .FILTER_RANGE(3'b001)   // FILTER_RANGE = 1
        ) uut (
                .LOCK(locked),
                .RESETB(1'b1),
                .BYPASS(1'b0),
                .REFERENCECLK(clk_12MHz),
                .PLLOUTCORE(clk_36MHz)
                );

`endif

endmodule

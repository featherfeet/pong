`timescale 1ns / 100ps

module test();
	reg reset = 1;
	initial begin
        $dumpfile("waves.lxt");
        $dumpvars(0, test);
		#17 reset = 0;
		#11 reset = 1;
        #1000000;
        $finish;
	end
	reg clk = 0;
	always #5 clk = !clk;
	top top_instantiation(.KEY({3'b0, reset}), .CLOCK_50(clk));
endmodule

/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_top_tb.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Aug 13, 2024
 * Description   : This is the top-level testbench for the Pattern Generator module. 
 *                 It instantiates the DUT (Design Under Test) and its reference model, 
 *                 configures the interfaces, generates the clocks, and runs the test.
 *------------------------------------------------------------------------------*/

module Pattern_Generator_top_tb;

import uvm_pkg::*;  // Import UVM package to use UVM utilities and classes

// Interface declaration for the DUT and reference model
Pattern_Generator_if vif();       // Interface for the DUT (Device Under Test)
Pattern_Generator_Ref_if vrefif(); // Interface for the reference model

// Instantiate the reference model (Ref)
Pattern_Generator_ref Ref(
	.clk(vrefif.clk),          // Connect reference clock to vif interface clock
	.rst_n(vrefif.rst_n),      // Connect reference reset to vif interface reset
	.f_sync(vrefif.f_sync),    // Connect first sync signal
	.sync(vrefif.sync),        // Connect sync signal
	.constVal(vrefif.constVal),// Connect constant value signal
	.X(vrefif.X),              // Connect X delta for ramp mode
	.Y(vrefif.Y),              // Connect Y delta for ramp mode
	.Mode(vrefif.Mode),        // Connect work mode signal
	.Counter_ver(vrefif.Counter_ver),	//for verification
	.cnt(vrefif.cnt)           // Connect count output signal
);

// Instantiate the DUT (Pattern Generator)
Pattern_Generator dut(
	.clk(vif.clk),          // Connect DUT clock to reference interface clock
	.rst_n(vif.rst_n),      // Connect DUT reset to reference interface reset
	.f_sync(vif.f_sync),    // Connect first sync signal
	.sync(vif.sync),        // Connect sync signal
	.constVal(vif.constVal),// Connect constant value signal
	.X(vif.X),              // Connect X delta for ramp mode
	.Y(vif.Y),              // Connect Y delta for ramp mode
	.Mode(vif.Mode),        // Connect work mode signal
	.cnt(vif.cnt)           // Connect count output signal
);

initial begin
	// Registers the Interface in the UVM configuration database, making it available to other UVM components
	uvm_resource_db#(virtual Pattern_Generator_if)::set (.scope("ifs"), .name("Pattern_Generator_if"), .val(vif));
	uvm_resource_db#(virtual Pattern_Generator_Ref_if)::set (.scope("ifs"), .name("Pattern_Generator_Ref_if"), .val(vrefif));

	// Executes the test: This runs the specified UVM test ("Pattern_Generator_test")
	run_test("Pattern_Generator_test");

	// Ends the simulation after a specified time
	$finish;
end

// Clock generation for the DUT
initial begin
	vif.clk = 0;                // Initialize clock to 0
	forever #8 vif.clk = ~vif.clk; // Generate a clock with a 16 ns period (8 ns high, 8 ns low)
end

// Clock generation for the reference model
initial begin
	vrefif.clk = 0;                // Initialize clock to 0
	forever #8 vrefif.clk = ~vrefif.clk; // Generate a clock with a 16 ns period (8 ns high, 8 ns low)
end

endmodule

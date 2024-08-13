/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_top_tb.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Aug 13, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Pattern_Generator_top_tb;

import uvm_pkg::*;
//Interface declaration
Pattern_Generator_if vif();
Pattern_Generator_Ref_if vrefif();

// Instantiate the DUT (Device Under Test)
Pattern_Generator_ref Ref(
	.clk(vif.clk),
	.rst_n(vif.rst_n),
	.f_sync(vif.f_sync),
	.sync(vif.sync),
	.constVal(vif.constVal),
	.X(vif.X),
	.Y(vif.Y),
	.Mode(vif.Mode),
	.cnt(vif.cnt)
);
Pattern_Generator dut(
	.clk(vrefif.clk),
	.rst_n(vrefif.rst_n),
	.f_sync(vrefif.f_sync),
	.sync(vrefif.sync),
	.constVal(vrefif.constVal),
	.X(vrefif.X),
	.Y(vrefif.Y),
	.Mode(vrefif.Mode),
	.cnt(vrefif.cnt)
);


initial begin
	//Registers the Interface in the configuration block so that other blocks can use it
	uvm_resource_db#(virtual Pattern_Generator_if)::set (.scope("ifs"), .name("Pattern_Generator_if"), .val(vif));
	uvm_resource_db#(virtual Pattern_Generator_Ref_if)::set (.scope("ifs"), .name("Pattern_Generator_Ref_if"), .val(vrefif));
	//Executes the test
	run_test("Pattern_Generator_test");
	#1000000 $finish;
end


// Clock generation
initial begin
	vif.clk = 0;
	forever #8 vif.clk = ~vif.clk; // 16 ns clock period
end
initial begin
	vrefif.clk = 0;
	forever #8 vrefif.clk = ~vrefif.clk; // 16 ns clock period
end



endmodule
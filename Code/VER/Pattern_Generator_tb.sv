module Pattern_Generator_tb;

// Inputs
reg clk;            // 16ns master clock
reg rst_n;          // Asynchronous active low reset
reg f_sync;         // First sync signal
reg sync;           // Sync signal, starts the count
reg [11:0] constVal;// constant value 
reg [1:0] X;        // deltaX for ramp mode
reg [1:0] Y;        // deltaY for ramp mode
reg [2:0] Mode;     // work mode

// Outputs
wire [11:0] cnt;   // output count

// Instantiate the DUT (Device Under Test)
Pattern_Generator_ref dut(
	.clk(clk),
	.rst_n(rst_n),
	.f_sync(f_sync),
	.sync(sync),
	.constVal(constVal),
	.X(X),
	.Y(Y),
	.Mode(Mode),
	.cnt(cnt)
);

// Clock generation
initial begin
	clk = 0;
	forever #8 clk = ~clk; // 16 ns clock period
end

// Test sequence
initial begin
	// Reset sequence
	rst_n = 1;
	f_sync = 0;
	sync = 0;
	constVal = 0;
	X = 0;
	Y = 0;
	Mode = 3'b000;

	// Apply reset
	@(negedge clk);
	rst_n = 0;
	@(negedge clk);
	rst_n = 0;
	
	// Wait for reset release
	@(negedge clk);

	// Test cases
	// Regular mode
	apply_mode(3'b001, 24, 4500);

	// Constant mode
	apply_mode_with_const(3'b010, 24, 1350, 12'd12);

	// White 1x1 mode
	apply_mode(3'b011, 24, 1350);

	// Black 1x1 mode
	apply_mode(3'b100, 24, 1350);

	// White 2x2 mode
	apply_mode(3'b101, 24, 1350);

	// Black 2x2 mode
	apply_mode(3'b110, 24, 1350);

	// Ramp mode
	apply_ramp_mode(3'b111, 24, 1350, 2'b10, 2'b10);

	// Finish simulation
	#100000 $finish;
end

// Task to apply mode
task apply_mode(input [2:0] mode, input integer repeat_count, input integer wait_cycles);
	begin
		f_sync = 1;
		sync = 1;
		Mode = mode;
		repeat(repeat_count) begin
			@(negedge clk);
			f_sync = 0;
			sync = 0;
			repeat(wait_cycles) @(negedge clk);
			sync = 1;
		end
	end
endtask

// Task to apply mode with constant value
task apply_mode_with_const(input [2:0] mode, input integer repeat_count, input integer wait_cycles, input [11:0] const_value);
	begin
		constVal = const_value;
		apply_mode(mode, repeat_count, wait_cycles);
	end
endtask

// Task to apply ramp mode
task apply_ramp_mode(input [2:0] mode, input integer repeat_count, input integer wait_cycles, input [1:0] x, input [1:0] y);
	begin
		X = x;
		Y = y;
		apply_mode(mode, repeat_count, wait_cycles);
	end
endtask

endmodule
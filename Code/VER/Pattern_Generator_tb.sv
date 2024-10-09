module Pattern_Generator_tb;

// Inputs
reg clk;            // 16ns master clock
reg rst_n;          // Asynchronous active-low reset
reg f_sync;         // First sync signal, initiates the sync process
reg sync;           // Sync signal, starts the counting process
reg [11:0] constVal;// Constant value, used in certain operational modes
reg [1:0] X;        // deltaX for ramp mode, changes the X-axis value
reg [1:0] Y;        // deltaY for ramp mode, changes the Y-axis value
reg [2:0] Mode;     // Work mode, defines the operation type of the DUT

// Outputs
wire [11:0] cnt;   // Output count from the DUT

// Instantiate the DUT (Device Under Test)
// The module 'Pattern_Generator_ref' simulates the reference design of the pattern generator
Pattern_Generator_ref dut(
	.clk(clk),        // Clock signal connected to DUT
	.rst_n(rst_n),    // Reset signal connected to DUT
	.f_sync(f_sync),  // First sync signal connected to DUT
	.sync(sync),      // Sync signal connected to DUT
	.constVal(constVal), // Constant value input connected to DUT
	.X(X),            // deltaX input connected to DUT
	.Y(Y),            // deltaY input connected to DUT
	.Mode(Mode),      // Mode input connected to DUT
	.cnt(cnt)         // Output count connected to DUT
);

// Clock generation
// Generates a clock signal with a period of 16 ns (50 MHz frequency)
initial begin
	clk = 0;
	forever #8 clk = ~clk; // 16 ns clock period
end

// Test sequence
// Applies various test modes to the DUT and checks behavior
initial begin
	// Initialize all inputs to default values
	rst_n = 1;        // Reset is inactive initially
	f_sync = 0;       // No sync at the start
	sync = 0;         // Sync signal low
	constVal = 0;     // Default constant value
	X = 0;            // Default deltaX
	Y = 0;            // Default deltaY
	Mode = 3'b000;    // Default mode (mode 000)

	// Apply reset
	@(negedge clk);
	rst_n = 0;        // Activate reset (active-low)
	@(negedge clk);
	rst_n = 0;        // Keep reset active for multiple clock cycles
	
	// Wait for reset release
	@(negedge clk);

	// Test cases

	// Regular mode (mode 001)
	apply_mode(3'b001, 24, 4500); // Run the DUT in regular mode

	// Constant mode (mode 010) with a specific constant value
	apply_mode_with_const(3'b010, 24, 1350, 12'd12); // Use constant value 12

	// White 1x1 mode (mode 011)
	apply_mode(3'b011, 24, 1350); // Run white 1x1 test pattern

	// Black 1x1 mode (mode 100)
	apply_mode(3'b100, 24, 1350); // Run black 1x1 test pattern

	// White 2x2 mode (mode 101)
	apply_mode(3'b101, 24, 1350); // Run white 2x2 test pattern

	// Black 2x2 mode (mode 110)
	apply_mode(3'b110, 24, 1350); // Run black 2x2 test pattern

	// Ramp mode (mode 111) with specific X and Y values
	apply_ramp_mode(3'b111, 24, 1350, 2'b10, 2'b10); // Ramp mode test

	// Finish simulation after all test cases are executed
	#100000 $finish;
end

// Task to apply a mode and repeat the process for a set number of cycles
task apply_mode(input [2:0] mode, input integer repeat_count, input integer wait_cycles);
	begin
		f_sync = 1;      // Assert the first sync signal
		sync = 1;        // Assert the sync signal
		Mode = mode;     // Set the mode to the specified value
		repeat(repeat_count) begin
			@(negedge clk); // Wait for a negative edge of the clock
			f_sync = 0;     // Deassert the first sync signal after one cycle
			sync = 0;       // Deassert the sync signal
			repeat(wait_cycles) @(negedge clk); // Wait for specified cycles
			sync = 1;       // Reassert the sync signal for the next cycle
		end
	end
endtask

// Task to apply a mode with a constant value
task apply_mode_with_const(input [2:0] mode, input integer repeat_count, input integer wait_cycles, input [11:0] const_value);
	begin
		constVal = const_value; // Set the constant value
		apply_mode(mode, repeat_count, wait_cycles); // Apply the mode with the constant value
	end
endtask

// Task to apply a ramp mode with specific X and Y values
task apply_ramp_mode(input [2:0] mode, input integer repeat_count, input integer wait_cycles, input [1:0] x, input [1:0] y);
	begin
		X = x; // Set the deltaX value
		Y = y; // Set the deltaY value
		apply_mode(mode, repeat_count, wait_cycles); // Apply the ramp mode with the specified X and Y values
	end
endtask

endmodule

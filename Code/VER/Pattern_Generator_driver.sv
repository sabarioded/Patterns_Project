/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_driver.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : This SystemVerilog class defines the driver for the pattern 
 *                 generator module. The driver is responsible for driving 
 *                 signals to the DUT and reference interfaces based on 
 *                 transaction objects received from the sequencer.
 *------------------------------------------------------------------------------*/

class Pattern_Generator_driver extends uvm_driver#(Pattern_Generator_transaction);
    // Macro to register the component with the UVM factory
	`uvm_component_utils(Pattern_Generator_driver)

	// Virtual interfaces for the DUT and reference module
	virtual Pattern_Generator_if vif;
	virtual Pattern_Generator_Ref_if vrefif;

	// Constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);  // Call to the base class constructor
	endfunction: new

	// Build phase: Retrieve the virtual interfaces from the UVM resource database
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);  // Call to the base class build_phase

		// Retrieve and assign the virtual interfaces for DUT and reference module
		void'(uvm_resource_db#(virtual Pattern_Generator_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_if"), .val(vif)));
		void'(uvm_resource_db#(virtual Pattern_Generator_Ref_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_Ref_if"), .val(vrefif)));
	endfunction: build_phase

	// Run phase: This phase executes the main driving function
	task run_phase(uvm_phase phase);
		drive();  // Invoke the drive task
	endtask: run_phase

	// Drive task: Core functionality to drive the DUT and reference interfaces
	virtual task drive();
		Pattern_Generator_transaction pg_mkt;  // Transaction object to store data from the sequencer
		integer state = 0;                     // State variable to control the driving process
		integer count = 0;                     // Counter variable used in counting logic
		integer random_number = 0;             // Random number used to determine sync timing
		integer lines = 0;                     // Line counter to keep track of sync signals
		
		vif.sync = 1'b0;
		vif.f_sync = 1'b0;

		`uvm_info("", "Drive Function of Driver", UVM_MEDIUM)

		forever begin
			`uvm_info("", "Forever of Driver", UVM_LOW)
			
			// Wait for the next transaction or negative edge of either clock
			@(negedge vif.clk or negedge vrefif.clk)
			begin
				// State machine to handle different phases of the driving process
				case(state)
					0: begin   // Reset state
						vif.rst_n = 1'b0;
						vrefif.rst_n = 1'b0;
						state = 1;  // Move to the next state
					end
					1: begin   // First sync state
						 vif.rst_n = 1'b1;
						 vrefif.rst_n = 1'b1;
						 vif.f_sync = 1'b1;
						 vif.sync = 1'b1;
						 vrefif.f_sync = 1'b1;
						 vrefif.sync = 1'b1;
						 
						 // Get the next transaction from the sequencer
						 seq_item_port.get_next_item(pg_mkt);

						 // Drive the signals with the values from the transaction
						 vif.Mode = pg_mkt.Mode;
						 vrefif.Mode = pg_mkt.Mode;
						 vif.X = pg_mkt.X;
						 vrefif.X = pg_mkt.X;
						 vif.Y = pg_mkt.Y;
						 vrefif.Y = pg_mkt.Y;
						 vif.constVal = pg_mkt.constVal;
						 vrefif.constVal = pg_mkt.constVal;
						 
						 // Initialize state variables for counting
						 state = 2;
						 lines = 0;
						 count = 0;

						 // Determine the random number based on the mode
						 if(pg_mkt.Mode == 3'b001) begin
							random_number = $urandom_range(4300, 4100);
						 end else begin
							random_number = $urandom_range(1400, 1295);
						 end
					end
					2: begin   // Run until the next sync
						 count = count + 1;
						 vif.f_sync = 1'b0;
						 vrefif.f_sync = 1'b0;
						 
						 // Check if the count exceeds the random number representing the next sync
						 if(count > random_number) begin
							 lines = lines + 1;
							 vif.sync = 1'b1;
							 vrefif.sync = 1'b1;
							 count = 0;
						 end else begin
							 vif.sync = 1'b0;
							 vrefif.sync = 1'b0;
						 end
						 
						 // Check if the required number of lines have been processed
						 if(lines == 25) begin
							 seq_item_port.item_done();  // Mark the transaction as done
							 state = 1;  // Return to the first sync state
						 end else begin
							 state = 2;  // Continue counting
						 end
					   end
				endcase
			end
		end
	endtask: drive
endclass:Pattern_Generator_driver

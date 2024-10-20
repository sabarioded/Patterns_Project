/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_test.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : This UVM test class is used to define and run the test sequences
 *                 for the Pattern Generator module. It instantiates the test 
 *                 environment, creates the test sequence, and manages the 
 *                 simulation run phase.
 *------------------------------------------------------------------------------*/

class Pattern_Generator_test extends uvm_test;
	`uvm_component_utils(Pattern_Generator_test) // Macro to register the class with UVM factory

	// Environment instance to hold the simulation environment
	Pattern_Generator_env pg_env;

	// Constructor: Initializes the test class
	function new(string name, uvm_component parent);
		super.new(name, parent); // Call the parent class constructor
	endfunction: new

	// Build phase: Constructs the test environment
	function void build_phase(uvm_phase phase);
		super.build_phase(phase); // Call parent class build phase
		pg_env = Pattern_Generator_env::type_id::create(.name("pg_env"), .parent(this)); // Create the environment
	endfunction: build_phase

	// Run phase: Defines the main test behavior
	task run_phase(uvm_phase phase);
		Pattern_Generator_sequence pg_seq; // Sequence variable to hold the test sequence

		// Raise an objection to keep the simulation running until the test is complete
		phase.raise_objection(.obj(this));

		// Create and randomize the test sequence
		pg_seq = Pattern_Generator_sequence::type_id::create(.name("pg_seq"), .contxt(get_full_name())); // Create the test sequence
		//assert(pg_seq.randomize()); // Randomize the sequence data

		// Start the sequence by connecting it to the sequencer in the environment's agent
		pg_seq.start(pg_env.pg_agent.pg_seqr);

		// Drop the objection, allowing the simulation to finish after the test completes
		phase.drop_objection(.obj(this));
	endtask: run_phase
endclass: Pattern_Generator_test

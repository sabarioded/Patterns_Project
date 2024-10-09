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
	Pattern_Generator_env ml_env;

	// Constructor: Initializes the test class
	function new(string name, uvm_component parent);
		super.new(name, parent); // Call the parent class constructor
	endfunction: new

	// Build phase: Constructs the test environment
	function void build_phase(uvm_phase phase);
		super.build_phase(phase); // Call parent class build phase
		ml_env = Pattern_Generator_env::type_id::create(.name("ml_env"), .parent(this)); // Create the environment
	endfunction: build_phase

	// Run phase: Defines the main test behavior
	task run_phase(uvm_phase phase);
		Pattern_Generator_sequence ml_seq; // Sequence variable to hold the test sequence

		// Raise an objection to keep the simulation running until the test is complete
		phase.raise_objection(.obj(this));

		// Create and randomize the test sequence
		ml_seq = Pattern_Generator_sequence::type_id::create(.name("ml_seq"), .contxt(get_full_name())); // Create the test sequence
		assert(ml_seq.randomize()); // Randomize the sequence data

		// Start the sequence by connecting it to the sequencer in the environment's agent
		ml_seq.start(ml_env.ml_agent.ml_seqr);

		// Drop the objection, allowing the simulation to finish after the test completes
		phase.drop_objection(.obj(this));
	endtask: run_phase
endclass: Pattern_Generator_test

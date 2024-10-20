/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_agent.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : This SystemVerilog class defines a UVM agent for a pattern 
 *                 generator. It contains the necessary components (sequencer, 
 *                 driver, monitors) and analysis ports to facilitate 
 *                 communication between the DUT and reference models during 
 *                 simulation.
 *------------------------------------------------------------------------------*/

class Pattern_Generator_agent extends uvm_agent;
    // Macro to register the component with the UVM factory
	`uvm_component_utils(Pattern_Generator_agent)
	
	// Analysis ports to send transactions from the monitors to subscribers
	uvm_analysis_port#(Pattern_Generator_transaction) dut_agent;
	uvm_analysis_port#(Pattern_Generator_transaction) ref_agent;

	// Declaration of UVM components used in the agent
	Pattern_Generator_sequencer		pg_seqr;      // Sequencer to generate stimulus
	Pattern_Generator_driver		pg_driver;      // Driver to drive stimulus to the DUT
	Pattern_Generator_monitor_dut   dut_mon;   // Monitor to observe the DUT's outputs
	Pattern_Generator_monitor_ref   ref_mon;   // Monitor to observe the reference model's outputs

	// Constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);  // Call to the base class constructor
	endfunction: new

	// Build phase: Instantiate and configure all components
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);  // Call to the base class build_phase

		// Create and initialize analysis ports
		dut_agent    = new(.name("dut_agent"), .parent(this));
		ref_agent    = new(.name("ref_agent"), .parent(this));

		// Instantiate sequencer, driver, and monitors using UVM factory
		pg_seqr		= Pattern_Generator_sequencer::type_id::create(.name("pg_seqr"), .parent(this));
		pg_driver		= Pattern_Generator_driver::type_id::create(.name("pg_driver"), .parent(this));
		dut_mon  = Pattern_Generator_monitor_dut::type_id::create(.name("dut_mon"), .parent(this));
		ref_mon  = Pattern_Generator_monitor_ref::type_id::create(.name("ref_mon"), .parent(this));
		
	endfunction: build_phase

	// Connect phase: Connect components to each other
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);  // Call to the base class connect_phase
		
		// Connect the sequencer's output to the driver's input
		pg_driver.seq_item_port.connect(pg_seqr.seq_item_export);

		// Connect the DUT and reference model monitors to their respective analysis ports
		dut_mon.mon_dut.connect(dut_agent);
		ref_mon.mon_ref.connect(ref_agent);

	endfunction: connect_phase
endclass: Pattern_Generator_agent

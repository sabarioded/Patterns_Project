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
	uvm_analysis_port#(Pattern_Generator_transaction) agent_ap_dut;
	uvm_analysis_port#(Pattern_Generator_transaction) agent_ap_ref;

	// Declaration of UVM components used in the agent
	Pattern_Generator_sequencer		ml_seqr;      // Sequencer to generate stimulus
	Pattern_Generator_driver		ml_drvr;      // Driver to drive stimulus to the DUT
	Pattern_Generator_monitor_dut   ml_mon_dut;   // Monitor to observe the DUT's outputs
	Pattern_Generator_monitor_ref   ml_mon_ref;   // Monitor to observe the reference model's outputs

	// Constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);  // Call to the base class constructor
	endfunction: new

	// Build phase: Instantiate and configure all components
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);  // Call to the base class build_phase

		// Create and initialize analysis ports
		agent_ap_dut    = new(.name("agent_ap_dut"), .parent(this));
		agent_ap_ref    = new(.name("agent_ap_ref"), .parent(this));

		// Instantiate sequencer, driver, and monitors using UVM factory
		ml_seqr		= Pattern_Generator_sequencer::type_id::create(.name("ml_seqr"), .parent(this));
		ml_drvr		= Pattern_Generator_driver::type_id::create(.name("ml_drvr"), .parent(this));
		ml_mon_dut  = Pattern_Generator_monitor_dut::type_id::create(.name("ml_mon_dut"), .parent(this));
		ml_mon_ref  = Pattern_Generator_monitor_ref::type_id::create(.name("ml_mon_ref"), .parent(this));

		// Optional: UVM info message indicating that the build phase is complete
		// `uvm_info("", "Build of Agent", UVM_MEDIUM)
	endfunction: build_phase

	// Connect phase: Connect components to each other
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);  // Call to the base class connect_phase
		
		// Connect the sequencer's output to the driver's input
		ml_drvr.seq_item_port.connect(ml_seqr.seq_item_export);

		// Connect the DUT and reference model monitors to their respective analysis ports
		ml_mon_dut.mon_ap_dut.connect(agent_ap_dut);
		ml_mon_ref.mon_ap_ref.connect(agent_ap_ref);

		// Optional: UVM info message indicating that the connect phase is complete
		// `uvm_info("", "Connect Phase of Agent", UVM_MEDIUM)
	endfunction: connect_phase
endclass: Pattern_Generator_agent

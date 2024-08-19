/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_env.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : This file defines the Pattern_Generator_env class, which 
 *                 extends the UVM environment class (uvm_env). It includes 
 *                 the agent and scoreboard components used for pattern 
 *                 generation in the RTL project.
 *------------------------------------------------------------------------------*/

class Pattern_Generator_env extends uvm_env;
	`uvm_component_utils(Pattern_Generator_env) // Macro for UVM factory registration

	Pattern_Generator_agent ml_agent; // Instance of the pattern generator agent
	Pattern_Generator_scoreboard ml_sb; // Instance of the pattern generator scoreboard

	// Constructor: Initializes the environment by calling the parent class constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	// Build phase: Creates instances of the agent and scoreboard components
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ml_agent	= Pattern_Generator_agent::type_id::create(.name("ml_agent"), .parent(this));
		ml_sb       = Pattern_Generator_scoreboard::type_id::create(.name("ml_sb"), .parent(this));
	endfunction: build_phase
	
	// Connect phase: Connects the agent's analysis ports to the scoreboard's exports
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		ml_agent.agent_ap_dut.connect(ml_sb.sb_export_dut); // Connect DUT analysis port
		ml_agent.agent_ap_ref.connect(ml_sb.sb_export_ref); // Connect reference analysis port
		//`uvm_info("", "Connect Phase of Pattern_Generator_env", UVM_MEDIUM); // Uncomment for debug message
	endfunction: connect_phase

endclass: Pattern_Generator_env

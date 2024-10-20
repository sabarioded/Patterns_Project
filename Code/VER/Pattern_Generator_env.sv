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

	Pattern_Generator_agent pg_agent; 
	Pattern_Generator_scoreboard pg_sb;  

	// Constructor: Initializes the environment by calling the parent class constructor
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	// Build phase: Creates instances of the agent and scoreboard components
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		pg_agent	= Pattern_Generator_agent::type_id::create(.name("pg_agent"), .parent(this));
		pg_sb           = Pattern_Generator_scoreboard::type_id::create(.name("pg_sb"), .parent(this));
	endfunction: build_phase
	
	// Connect phase: Connects the agent's analysis ports to the scoreboard's exports
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		pg_agent.dut_agent.connect(pg_sb.sb_export_dut); // Connect DUT analysis port
		pg_agent.ref_agent.connect(pg_sb.sb_export_ref); // Connect reference analysis port
	endfunction: connect_phase

endclass: Pattern_Generator_env

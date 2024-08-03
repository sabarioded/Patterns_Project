/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_env.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

class Pattern_Generator_env extends uvm_env;
	`uvm_component_utils(Pattern_Generator_env)

	Pattern_Generator_agent ml_agent;
	Pattern_Generator_scoreboard ml_sb;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ml_agent	= Pattern_Generator_agent::type_id::create(.name("ml_agent"), .parent(this));
		ml_sb       = Pattern_Generator_scoreboard::type_id::create(.name("ml_sb"), .parent(this));
	endfunction: build_phase
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		ml_agent.agent_ap_dut.connect(ml_sb.sb_export_dut);
		ml_agent.agent_ap_ref.connect(ml_sb.sb_export_ref);
		//`uvm_info("", "Connect Phase of hamming_env", UVM_MEDIUM);
	endfunction: connect_phase

endclass: Pattern_Generator_env
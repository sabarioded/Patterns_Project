/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_agent.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

class Pattern_Generator_agent extends uvm_agent;
	`uvm_component_utils(Pattern_Generator_agent)
	
	uvm_analysis_port#(Pattern_Generator_transaction) agent_ap_dut;
	uvm_analysis_port#(Pattern_Generator_transaction) agent_ap_ref;

	Pattern_Generator_sequencer		ml_seqr;
	Pattern_Generator_driver		ml_drvr;
	Pattern_Generator_monitor_dut   ml_mon_dut;
	Pattern_Generator_monitor_ref   ml_mon_ref;


	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent_ap_dut    = new(.name("agent_ap_dut"), .parent(this));
		agent_ap_ref    = new(.name("agent_ap_ref"), .parent(this));

		ml_seqr		= Pattern_Generator_sequencer::type_id::create(.name("ml_seqr"), .parent(this));
		ml_drvr		= Pattern_Generator_driver::type_id::create(.name("ml_drvr"), .parent(this));
		ml_mon_dut  = Pattern_Generator_monitor_dut::type_id::create(.name("ml_mon_dut"), .parent(this));
		ml_mon_ref  = Pattern_Generator_monitor_ref::type_id::create(.name("ml_mon_ref"), .parent(this));
		//`uvm_info("", "Build of Agent", UVM_MEDIUM)
	endfunction: build_phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		ml_drvr.seq_item_port.connect(ml_seqr.seq_item_export);
		//`uvm_info("", "Connect Phase of Agent", UVM_MEDIUM)
		ml_mon_dut.mon_ap_dut.connect(agent_ap_dut);
		ml_mon_ref.mon_ap_ref.connect(agent_ap_ref);

	endfunction: connect_phase
endclass: Pattern_Generator_agent

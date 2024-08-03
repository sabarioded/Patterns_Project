/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_monitor.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

class Pattern_Generator_monitor_dut extends uvm_monitor;
	`uvm_component_utils(Pattern_Generator_monitor_dut)
	
	uvm_analysis_port#(Pattern_Generator_transaction) mon_ap_dut;
	
	virtual Pattern_Generator_if vif;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		void'(uvm_resource_db#(virtual Pattern_Generator_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_if"), .val(vif)));
		mon_ap_dut = new(.name("mon_ap_dut"), .parent(this));
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		
		Pattern_Generator_transaction ml_pkt;
		ml_pkt = Pattern_Generator_transaction::type_id::create (.name("ml_pkt"), .contxt(get_full_name()));
		
		forever begin
			@(posedge vif.clk)
			begin
			   ml_pkt.cnt = vif.cnt;
			   //Send the transaction to the analysis port
					   mon_ap_dut.write(ml_pkt);
						   $display ("cnt_dut=%d", ml_pkt.cnt);
			end
		end
	endtask: run_phase
endclass: Pattern_Generator_monitor_dut

class Pattern_Generator_monitor_ref extends uvm_monitor;
	`uvm_component_utils(Pattern_Generator_monitor_ref)
	
	uvm_analysis_port#(Pattern_Generator_transaction) mon_ap_ref;
	
	virtual Pattern_Generator_Ref_if vrefif;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		void'(uvm_resource_db#(virtual Pattern_Generator_Ref_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_Ref_if"), .val(vrefif)));
		mon_ap_ref = new(.name("mon_ap_ref"), .parent(this));
	endfunction: build_phase
	
	task run_phase(uvm_phase phase);
		
		Pattern_Generator_transaction ml_pkt;
		ml_pkt = Pattern_Generator_transaction::type_id::create (.name("ml_pkt"), .contxt(get_full_name()));
		
		forever begin
			@(posedge vrefif.clk)
			begin
				   ml_pkt.cnt = vrefif.cnt;
			   //Send the transaction to the analysis port
			   mon_ap_ref.write(ml_pkt);
						   $display ("cnt_ref=%d", ml_pkt.cnt);
			end
		end
	endtask: run_phase
endclass: Pattern_Generator_monitor_ref

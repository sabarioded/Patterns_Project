/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_monitor.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   : This file defines two monitor classes for the Pattern Generator.
 *                 The monitors observe the DUT (Device Under Test) and reference 
 *                 interfaces, capture transactions, and send them to analysis ports.
 *------------------------------------------------------------------------------*/

class Pattern_Generator_monitor_dut extends uvm_monitor;
	`uvm_component_utils(Pattern_Generator_monitor_dut) // UVM macro for component registration

	uvm_analysis_port#(Pattern_Generator_transaction) mon_dut; // Analysis port to send DUT transactions
	
	virtual Pattern_Generator_if vif; // Virtual interface for DUT
	
	// Constructor: Initializes the monitor component
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	// Build phase: Retrieves the virtual interface and creates the analysis port
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// Read virtual interface from the resource database
		void'(uvm_resource_db#(virtual Pattern_Generator_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_if"), .val(vif)));
		mon_dut = new(.name("mon_dut"), .parent(this)); // Create the analysis port
	endfunction: build_phase
	
	// Run phase: Continuously monitors the DUT and sends transactions to the analysis port
	task run_phase(uvm_phase phase);
		
		Pattern_Generator_transaction pg_pkt_dut; // Transaction object
		pg_pkt_dut = Pattern_Generator_transaction::type_id::create (.name("pg_pkt_dut"), .contxt(get_full_name())); // Create the transaction object
		
		forever begin
			@(posedge vif.clk) // Wait for edge of the clock signal
			begin
				pg_pkt_dut.cnt = vif.cnt; // Capture the count value from the DUT
				mon_dut.write(pg_pkt_dut); // Send the transaction to the analysis port
				//$display ("cnt_dut=%d", pg_pkt.cnt); // Display the count value for debugging
			end
		end
	endtask: run_phase
endclass: Pattern_Generator_monitor_dut

class Pattern_Generator_monitor_ref extends uvm_monitor;
	`uvm_component_utils(Pattern_Generator_monitor_ref) // UVM macro for component registration

	uvm_analysis_port#(Pattern_Generator_transaction) mon_ref; // Analysis port to send reference transactions
	
	virtual Pattern_Generator_Ref_if vrefif; // Virtual interface for reference

	// Constructor: Initializes the monitor component
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new
	
	// Build phase: Retrieves the virtual interface and creates the analysis port
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		
		// Read virtual interface from the resource database
		void'(uvm_resource_db#(virtual Pattern_Generator_Ref_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_Ref_if"), .val(vrefif)));
		mon_ref = new(.name("mon_ref"), .parent(this)); // Create the analysis port
	endfunction: build_phase
	
	// Run phase: Continuously monitors the reference and sends transactions to the analysis port
	task run_phase(uvm_phase phase);
		
		Pattern_Generator_transaction pg_pkt_ref; // Transaction object
		pg_pkt_ref = Pattern_Generator_transaction::type_id::create (.name("pg_pkt_ref"), .contxt(get_full_name())); // Create the transaction object
		
		forever begin
			@(posedge vrefif.clk) // Wait for edge of the clock signal
			begin
				pg_pkt_ref.cnt = vrefif.cnt; // Capture the count value from the reference
				mon_ref.write(pg_pkt_ref); // Send the transaction to the analysis port
				//$display ("cnt_ref=%d", pg_pkt.cnt); // Display the count value for debugging
			end
		end
	endtask: run_phase
endclass: Pattern_Generator_monitor_ref

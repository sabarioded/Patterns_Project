/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_sequencer.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

class Pattern_Generator_transaction extends uvm_sequence_item;
	
	logic 				f_sync;			//First sync signal
	logic 				sync;			//Sync signal, starts the count
	rand logic [11:0]	constVal;		//constant value 
	logic [1:0]			X;				//deltaX for ramp mode
	logic [1:0] 		Y;				//deltaY for ramp mode
	logic [2:0] 		Mode;			//work mode
	logic [11:0]		cnt;			//output count
	
	function new(string name = "");
		super.new(name);
	endfunction: new

	`uvm_object_utils_begin(Pattern_Generator_transaction)
		`uvm_field_int(f_sync, UVM_ALL_ON)
		`uvm_field_int(sync, UVM_ALL_ON)
		`uvm_field_int(constVal, UVM_ALL_ON)
		`uvm_field_int(X, UVM_ALL_ON)
		`uvm_field_int(Y, UVM_ALL_ON)
		`uvm_field_int(Mode, UVM_ALL_ON)
	`uvm_object_utils_end
endclass: Pattern_Generator_transaction

class Pattern_Generator_sequence extends uvm_sequence#(Pattern_Generator_transaction);

	function new(string name = "");
		super.new(name);
	endfunction: new

	`uvm_object_utils(Pattern_Generator_sequence)

	task body();
		Pattern_Generator_transaction ml_pkt;
		`uvm_info("", "Randomize Try0", UVM_MEDIUM)
		ml_pkt = Pattern_Generator_transaction::type_id::create(.name("ml_pkt"), .contxt(get_full_name()));
		//`uvm_info("ml_pkt_sequence", ml_pkt.sprint(), UVM_LOW);
		start_item(ml_pkt); // regular mode
		ml_pkt.X = 2'b01;
		ml_pkt.Y = 2'b01;
		ml_pkt.constVal = $urandom_range(4095, 0);
		ml_pkt.Mode = 3'b001;
		finish_item(ml_pkt);
	endtask: body 
endclass: Pattern_Generator_sequence

typedef uvm_sequencer#(Pattern_Generator_transaction) Pattern_Generator_sequencer;


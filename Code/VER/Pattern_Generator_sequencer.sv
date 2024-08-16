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
		/*
		start_item(ml_pkt); // regular mode
		ml_pkt.X = 2'b01;
		ml_pkt.Y = 2'b01;
		ml_pkt.constVal = $urandom_range(4095, 0);
		ml_pkt.Mode = 3'b001;
		finish_item(ml_pkt);
		start_item(ml_pkt); // Constant mode
		ml_pkt.X = 2'b01;
		ml_pkt.Y = 2'b01;
		ml_pkt.constVal = $urandom_range(4095, 0);
		ml_pkt.Mode = 3'b010;
		finish_item(ml_pkt);
		start_item(ml_pkt); // white 1x1 mode
		ml_pkt.X = 2'b01;
		ml_pkt.Y = 2'b01;
		ml_pkt.constVal = $urandom_range(4095, 0);
		ml_pkt.Mode = 3'b011;
		finish_item(ml_pkt);
		start_item(ml_pkt); // black 1x1 mode
		ml_pkt.X = 2'b01;
		ml_pkt.Y = 2'b01;
		ml_pkt.constVal = $urandom_range(4095, 0);
		ml_pkt.Mode = 3'b100;
		finish_item(ml_pkt);
		start_item(ml_pkt); // white 2x2 mode
		ml_pkt.X = 2'b01;
		ml_pkt.Y = 2'b01;
		ml_pkt.constVal = $urandom_range(4095, 0);
		ml_pkt.Mode = 3'b101;
		finish_item(ml_pkt);
		start_item(ml_pkt); // black 2x2 mode
		ml_pkt.X = 2'b01;
		ml_pkt.Y = 2'b01;
		ml_pkt.constVal = $urandom_range(4095, 0);
		ml_pkt.Mode = 3'b110;
		finish_item(ml_pkt);
		*/
		//Test_mode(2'b00,2'b00,3'b111); 	//0-0
		//Test_mode(2'b00,2'b01,3'b111); 	//0-1
		//Test_mode(2'b00,2'b10,3'b111);	//0-2
		//Test_mode(2'b00,2'b11,3'b111);	//0-3
		//Test_mode(2'b01,2'b00,3'b111);	//1-0
		//Test_mode(2'b10,2'b00,3'b111);	//2-0
		//Test_mode(2'b11,2'b00,3'b111);	//3-0
		Test_mode(2'b01,2'b01,3'b111);	//1-1
		//Test_mode(2'b01,2'b10,3'b111);	//1-2
		//Test_mode(2'b01,2'b11,3'b111);	//1-3
		//Test_mode(2'b10,2'b01,3'b111);	//2-1
		//Test_mode(2'b10,2'b10,3'b111);	//2-2
		//Test_mode(2'b10,2'b11,3'b111);	//2-3
		//Test_mode(2'b11,2'b01,3'b111);	//3-1
		//Test_mode(2'b11,2'b10,3'b111);	//3-2
		//Test_mode(2'b11,2'b11,3'b111);	//3-3
	endtask: body 
	task Test_mode(input [2:0] Xmode, input [2:0] Ymode,input [2:0] mode);
		begin
			Pattern_Generator_transaction ml_pkt;
			`uvm_info("", "Randomize Try0", UVM_MEDIUM)
			ml_pkt = Pattern_Generator_transaction::type_id::create(.name("ml_pkt"), .contxt(get_full_name()));
			start_item(ml_pkt); // Ramp 1-4 mode
			ml_pkt.X = Xmode;
			ml_pkt.Y = Ymode;
			ml_pkt.constVal = $urandom_range(4095, 0);
			ml_pkt.Mode = mode;
			finish_item(ml_pkt);
		end
	endtask : Test_mode
endclass: Pattern_Generator_sequence

typedef uvm_sequencer#(Pattern_Generator_transaction) Pattern_Generator_sequencer;


/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_driver.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

class Pattern_Generator_driver extends uvm_driver#(Pattern_Generator_transaction);
	`uvm_component_utils(Pattern_Generator_driver)

	virtual Pattern_Generator_if vif;
	virtual Pattern_Generator_Ref_if vrefif;

	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction: new

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		void'(uvm_resource_db#(virtual Pattern_Generator_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_if"), .val(vif)));
		void'(uvm_resource_db#(virtual Pattern_Generator_Ref_if)::read_by_name (.scope("ifs"), .name("Pattern_Generator_Ref_if"), .val(vrefif)));
	endfunction: build_phase

	task run_phase(uvm_phase phase);
		drive();
	endtask: run_phase

	virtual task drive();
		Pattern_Generator_transaction ml_pkt;
		integer state = 0;
		integer count = 0;
		integer random_number = 0;
		integer lines = 0;
		//vif.rst = 1'b1; driven from tb
		//vrefif.rst = 1'b1;
		vif.sync = 1'b0;
		vif.f_sync = 1'b0;
		`uvm_info("", "Drive Function of Driver", UVM_MEDIUM)
		forever begin
			`uvm_info("", "Forever of Driver", UVM_LOW)
			
			//seq_item_port.get_next_item(ml_pkt);
			//`uvm_info("NeuralNet_driver", ml_pkt.sprint(), UVM_LOW)
			

			@(negedge vif.clk)
			begin
				
				case(state)
					0: begin   //reset
						vif.rst_n = 1'b1;
						vrefif.rst_n = 1'b1;
						state = 1;
					end
					1: begin   //first sync
						 vif.rst_n = 1'b0;
						 vrefif.rst_n = 1'b0;
						 vif.f_sync = 1'b1;
						 vif.sync = 1'b1;
						 vrefif.f_sync = 1'b1;
						 vrefif.sync = 1'b1;
						seq_item_port.get_next_item(ml_pkt);
						vif.Mode = ml_pkt.Mode;
						vrefif.Mode = ml_pkt.Mode;
						vif.X = ml_pkt.X;
						vrefif.X = ml_pkt.X;
						vif.Y = ml_pkt.Y;
						vrefif.Y = ml_pkt.Y;
						vif.constVal = ml_pkt.constVal;
						vrefif.constVal = ml_pkt.constVal;
						state =2;
						if(ml_pkt.Mode == 3'b001) begin
							random_number = $urandom_range(6000, 4100);
						end else begin
							random_number = $urandom_range(3000, 1295);
						end
						 end
					2: begin   //Count normal
						 count = count + 1;
						 vif.f_sync = 1'b0;
						 vrefif.f_sync = 1'b0;
						 if(count > random_number) begin
							 lines = lines +1;
							 vif.sync = 1'b1;
							 vrefif.sync = 1'b1;
						 end else begin
							 vif.sync = 1'b0;
							 vrefif.sync = 1'b0;
						 end
						 if(lines == 25) begin
							 seq_item_port.item_done();
							 state = 1;
						 end else begin
							 state = 2;
						 end
					   end
				endcase
			end
		end
	endtask: drive
endclass:Pattern_Generator_driver

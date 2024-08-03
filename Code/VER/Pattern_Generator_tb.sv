/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_tb.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Pattern_Generator_tb;
reg 				clk;			//16ns master clock	
reg 				rst_n;			//Asynchronous active low reset
reg 				f_sync;			//First sync signal
reg 				sync;			//Sync signal, starts the count
reg [11:0]		constVal;		//constant value 
reg [1:0]			X;				//deltaX for ramp mode
reg [1:0] 		Y;				//deltaY for ramp mode
reg [2:0] 		Mode;			//work mode

// =================
//		Outputs
// =================
wire [11:0]		cnt;		//output count
Pattern_Generator_ref dut(.clk(clk),.f_sync(f_sync),.sync(sync),.constVal(constVal),.X(X),.Y(Y),.Mode(Mode),.cnt(cnt));

initial begin
	clk = 0;
end
always begin
	#8 clk = ~clk; //16 nsec
end

initial begin
	rst_n = 1;
	@(negedge clk);
	rst_n = 0;
	@(negedge clk);
	f_sync = 1;
	sync = 1;
	Mode = 001;
	//regular
	repeat(24) begin
		@(negedge clk);
		f_sync = 0;
		sync = 0;
		repeat(4500) @(negedge clk);
		sync = 1;
	end
	//Const
	@(negedge clk);
	f_sync = 1;
	sync = 1;
	Mode = 010;
	constVal = 12'd12;
	repeat(24) begin
		@(negedge clk);
		f_sync = 0;
		sync = 0;
		repeat(1350) @(negedge clk);
		sync = 1;
	end
	//CB1x1 white
	@(negedge clk);
	f_sync = 1;
	sync = 1;
	Mode = 011;
	constVal = 0;
	repeat(24) begin
		@(negedge clk);
		f_sync = 0;
		sync = 0;
		repeat(1350) @(negedge clk);
		sync = 1;
	end
	//CB1x1 black
	@(negedge clk);
	f_sync = 1;
	sync = 1;
	Mode = 100;
	repeat(24) begin
		@(negedge clk);
		f_sync = 0;
		sync = 0;
		repeat(1350) @(negedge clk);
		sync = 1;
	end
	//CB2x2 white
	@(negedge clk);
	f_sync = 1;
	sync = 1;
	Mode = 101;
	repeat(24) begin
		@(negedge clk);
		f_sync = 0;
		sync = 0;
		repeat(1350) @(negedge clk);
		sync = 1;
	end
	//CB2x2 black
	@(negedge clk);
	f_sync = 1;
	sync = 1;
	Mode = 110;
	repeat(24) begin
		@(negedge clk);
		f_sync = 0;
		sync = 0;
		repeat(1350) @(negedge clk);
		sync = 1;
	end
	//RAMP
	@(negedge clk);
	f_sync = 1;
	sync = 1;
	Mode = 111;
	X = 10;
	Y = 10;
	repeat(24) begin
		@(negedge clk);
		f_sync = 0;
		sync = 0;
		repeat(1350) @(negedge clk);
		sync = 1;
	end
	
	#100000 $finish;
	
end


endmodule
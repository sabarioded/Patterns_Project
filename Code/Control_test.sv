/*------------------------------------------------------------------------------
 * File          : Control_test.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Aug 13, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Control_test;

//inputs
reg clk;
reg rst_n;
reg 			f_sync;			//First sync signal
reg 			sync;			//Sync signal, starts the count
reg 			endLine;		//1 when the count ends
reg 			endFrame;		//1 when the frame ends
reg [1:0] 	X;				//deltaX for ramp mode
reg [2:0] 	Mode;			//work mode

//outputs
wire 			b12_enb;		//enable for Counter12Bit module
wire 			b5_enb;			//enable for Counter5Bit module
wire 			ramp_enb;		//enable for Ramp module
wire 			cnt_enb;		//enable for Counter module
wire 			test;			//1 if in test mode, 0 if in regular mode
wire 			newLine;		//1 when a new count starts
wire 			BinaryOrGray;	//1 for Gray count, 0 for Binary count
wire 			delta;			//1 for increment the starting value in the next row by deltaY (ramp mode)
wire [1:0]	Xmode;			//deltaX (00 for '0', 01 for '1', 10 for '4', 11 for '8')
wire [1:0]	ValSel;			//Select for LoadVal (00 for ramp, 01 for constant, 10 for 12'b1, 11 for counter output)

Control 		control(.clk(clk),.rst_n(rst_n),.f_sync(f_sync),.sync(sync),
	.endLine(endLine),.endFrame(endFrame),.X(X),.Mode(Mode),
	.b12_enb(b12_enb),.b5_enb(b5_enb),.ramp_enb(ramp_enb),.cnt_enb(cnt_enb),
	.test(test),.newLine(newLine), .BinaryOrGray(BinaryOrGray),.delta(delta),
	.Xmode(Xmode),.ValSel(ValSel));

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
	Mode = 3'b001;
	X = 2'b01;
	endLine = 0;
	endFrame = 0;
	@(negedge clk);
	sync =1;
	f_sync = 1;
	@(negedge clk);
	sync =0;
	f_sync = 0;
	repeat(10) @(negedge clk);
	endLine = 1;
	@(negedge clk);
	endLine = 0;
	@(negedge clk);
	repeat(10) @(negedge clk);
	endFrame = 1;
	endLine = 1;
	
	#1000 $finish;
	
end


endmodule
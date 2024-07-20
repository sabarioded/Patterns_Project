/*------------------------------------------------------------------------------
 * File          : Top.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : 
 *------------------------------------------------------------------------------*/
module Top( // =================
			//		Inputs
			// =================
			clk,
			rst_n, 
			f_sync,
			sync,
			constVal,
			X,
			Y,
			Mode,
				
			// =================
			//		Outputs
			// =================
			cnt
			);
//******************************************
//			Inputs & Outputs
//******************************************
// =================
//		Inputs
// =================
input 			clk;			//60ns master clock	
input 			rst_n;			//Asynchronous active low reset
input 			f_sync;			//First sync signal
input 			sync;			//Sync signal, starts the count
input [11:0]	constVal;		//constant value 
input [1:0]		X;				//deltaX for ramp mode
input [1:0] 	Y;				//deltaY for ramp mode
input [2:0] 	Mode;			//work mode

// =================
//		Outputs
// =================
output reg[11:0]	cnt;		//output count

//----------------------------------------------------------------------------------------------------------------------------
wire 		newLine;
wire		endLine;
wire 		endFrame;
wire		test;
wire		b12_enb;
wire		b5_enb;
wire		cnt_enb;
wire		ramp_enb;
wire [1:0]	Xmode;
reg[11:0] LoadVal;
wire [1:0]	ValSel;
wire		delta;
wire [11:0]	ramp_out;
wire [11:0]	counter_out;
wire 		BinaryOrGray;
wire [11:0]	gray_converter;

parameter Ramp=0, Const=1, Ones=2, Out=3;
parameter Binary=0, Gray=1;

always@(ValSel or ramp_out or constVal or counter_out or BinaryOrGray or gray_converter) begin
	case(ValSel)
		Ramp: LoadVal = ramp_out;
		Const: LoadVal = constVal;
		Ones: LoadVal = 12'b111111111111;
		Out: LoadVal = counter_out;
	endcase
	case(BinaryOrGray)
		Binary: cnt = counter_out;
		Gray: cnt = gray_converter;
	endcase
end
	
Binary2Gray B2G(.in(counter_out),.out(gray_converter));
Counter counter(.clk(clk),.rst_n(rst_n),.cnt_enb(cnt_enb),.Xmode(Xmode),.LoadVal(LoadVal),.out(counter_out));
Counter12Bit cnt12b(.clk(clk),.rst_n(rst_n),.b12_enb(b12_enb),.test(test),.endLine(endLine));
Counter5Bit cnt5b(.clk(clk),.rst_n(rst_n),.b5_enb(b5_enb),.newLine(newLine),.endFrame(endFrame));
Ramp ramp(.clk(clk),.rst_n(rst_n),.ramp_enb(ramp_enb),.delta(delta),.Y(Y),.out(ramp_out));
Control control(.clk(clk),.rst_n(rst_n),.f_sync(f_sync),.sync(sync),.endLine(endLine),.endFrame(endFrame),.X(X),.Mode(Mode),
				.b12_enb(b12_enb),.b5_enb(b5_enb),.ramp_enb(ramp_enb),.cnt_enb(cnt_enb),.test(test),.newLine(newLine),
				.BinaryOrGray(BinaryOrGray),.delta(delta),.Xmode(Xmode),.ValSel(ValSel));

endmodule

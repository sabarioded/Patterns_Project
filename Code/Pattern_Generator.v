/*------------------------------------------------------------------------------
 * File          : Pattern_Generator.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : This module serves as the comprehensive unit that interconnects all the components within the system.
 *------------------------------------------------------------------------------*/
module Pattern_Generator(
	// =================
	//      Inputs
	// =================
	clk,            //16ns master clock    
	rst_n,          //Asynchronous active low reset
	f_sync,         //First sync signal
	sync,           //Sync signal, starts the count
	constVal,       //constant value 
	X,              //deltaX for ramp mode
	Y,              //deltaY for ramp mode
	Mode,           //work mode
	
	// =================
	//      Outputs
	// =================
	cnt             //output count
);
// =================
//      Inputs
// =================
input               clk;            //16ns master clock    
input               rst_n;          //Asynchronous active low reset
input               f_sync;         //First sync signal
input               sync;           //Sync signal, starts the count
input [11:0]        constVal;       //constant value 
input [1:0]         X;              //deltaX for ramp mode
input [1:0]         Y;              //deltaY for ramp mode
input [2:0]         Mode;           //work mode

// =================
//      Outputs
// =================
output reg [11:0]   cnt;             //output count

//----------------------------------------------------------------------------------------------------------------------------
// Internal signals
//----------------------------------------------------------------------------------------------------------------------------
wire                 newLine;
wire                 endLine;
wire                 endFrame;
wire                 test;
wire                 b12_enb;
wire                 b5_enb;
wire                 cnt_enb;
wire                 ramp_enb;
wire [1:0]           Xmode;
wire [11:0]          LoadVal;
wire [1:0]           ValSel;
wire                 delta;
wire [11:0]          ramp_out;
wire [11:0]          counter_out;
wire                 BinaryOrGray;
wire [11:0]          gray_converter;

parameter Ramp = 2'b00, Const = 2'b01, Ones = 2'b10, Out = 2'b11;
parameter Binary = 1'b0, Gray = 1'b1;

// Output multiplexer
assign LoadVal = (ValSel == Ramp)   ? ramp_out :
				 (ValSel == Const)  ? constVal :
				 (ValSel == Ones)   ? 12'hFFF :
				 (ValSel == Out)    ? counter_out :
				 12'h000; // default case


// Counter and Gray/Binary selection
always @(posedge clk or negedge rst_n) begin
	if (~rst_n)
		cnt <= 12'h000;
	else begin
		case (BinaryOrGray)
			Binary: cnt <= counter_out;
			Gray:   cnt <= gray_converter;
			default: cnt <= 12'h000;
		endcase
	end
end

// Sub-module instantiations
Binary2Gray B2G (
	.in(counter_out),
	.out(gray_converter)
);

Counter counter (
	.clk(clk),
	.rst_n(rst_n),
	.cnt_enb(cnt_enb),
	.Xmode(Xmode),
	.LoadVal(LoadVal),
	.out(counter_out)
);

Counter12Bit cnt12b (
	.clk(clk),
	.rst_n(rst_n),
	.b12_enb(b12_enb),
	.test(test),
	.endLine(endLine)
);

Counter5Bit cnt5b (
	.clk(clk),
	.rst_n(rst_n),
	.b5_enb(b5_enb),
	.newLine(newLine),
	.endFrame(endFrame)
);

Ramp ramp (
	.clk(clk),
	.rst_n(rst_n),
	.ramp_enb(ramp_enb),
	.delta(delta),
	.Y(Y),
	.out(ramp_out)
);

Control control (
	.clk(clk),
	.rst_n(rst_n),
	.f_sync(f_sync),
	.sync(sync),
	.endLine(endLine),
	.endFrame(endFrame),
	.X(X),
	.Mode(Mode),
	.b12_enb(b12_enb),
	.b5_enb(b5_enb),
	.ramp_enb(ramp_enb),
	.cnt_enb(cnt_enb),
	.test(test),
	.newLine(newLine),
	.BinaryOrGray(BinaryOrGray),
	.delta(delta),
	.Xmode(Xmode),
	.ValSel(ValSel)
);

endmodule
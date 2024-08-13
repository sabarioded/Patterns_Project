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
	input               clk,            //16ns master clock    
	input               rst_n,          //Asynchronous active low reset
	input               f_sync,         //First sync signal
	input               sync,           //Sync signal, starts the count
	input [11:0]        constVal,       //constant value 
	input [1:0]         X,              //deltaX for ramp mode
	input [1:0]         Y,              //deltaY for ramp mode
	input [2:0]         Mode,           //work mode
	
	// =================
	//      Outputs
	// =================
	output reg [11:0]   cnt             //output count
);

//----------------------------------------------------------------------------------------------------------------------------
// Internal signals
//----------------------------------------------------------------------------------------------------------------------------
reg                 newLine;
reg                 endLine;
reg                 endFrame;
reg                 test;
reg                 b12_enb;
reg                 b5_enb;
reg                 cnt_enb;
reg                 ramp_enb;
reg [1:0]           Xmode;
reg [11:0]          LoadVal;
reg [1:0]           ValSel;
reg                 delta;
reg [11:0]          ramp_out;
reg [11:0]          counter_out;
reg                 BinaryOrGray;
reg [11:0]          gray_converter;

parameter Ramp = 2'b00, Const = 2'b01, Ones = 2'b10, Out = 2'b11;
parameter Binary = 1'b0, Gray = 1'b1;

// Output multiplexer
always @(*) begin
	case (ValSel)
		Ramp:   LoadVal = ramp_out;
		Const:  LoadVal = constVal;
		Ones:   LoadVal = 12'hFFF;
		Out:    LoadVal = counter_out;
		default: LoadVal = 12'h000;
	endcase
end

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
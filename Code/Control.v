/*------------------------------------------------------------------------------
 * File          : Control.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : 
 *------------------------------------------------------------------------------*/
module Control( // =================
				//		Inputs
				// =================
				clk,
				rst_n, 
				f_sync,
				sync,
				endLine,
				endFrame,
				X,
				Mode,
				
				// =================
				//		Outputs
				// =================
				b12_enb,
				b5_enb,
				ramp_enb,
				cnt_enb,
				test,
				newLine,
				BinaryOrGray,
				delta,
				Xmode,
				ValSel
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
input 			endLine;		//1 when the count ends
input 			endFrame;		//1 when the frame ends
input [1:0] 	X;				//deltaX for ramp mode
input [2:0] 	Mode;			//work mode

// =================
//		Outputs
// =================
output reg		b12_enb;		//enable for Counter12Bit module
output reg		b5_enb;			//enable for Counter5Bit module
output reg		ramp_enb;		//enable for Ramp module
output reg		cnt_enb;		//enable for Counter module
output reg		test;			//1 if in test mode, 0 if in regular mode
output reg		newLine;		//1 when a new count starts
output reg		BinaryOrGray;	//1 for Gray count, 0 for Binary count
output reg		delta;			//1 for increment the starting value in the next row by deltaY (ramp mode)
output reg[1:0]	Xmode;			//deltaX (00 for '0', 01 for '1', 10 for '4', 11 for '8')
output reg[1:0]	ValSel;			//Select for LoadVal (00 for ramp, 01 for constant, 10 for 12'b1, 11 for counter output)

//----------------------------------------------------------------------------------------------------------------------------

parameter IDLE=0, START=1, Normal=2, Constant=3, CB1x1=4 ,CB2x2=5 ,Ramp=6;
parameter Regular=1, Const=2, White1x1=3, Black1x1=4, White2x2=5, Black2x2=6, RampMode=7;
reg[2:0] STATE, NEXT_STATE;
reg [1:0] flag;
reg flag2x2;

always@(STATE or Mode or X or flag or flag2x2) begin
	
	case(STATE)
		IDLE: begin
			b12_enb = 0;
			b5_enb = 0;
			ramp_enb = 0;
			cnt_enb = 0;
		end
		START: begin
			case(Mode)
				Regular:begin
					BinaryOrGray = 1;
					newLine = 1;
					test = 0;
					NEXT_STATE = Normal;
				end
				Const:begin
					newLine = 1;
					ValSel = 2'b01;
					NEXT_STATE = Constant;
				end
				White1x1:begin
					newLine = 1;
					if(flag[0] == 0)
						ValSel = 2'b00;
					else
						ValSel = 2'b10;
					NEXT_STATE = CB1x1;
				end
				Black1x1:begin
					newLine = 1;
					if(flag[0] == 0)
						ValSel = 2'b10;
					else
						ValSel = 2'b00;
					NEXT_STATE = CB1x1;
				end
				White2x2:begin
					newLine = 1;
					if(flag[1] == 0)
						ValSel = 2'b00;
					else
						ValSel = 2'b10;
					NEXT_STATE = CB2x2;
				end
				Black2x2:begin
					newLine = 1;
					if(flag[1] == 0)
						ValSel = 2'b10;
					else
						ValSel = 2'b00;
					NEXT_STATE = CB2x2;
				end
				RampMode:begin
					ramp_enb = 1;
					newLine = 1;
					ValSel = 2'b00;
					NEXT_STATE = Ramp;
				end
			endcase
		end
		Normal: begin
			test = 0;
			BinaryOrGray = 1;
			if(endLine == 0) begin
				Xmode = 1;
				ValSel = 2'b11;
			end
			else begin
				cnt_enb = 0;
				b12_enb = 0;
				if(endFrame == 1) begin
					NEXT_STATE = IDLE;
				end
			end
			if(sync == 1) begin
				NEXT_STATE = START;
			end
			else
				NEXT_STATE = STATE;
		end
		Constant: begin
			if(endLine == 0) begin
				Xmode = 0;
				ValSel = 2'b01;
			end
			else begin
				cnt_enb = 0;
				b12_enb = 0;
				if(endFrame == 1) begin
					NEXT_STATE = IDLE;
				end
			end
			if(sync == 1) begin
				NEXT_STATE = START;
			end
			else
				NEXT_STATE = STATE;
		end
		CB1x1: begin
			if(endLine == 0) begin
				ValSel[1] = ~ValSel[1];
			end
			else begin
				cnt_enb = 0;
				b12_enb = 0;
				if(endFrame == 1) begin
					NEXT_STATE = IDLE;
				end
			end
			if(sync == 1) begin
				flag[0] = ~flag[0];
				NEXT_STATE = START;
			end
			else
				NEXT_STATE = STATE;
		end
		CB2x2: begin
			if(endLine == 0) begin
				ValSel[1] = (flag2x2) ? ~ValSel[1]:ValSel[1];
				flag2x2 = ~flag2x2;
			end
			else begin
				cnt_enb = 0;
				b12_enb = 0;
				if(endFrame == 1) begin
					NEXT_STATE = IDLE;
				end
			end
			if(sync == 1) begin
				flag = flag + 1;
				NEXT_STATE = START;
			end
			else
				NEXT_STATE = STATE;
		end
		Ramp: begin
			if(endLine == 0) begin
				Xmode = X;
				ValSel = 2'b11;
			end
			else begin
				cnt_enb = 0;
				b12_enb = 0;
				if(endFrame == 1) begin
					NEXT_STATE = IDLE;
				end
			end
			if(sync == 1) begin
				delta = 1;
				NEXT_STATE = START;
			end
			else
				NEXT_STATE = STATE;
		end
		default begin
			b12_enb = 1;
			b5_enb = 1;
			ramp_enb = 0;
			cnt_enb = 1;
			test = 1;
			newLine = 0;
			BinaryOrGray = 0;
			delta = 0;
			Xmode = 0;
			ValSel = 0;
			flag = 0;
			flag2x2 =  0;
			NEXT_STATE = STATE;
		end
	endcase
	
end

always@(posedge clk or negedge rst_n) begin
	if(rst_n) begin
		STATE <= IDLE;
	end else begin
		STATE <= NEXT_STATE;
	end
	
end

endmodule
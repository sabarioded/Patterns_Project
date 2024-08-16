/*------------------------------------------------------------------------------
 * File          : Control.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : This module is the control block of the system.
					This state mealy machine has 7 states:
					IDLE: while the system is inactive.
					START: prepare the system for the next run.
					NORMAL: Count up to 4095 using gray code.
					CONSTANT: test mode, the output is a constant val from user input, 1290 values.
					CB1x1: test mode, the output is a 1x1 checkerboard, white is 12'b0 and black is 12'b1. 1290 values.
					CB2x2: test mode, the output is a 2x2 checkerboard where white is 12'b0 and black is 12'b1, 1290 values. 
					RAMP: test mode, count with increments of deltaX between coloumns and deltaY between rows, 1290 values. 
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
input 			clk;			//16ns master clock	
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
output 			b12_enb;		//enable for Counter12Bit module
output 			b5_enb;			//enable for Counter5Bit module
output 			ramp_enb;		//enable for Ramp module
output 			cnt_enb;		//enable for Counter module
output 			test;			//1 if in test mode, 0 if in regular mode
output 			newLine;		//1 when a new count starts
output 			BinaryOrGray;	//1 for Gray count, 0 for Binary count
output 			delta;			//1 for increment the starting value in the next row by deltaY (ramp mode)
output [1:0]	Xmode;			//deltaX (00 for '0', 01 for '1', 10 for '4', 11 for '8')
output [1:0]	ValSel;			//Select for LoadVal (00 for ramp, 01 for constant, 10 for 12'b1, 11 for counter output)

//----------------------------------------------------------------------------------------------------------------------------
reg				b12_enb;		
reg				b5_enb;			
reg				ramp_enb;		
reg				cnt_enb;		
reg				test;			
reg				newLine;		
reg				BinaryOrGray;	
reg				delta;			
reg [1:0]		Xmode;			
reg [1:0]		ValSel;	
reg [2:0] 		STATE;
reg [2:0]		NEXT_STATE;
reg [1:0] 		flag;
reg [1:0]		flag2x2;
reg 			keepCount;

parameter IDLE=3'b000, START=3'b001, NORMAL=3'b010, CONSTANT=3'b011, CB0=3'b100 ,CB1=3'b101 ,RAMP=3'b110; //Possible states
parameter REGULAR=3'b001, CONST=3'b010, WHITE1x1=3'b011, BLACK1x1=3'b100, WHITE2x2=3'b101, BLACK2x2=3'b110, RAMP_MODE=3'b111; //Work modes

//Calculate the next state
always@(STATE or Mode or sync or f_sync or endFrame or endLine or flag2x2) begin
	case(STATE)
		IDLE: 	  NEXT_STATE = (f_sync & sync) 		? START 	: IDLE; 
		START: 	  NEXT_STATE = (Mode == REGULAR) 	? NORMAL 	: 
							   (Mode == CONST) 	 	? CONSTANT 	:
							   (Mode == WHITE1x1) 	? (flag[0] ? CB0 : CB1) 	:
							   (Mode == BLACK1x1) 	? (flag[0] ? CB1 : CB0) 	:
							   (Mode == WHITE2x2) 	? (flag[1] ? CB1 : CB0) 	:
							   (Mode == BLACK2x2) 	? (flag[1] ? CB0 : CB1) 	:
							   (Mode == RAMP_MODE) 	? RAMP 		: IDLE;
		NORMAL:   NEXT_STATE = sync 				? START 	: 
							   (endFrame & endLine) ? IDLE 		: NORMAL;
		CONSTANT: NEXT_STATE = sync 				? START 	: 
							   (endFrame & endLine) ? IDLE 		: CONSTANT;
		CB0:    NEXT_STATE = sync 				? START 	: 
							   (endFrame & endLine) ? IDLE 		:
							   (flag2x2[0])			? CB0		:	CB1;
		CB1:    NEXT_STATE = sync 				? START 	: 
							   (endFrame & endLine) ? IDLE 		: 
							   (flag2x2[0]) 			? CB1       : CB0;
		RAMP:     NEXT_STATE = sync 				? START 	: 
							   (endFrame & endLine) ? IDLE 		: RAMP;
		default:  NEXT_STATE = IDLE;
	endcase
end



always@(STATE or Mode or X or flag or flag2x2 or endLine or sync) begin
	
	case(STATE)
		IDLE: begin
			b12_enb = 1'b0;
			b5_enb = 1'b0;
			ramp_enb = 1'b0;
			cnt_enb = 1'b0;
			test = 1'b0;
			newLine = 1'b0;
			BinaryOrGray = 1'b0;
			delta = 1'b0;
			Xmode = 2'b00;
			ValSel = 2'b00;
			flag = 2'b00;
			keepCount = 1'b0;
		end //end IDLE mode
		START: begin
			keepCount = 1'b1;
			newLine = 1'b1;
			cnt_enb = 1'b1;
			b12_enb = 1'b0;
			b5_enb = 1'b1;
			Xmode = 2'b00;
			delta = 1'b0;
			case(Mode)
				REGULAR:begin
					BinaryOrGray = 1'b1;
					test = 1'b0;
				end
				CONST:begin
					ValSel = 2'b01;
				end
				WHITE1x1:begin
					if(flag[0] == 1'b0)
						ValSel = 2'b00;
					else
						ValSel = 2'b10;
				end
				BLACK1x1:begin
					if(flag[0] == 1'b0)
						ValSel = 2'b10;
					else
						ValSel = 2'b00;
				end
				WHITE2x2:begin
					if(flag[1] == 1'b0)
						ValSel = 2'b00;
					else
						ValSel = 2'b10;
				end
				BLACK2x2:begin
					if(flag[1] == 1'b0)
						ValSel = 2'b10;
					else
						ValSel = 2'b00;
				end
				RAMP_MODE:begin
					ramp_enb = 1'b1;
					ValSel = 2'b00;
				end
			endcase
		end//End START mode
		NORMAL: begin
			newLine = 1'b0;
			test = 1'b0;
			BinaryOrGray = 1'b1;
			if((endLine == 1'b0) & (keepCount == 1'b1)) begin
				Xmode = 1'b1;
				ValSel = 2'b11;
				cnt_enb = 1'b1;
				b12_enb = 1'b1;
			end else begin
				cnt_enb = 1'b0;
				b12_enb = 1'b0;
				keepCount = 1'b0;
			end
		end //end NORMAL mode
		CONSTANT: begin
			newLine = 1'b0;
			test = 1'b1;
			if((endLine == 1'b0) & (keepCount == 1'b1)) begin
				Xmode = 1'b0;
				ValSel = 2'b01;
				cnt_enb = 1'b1;
				b12_enb = 1'b1;
			end else begin
				cnt_enb = 1'b0;
				b12_enb = 1'b0;
				keepCount = 1'b0;
			end
		end //end CONSTANT mode
		CB0: begin
			newLine = 1'b0;
			test = 1'b1;
			if((endLine == 1'b0) & (keepCount == 1'b1)) begin
				ValSel = 2'b00;
				cnt_enb = 1'b1;
				b12_enb = 1'b1;
			end else begin
				cnt_enb = 1'b0;
				b12_enb = 1'b0;
				keepCount = 1'b0;
			end
			case(Mode)
				WHITE1x1: flag[0] = (sync) ? ~flag[0] : flag[0];
				BLACK1x1: flag[0] = (sync) ? ~flag[0] : flag[0];
				WHITE2x2: begin 
						flag = (sync) ? (flag+2'b01) : flag;
						end
				BLACK2x2: begin
						flag = (sync) ? (flag+2'b01) : flag;
						end
				default: begin 
						flag = 2'b00;
						end
			endcase
		end // End CB0 mode
		CB1: begin
			newLine = 1'b0;
			test = 1'b1;
			if((endLine == 1'b0) & (keepCount == 1'b1)) begin
				ValSel = 2'b10;
				cnt_enb = 1'b1;
				b12_enb = 1'b1;
			end else begin
				cnt_enb = 1'b0;
				b12_enb = 1'b0;
				keepCount = 1'b0;
			end
			case(Mode)
				WHITE1x1: flag[0] = (sync) ? ~flag[0] : flag[0];
				BLACK1x1: flag[0] = (sync) ? ~flag[0] : flag[0];
				WHITE2x2: begin 
						flag = (sync) ? (flag+2'b01) : flag;
						end
				BLACK2x2: begin
						flag = (sync) ? (flag+2'b01) : flag;
						end
				default: begin 
						flag = 2'b00;
						end
			endcase
		end // End CB1 mode
		RAMP: begin
			newLine = 1'b0;
			test = 1'b1;
			ramp_enb = 1'b1;
			Xmode = X;
			if((endLine == 1'b0) & (keepCount == 1'b1)) begin
				cnt_enb = 1'b1;
				b12_enb = 1'b1;
				ValSel = 2'b11;
			end else begin
				cnt_enb = 1'b0;
				b12_enb = 1'b0;
				keepCount = 1'b0;
			end
			if(sync == 1'b1)
				delta = 1'b1;
			else
				delta = 1'b0;
		end // End RAMP mode
		default begin
			b12_enb = 1'b0;
			b5_enb = 1'b0;
			ramp_enb = 1'b0;
			cnt_enb = 1'b0;
			test = 1'b0;
			newLine = 1'b0;
			BinaryOrGray = 1'b0;
			delta = 1'b0;
			Xmode = 2'b00;
			ValSel = 2'b00;
			flag = 2'b00;
			keepCount = 1'b0;
		end
	endcase
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		flag2x2 <= 2'b00;
	end else begin
		case(Mode)
			WHITE2x2: begin
				flag2x2 <= flag2x2 + 2'b01;
					end
			BLACK2x2: begin
				flag2x2 <= flag2x2 + 2'b01;
					end
			default: begin 
					flag2x2 <= 2'b00;
					end
		endcase
	end	
end

always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		STATE <= IDLE;
	end else begin
		STATE <= NEXT_STATE;
	end	
end

endmodule
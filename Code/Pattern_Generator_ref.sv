/*------------------------------------------------------------------------------
 * File          : Pattern_Generator_ref.sv
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 30, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Pattern_Generator_ref (
// =================
//		Inputs
// =================
	input 				clk,			//16ns master clock	
	input 				rst_n,			//Asynchronous active low reset
	input 				f_sync,			//First sync signal
	input 				sync,			//Sync signal, starts the count
	input [11:0]		constVal,		//constant value 
	input [1:0]			X,				//deltaX for ramp mode
	input [1:0] 		Y,				//deltaY for ramp mode
	input [2:0] 		Mode,			//work mode

// =================
//		Outputs
// =================
	output [11:0]		cnt		//output count
);
logic [11:0] Counter,counter_out,counterY;
logic [4:0] endCnt;
logic endFrame;
logic FLAG;
logic [1:0] FLAG2x2;
logic [11:0] deltaX,deltaY;
reg [2:0] 		STATE;
reg [2:0]		NEXT_STATE;

parameter REGULAR=3'b001, CONST=3'b010, WHITE1x1=3'b011, BLACK1x1=3'b100, WHITE2x2=3'b101, BLACK2x2=3'b110, RAMP_MODE=3'b111; //Work modes
parameter COUNT = 2'b00, WAIT =2'b01, OFF=2'b10, END_COUNT=2'b11;
parameter ZERO=2'b00, ONE=2'b01, FOUR=2'b10, EIGHT=2'b11;
parameter Y0=2'b00, Y1=2'b01, Y16=2'b10, Y1290=2'b11;

always_ff@(posedge clk, negedge rst_n) begin
	if(~rst_n) begin
		counter_out = 12'h000; 
	end else begin
		case(STATE)
			OFF: begin
				NEXT_STATE = (sync & f_sync) ? WAIT : OFF;
				endCnt = 0;
				Counter = 0;
				counter_out = 0;
				endFrame = 0;
				counterY = 0;
				FLAG = 0;
				FLAG2x2 = 0;
			end
			WAIT: begin
				endCnt = endCnt+1;
				NEXT_STATE = COUNT;
				if(endCnt == 12'd23) begin
					endFrame = 1'b1;
				end
				case(Mode)
					REGULAR: ;
					CONST: ;
					WHITE1x1: FLAG = (endCnt % 2 == 0) ? 0 : 1;
					BLACK1x1: FLAG = (endCnt % 2 == 0) ? 1 : 0;
					WHITE2x2: FLAG2x2 = ((endCnt % 4 == 0) || endCnt % 4 == 1) ? 2'b00 : 2'b10; 
					BLACK2x2: FLAG2x2 = ((endCnt % 4 == 0) || endCnt % 4 == 1) ? 2'b10 : 2'b00;
					RAMP_MODE: begin
						case(X)
							ZERO:		deltaX = 12'h000;
							ONE:		deltaX = 12'h001;
							FOUR:		deltaX = 12'h004;
							EIGHT:		deltaX = 12'h008;
							default:	deltaX = 12'h000;
						endcase
						case(Y)
							Y0:			deltaY = 12'h000; //0
							Y1:			deltaY = 12'h001; //1
							Y16:		deltaY = 12'h010; //16
							Y1290:		deltaY = 12'h50A; //1290
							default:	deltaY = 12'h000;
						endcase
						counterY = counterY;
					end
					default begin
						FLAG = 0;
						FLAG2x2 = 0;
						counter_out = 0;
						counterY = 0;
					end
				endcase
				endCnt = endCnt+1;
				Counter = 12'h000;
			end
			COUNT: begin
				case(Mode)
					REGULAR: begin						
						for(int i=0; i<11; i++) begin
							counter_out[i] = Counter[i]^Counter[i+1];
						end
						counter_out[11] = Counter[11];
						if(Counter == 12'd4095) begin
							if(endFrame) begin
								NEXT_STATE = OFF;
							end else						
								NEXT_STATE = END_COUNT;
						end
						Counter = Counter+1;
					end //REGULAR
					CONST: begin
						Counter = Counter+1;
						counter_out = constVal;
						if(Counter == 12'd1290) begin
							if(endFrame) begin
								NEXT_STATE = OFF;
							end else
								NEXT_STATE = END_COUNT;
						end
					end //CONST
					WHITE1x1: begin
						Counter = Counter+1;
						if(FLAG) begin
							counter_out = ~counter_out;
						end else begin
							counter_out = 0;
							FLAG = 1;
						end
						if(Counter == 12'd1290) begin
							if(endFrame) begin
								NEXT_STATE = OFF;
							end else
								NEXT_STATE = END_COUNT;
						end
					end //WHITE1x1
					BLACK1x1: begin
						if(FLAG) begin
							counter_out = ~counter_out;
						end else begin
							counter_out = 12'h000;
							FLAG = 1;
						end
						Counter = Counter+1;
						if(Counter == 12'd1290) begin
							if(endFrame) begin
								NEXT_STATE = OFF;
							end else
								NEXT_STATE = END_COUNT;
						end
					end //BLACK1x1
					WHITE2x2: begin
						if(FLAG2x2[1]) begin
							counter_out = 12'hfff;
						end else begin
							counter_out = 12'h000;
						end
						FLAG2x2 = FLAG2x2 +1;
						Counter = Counter+1;
						if(Counter == 12'd1290) begin
							if(endFrame) begin
								NEXT_STATE = OFF;
							end else
								NEXT_STATE = END_COUNT;
						end
					end //WHITE2x2
					BLACK2x2: begin
						if(FLAG2x2[1]) begin
							counter_out = 12'hfff;
						end else begin
							counter_out = 12'h000;
						end
						FLAG2x2 = FLAG2x2 +1;
						Counter = Counter+1;
						if(Counter == 12'd1290) begin
							if(endFrame) begin
								NEXT_STATE = OFF;
							end else
								NEXT_STATE = END_COUNT;
						end
					end //BLACK2x2
					RAMP_MODE: begin
						if(FLAG) begin
							counter_out = counter_out + deltaX;
						end else begin
							counter_out = counterY;
							FLAG = 1;
						end
						Counter = Counter+1;
						if(Counter == 12'd1290) begin
							if(endFrame) begin
								NEXT_STATE = OFF;
							end else begin
								counterY = counterY + deltaY;
								NEXT_STATE = END_COUNT;
							end
						end
					end //RAMP_MODE
				endcase
			end
			END_COUNT: begin
				counter_out = 0;
				NEXT_STATE = sync ? WAIT : END_COUNT;
			end
		endcase
	end
end
assign cnt = counter_out;


endmodule

module Pattern_Generator_ref (
	input  clk,            // 16ns master clock
	input  rst_n,          // Asynchronous active low reset
	input  f_sync,         // First sync signal
	input  sync,           // Sync signal, starts the count
	input  [11:0] constVal,// constant value 
	input  [1:0] X,        // deltaX for ramp mode
	input  [1:0] Y,        // deltaY for ramp mode
	input  [2:0] Mode,     // work mode

	output reg [11:0] cnt     // output count
);

	logic [11:0] counterY;
	logic [12:0] Counter;
	logic [4:0] endCnt;
	logic endFrame, endLine;
	logic FLAG;
	logic [1:0] FLAG2x2;
	logic [11:0] deltaX, deltaY;
	logic [2:0] STATE, NEXT_STATE;

	// Work modes
	parameter REGULAR = 3'b001, CONST = 3'b010, WHITE1x1 = 3'b011, BLACK1x1 = 3'b100, WHITE2x2 = 3'b101, BLACK2x2 = 3'b110, RAMP_MODE = 3'b111;

	// State definitions
	parameter IDLE=3'b000, START=3'b001, NORMAL=3'b010, CONSTANT=3'b011, CB1x1=3'b100 ,CB2x2=3'b101 ,RAMP=3'b110; //Possible states

	// deltaX parameters
	parameter ZERO = 2'b00, ONE = 2'b01, FOUR = 2'b10, EIGHT = 2'b11;

	// deltaY parameters
	parameter Y0 = 2'b00, Y1 = 2'b01, Y16 = 2'b10, Y1290 = 2'b11;

	// State register
	always_ff @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			STATE <= IDLE; 
		end else begin
			STATE <= NEXT_STATE;
		end
	end
	
	//state transition
	always_comb begin
		case(STATE)
			IDLE: 	  NEXT_STATE <= (f_sync & sync) 	? START 	: IDLE; 
			START: 	  NEXT_STATE <= (Mode == REGULAR) 	? NORMAL 	: 
								   (Mode == CONST) 	 	? CONSTANT 	:
								   (Mode == WHITE1x1) 	? CB1x1 	:
								   (Mode == BLACK1x1) 	? CB1x1 	:
								   (Mode == WHITE2x2) 	? CB2x2 	:
								   (Mode == BLACK2x2) 	? CB2x2 	:
								   (Mode == RAMP_MODE) 	? RAMP 		: IDLE;
			NORMAL:   NEXT_STATE <= sync 				? START 	: 
								   (endFrame & endLine) ? IDLE 		: NORMAL;
			CONSTANT: NEXT_STATE <= sync 				? START 	: 
								   (endFrame & endLine) ? IDLE 		: CONSTANT;
			CB1x1:    NEXT_STATE <= sync 				? START 	: 
								   (endFrame & endLine) ? IDLE 		: CB1x1;
			CB2x2:    NEXT_STATE <= sync 				? START 	: 
								   (endFrame & endLine) ? IDLE 		: CB2x2;
			RAMP:     NEXT_STATE <= sync 				? START 	: 
								   (endFrame & endLine) ? IDLE 		: RAMP;
			default:  NEXT_STATE <= IDLE;
		endcase
	end
	
	//FSM logic
	always_ff@(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			cnt <= 12'h000;
			endCnt <= 5'b00000;
			endFrame <= 0;
			endLine <= 0;
			FLAG <= 0;
			FLAG2x2 <= 2'b00;
			deltaX <= 12'h000;
			deltaY <= 12'h000;
			Counter <= 12'h000;
			counterY <= 12'h000;
		end else begin
		case(STATE)
			IDLE: begin
				cnt <= 12'h000;
				endCnt <= 5'h00;
				endFrame <= 0;
				endLine <= 0;
				FLAG <= 0;
				FLAG2x2 <= 2'b00;
				deltaX <= 12'h000;
				deltaY <= 12'h000;
				Counter <= 12'h000;
				counterY <= 12'h000;
			end //end IDLE mode
			START: begin
				case(Mode)
					REGULAR:begin
						endCnt <= endCnt +1;
						endLine <= 0;
						Counter <= 0;
						cnt <= 12'h000;
					end
					CONST:begin
						endCnt <= endCnt +1;
						endLine <= 0;
						endFrame <= 0;
						Counter <= 0;
						cnt <= 12'h000;
					end
					WHITE1x1:begin
						endCnt <= endCnt +1;
						endLine <= 0;
						Counter <= 0;
						cnt <= 12'h000;
						FLAG <= (endCnt % 2 == 0) ? 0 : 1;
					end
					BLACK1x1:begin
						endCnt <= endCnt +1;
						endLine <= 0;
						Counter <= 0;
						cnt <= 12'h000;
						FLAG <= (endCnt % 2 == 0) ? 1 : 0;
					end
					WHITE2x2:begin
						endCnt <= endCnt +1;
						endLine <= 0;
						Counter <= 0;
						cnt <= 12'h000;
						FLAG2x2 <= ((endCnt % 4 == 0) || endCnt % 4 == 1) ? 2'b00 : 2'b10;
					end
					BLACK2x2:begin
						endCnt <= endCnt +1;
						endLine <= 0;
						Counter <= 0;
						cnt <= 12'h000;
						FLAG2x2 <= ((endCnt % 4 == 0) || endCnt % 4 == 1) ? 2'b10 : 2'b00;
					end
					RAMP_MODE:begin
						endCnt = endCnt +1;
						endLine <= 0;
						Counter <= 0;
						cnt <= 12'h000;
						case (X)
							ZERO: deltaX <= 12'h000;
							ONE: deltaX <= 12'h001;
							FOUR: deltaX <= 12'h004;
							EIGHT: deltaX <= 12'h008;
							default: deltaX <= 12'h000;
						endcase
						case (Y)
							Y0: deltaY <= 12'h000;
							Y1: deltaY <= 12'h001;
							Y16: deltaY <= 12'h010;
							Y1290: deltaY <= 12'h50A;
							default: deltaY <= 12'h000;
						endcase
						FLAG <= 0;
					end
				endcase
			end//End START mode
			NORMAL: begin
				if (Counter > 12'd4095) begin
					endLine <= 1;
					cnt <= 12'h000;
					Counter <= Counter;
					if(endCnt == 12'd24) begin
						endFrame <= 1;
					end
				end else begin
					for (int i = 0; i < 11; i++) begin
						cnt[i] <= Counter[i] ^ Counter[i + 1];
					end
					cnt[11] <= Counter[11];
					Counter <= Counter + 1;
				end
			end //end NORMAL mode
			CONSTANT: begin
				if (Counter > 12'd1289) begin
					endLine <= 1;
					cnt <= 12'h000;
					Counter <= Counter;
					if(endCnt == 12'd24) begin
						endFrame <= 1;
					end
				end else begin
					cnt <= constVal;
					Counter <= Counter + 1;
				end
			end //end CONSTANT mode
			CB1x1: begin
				if (Counter > 12'd1289) begin
					endLine <= 1;
					cnt <= 12'h000;
					Counter <= Counter;
					if(endCnt == 12'd24) begin
						endFrame <= 1;
					end
				end else begin
					if (FLAG) begin
						cnt <= ~cnt;
					end else begin
						cnt <= 12'h000;
						FLAG <= 1;
					end
					Counter <= Counter + 1;
				end
			end // End CB1x1 mode
			CB2x2: begin
				if (Counter > 12'd1289) begin
					endLine <= 1;
					cnt <= 12'h000;
					Counter <= Counter;
					if(endCnt == 12'd24) begin
						endFrame <= 1;
					end
				end else begin
					if (FLAG2x2[1]) begin
						cnt <= 12'hfff;
					end else begin
						cnt <= 12'h000;
					end
					FLAG2x2 <= FLAG2x2 + 1;
					Counter <= Counter + 1;
				end
			end // End CB2x2 mode
			RAMP: begin
				if (Counter > 12'd1289) begin
					endLine <= 1;
					cnt <= 12'h000;
					Counter <= Counter;
					if(endCnt == 12'd24) begin
						endFrame <= 1;
					end
					if(FLAG) begin
						counterY <= counterY + deltaY;
						FLAG <= 0;
					end
				end else begin
					if (FLAG) begin
						cnt <= cnt + deltaX;
					end else begin
						cnt <= counterY;
						FLAG <= 1;
					end
					Counter <= Counter + 1;
				end
			end // End RAMP mode
			default begin
				endLine <= 0;
				endFrame <= 0;
			end
		endcase
	end
	end

endmodule
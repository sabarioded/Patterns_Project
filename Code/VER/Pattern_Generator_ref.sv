module Pattern_Generator_ref (
	input  clk,            // 16ns master clock
	input  rst_n,          // Asynchronous active low reset
	input  f_sync,         // First sync signal
	input  sync,           // Sync signal, starts the count
	input  [11:0] constVal,// Constant value input for CONST mode
	input  [1:0] X,        // deltaX for RAMP mode
	input  [1:0] Y,        // deltaY for RAMP mode
	input  [2:0] Mode,     // Mode selection

	output reg [11:0] cnt     // Output count
);

	logic [11:0] counterY;     // Holds Y value for RAMP mode
	logic [12:0] Counter;      // Main counter for different modes
	logic [4:0] endCnt;        // Tracks the number of lines processed
	logic endFrame, endLine;   // Flags to signal end of frame and end of line
	logic FLAG;                // Flag used for toggling between different states
	logic [1:0] FLAG2x2;       // Flag for 2x2 modes (WHITE2x2, BLACK2x2)
	logic [11:0] deltaX, deltaY;// deltaX and deltaY used in RAMP mode
	logic [2:0] STATE, NEXT_STATE;// FSM states

	// Work mode definitions
	parameter REGULAR = 3'b001, CONST = 3'b010, WHITE1x1 = 3'b011, BLACK1x1 = 3'b100, WHITE2x2 = 3'b101, BLACK2x2 = 3'b110, RAMP_MODE = 3'b111;

	// FSM state definitions
	parameter IDLE = 3'b000, START = 3'b001, NORMAL = 3'b010, CONSTANT = 3'b011, CB1x1 = 3'b100 ,CB2x2 = 3'b101 ,RAMP = 3'b110;

	// deltaX value parameters for RAMP mode
	parameter ZERO = 2'b00, ONE = 2'b01, FOUR = 2'b10, EIGHT = 2'b11;

	// deltaY value parameters for RAMP mode
	parameter Y0 = 2'b00, Y1 = 2'b01, Y16 = 2'b10, Y1290 = 2'b11;

	// State register update, asynchronous reset
	always_ff @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			STATE <= IDLE;  // On reset, go to IDLE state
		end else begin
			STATE <= NEXT_STATE;  // Update state to next state
		end
	end
	
	// FSM state transition logic
	always_comb begin
		case(STATE)
			IDLE: 	  NEXT_STATE <= (f_sync & sync) ? START : IDLE;  // Transition to START on f_sync and sync signals
			START: 	  NEXT_STATE <= (Mode == REGULAR) ? NORMAL : 
								   (Mode == CONST) 	  ? CONSTANT : 
								   (Mode == WHITE1x1) ? CB1x1 : 
								   (Mode == BLACK1x1) ? CB1x1 : 
								   (Mode == WHITE2x2) ? CB2x2 : 
								   (Mode == BLACK2x2) ? CB2x2 : 
								   (Mode == RAMP_MODE)? RAMP : IDLE; // Mode-based transitions
			NORMAL:   NEXT_STATE <= sync ? START : 
								   (endFrame & endLine) ? IDLE : NORMAL; // Normal mode transitions
			CONSTANT: NEXT_STATE <= sync ? START : 
								   (endFrame & endLine) ? IDLE : CONSTANT; // Constant mode transitions
			CB1x1:    NEXT_STATE <= sync ? START : 
								   (endFrame & endLine) ? IDLE : CB1x1; // Checkerboard 1x1 mode transitions
			CB2x2:    NEXT_STATE <= sync ? START : 
								   (endFrame & endLine) ? IDLE : CB2x2; // Checkerboard 2x2 mode transitions
			RAMP:     NEXT_STATE <= sync ? START : 
								   (endFrame & endLine) ? IDLE : RAMP; // Ramp mode transitions
			default:  NEXT_STATE <= IDLE; // Default case to return to IDLE
		endcase
	end
	
	// FSM logic: behavior for each state
	always_ff @(posedge clk or negedge rst_n) begin
		if (~rst_n) begin
			// Initialization on reset
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
			case (STATE)
				IDLE: begin
					// Reset all values in IDLE state
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
				end
				START: begin
					// Initialization of each mode based on the selected Mode
					case (Mode)
						REGULAR: begin
							// Regular mode start logic
							endCnt <= endCnt + 1;
							endLine <= 0;
							Counter <= 0;
							cnt <= 12'h000;
						end
						CONST: begin
							// Constant mode start logic
							endCnt <= endCnt + 1;
							endLine <= 0;
							endFrame <= 0;
							Counter <= 0;
							cnt <= 12'h000;
						end
						WHITE1x1: begin
							// White 1x1 Checkerboard mode logic
							endCnt <= endCnt + 1;
							endLine <= 0;
							Counter <= 0;
							cnt <= 12'h000;
							FLAG <= (endCnt % 2 == 0) ? 0 : 1;  // Toggle FLAG based on endCnt
						end
						BLACK1x1: begin
							// Black 1x1 Checkerboard mode logic
							endCnt <= endCnt + 1;
							endLine <= 0;
							Counter <= 0;
							cnt <= 12'h000;
							FLAG <= (endCnt % 2 == 0) ? 1 : 0;  // Inverted toggle for BLACK1x1
						end
						WHITE2x2: begin
							// White 2x2 Checkerboard mode logic
							endCnt <= endCnt + 1;
							endLine <= 0;
							Counter <= 0;
							cnt <= 12'h000;
							FLAG2x2 <= ((endCnt % 4 == 0) || endCnt % 4 == 1) ? 2'b00 : 2'b10;
						end
						BLACK2x2: begin
							// Black 2x2 Checkerboard mode logic
							endCnt <= endCnt + 1;
							endLine <= 0;
							Counter <= 0;
							cnt <= 12'h000;
							FLAG2x2 <= ((endCnt % 4 == 0) || endCnt % 4 == 1) ? 2'b10 : 2'b00;
						end
						RAMP_MODE: begin
							// Ramp mode initialization
							endCnt <= endCnt + 1;
							endLine <= 0;
							Counter <= 0;
							cnt <= 12'h000;
							// Set deltaX based on input X
							case (X)
								ZERO: deltaX <= 12'h000;
								ONE: deltaX <= 12'h001;
								FOUR: deltaX <= 12'h004;
								EIGHT: deltaX <= 12'h008;
								default: deltaX <= 12'h000;
							endcase
							// Set deltaY based on input Y
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
				end
				NORMAL: begin
					// Normal mode logic: generates count based on XOR of the counter bits
					if (Counter > 12'd4095) begin
						// End of line condition
						endLine <= 1;
						cnt <= 12'h000;
						Counter <= Counter;
						if (endCnt == 12'd24) begin
							endFrame <= 1;  // End of frame condition
						end
					end else begin
						// XOR-based counter logic
						for (int i = 0; i < 11; i++) begin
							cnt[i] <= Counter[i] ^ Counter[i + 1];
						end
						cnt[11] <= Counter[11];
						Counter <= Counter + 1;
					end
				end
				CONSTANT: begin
					// Constant mode logic: outputs constVal continuously
					if (Counter > 12'd1289) begin
						endLine <= 1;
						cnt <= 12'h000;
						Counter <= Counter;
						if (endCnt == 12'd24) begin
							endFrame <= 1;  // End of frame condition
						end
					end else begin
						cnt <= constVal;
						Counter <= Counter + 1;
					end
				end
				CB1x1: begin
					// 1x1 Checkerboard mode logic
					if (Counter > 12'd1289) begin
						endLine <= 1;
						cnt <= 12'h000;
						Counter <= Counter;
						if (endCnt == 12'd24) begin
							endFrame <= 1;  // End of frame condition
						end
					end else begin
						// Toggle cnt between black and white
						if (FLAG) begin
							cnt <= ~cnt;
						end else begin
							cnt <= 12'h000;
							FLAG <= 1;
						end
						Counter <= Counter + 1;
					end
				end
				CB2x2: begin
					// 2x2 Checkerboard mode logic
					if (Counter > 12'd1289) begin
						endLine <= 1;
						cnt <= 12'h000;
						Counter <= Counter;
						if (endCnt == 12'd24) begin
							endFrame <= 1;  // End of frame condition
						end
					end else begin
						// Toggle cnt between black and white in a 2x2 pattern
						if (FLAG2x2[1]) begin
							cnt <= 12'hfff;
						end else begin
							cnt <= 12'h000;
						end
						FLAG2x2 <= FLAG2x2 + 1;
						Counter <= Counter + 1;
					end
				end
				RAMP: begin
					// Ramp mode logic
					if (Counter > 12'd1289) begin
						endLine <= 1;
						cnt <= 12'h000;
						Counter <= Counter;
						if (endCnt == 12'd24) begin
							endFrame <= 1;  // End of frame condition
						end
						// Increment counterY by deltaY at the end of each line
						if (FLAG) begin
							counterY <= counterY + deltaY;
							FLAG <= 0;
						end
					end else begin
						// Increment cnt by deltaX for each pixel
						if (FLAG) begin
							cnt <= cnt + deltaX;
						end else begin
							cnt <= counterY;
							FLAG <= 1;
						end
						Counter <= Counter + 1;
					end
				end
				default: begin
					// Default behavior (should not be reached)
					endLine <= 0;
					endFrame <= 0;
				end
			endcase
		end
	end

endmodule

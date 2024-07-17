/*------------------------------------------------------------------------------
 * File          : Control.v
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 17, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Control(
	input clk,
	input rst_n,
	input sync,
	input f_sync,
	input [2:0]Mode,
	input [1:0]X,
	input endLine,
	input endFrame,
	output reg b12_enb,
	output reg b5_enb,
	output reg ramp_enb,
	output reg cnt_enb,
	output reg test,
	output reg newLine,
	output reg BinaryOrGray,
	output reg delta,
	output reg[1:0] Xmode,
	output reg[1:0] ValSel );

parameter IDEAL=0, Start=1, Normal=2, Constant=3, CB1x1=4 ,CB2x2=5 ,Ramp=6;
reg[2:0] STATE, NEXT_STATE;

reg [1:0] flag;

always@(*) begin
	
	case(STATE)
		IDEAL: begin
			b12_enb = 0;
			b5_enb = 0;
			ramp_enb = 0;
			cnt_enb = 0;
		end
		Start: begin
			if(Mode == 3'b001) begin //Normal mode
				b5_enb = 1;
				cnt_enb = 1;
				BinaryOrGray = 1;
			end
			if(Mode == 3'b010) begin //Constant mode
			end
			if(Mode == 3'b011) begin //CB 1x1 white
				
			end
			if(Mode == 3'b100) begin //CB 1x1 black
				
			end
			if(Mode == 3'b101) begin //CB 2x2 white
				
			end
			if(Mode == 3'b110) begin //CB 2x2 black
				
			end
			if(Mode == 3'b111) begin //Ramp
				
			end
		end
		Normal: begin
			
		end
		Constant: begin
			
		end
		CB1x1: begin
			
		end
		CB2x2: begin
			
		end
		Ramp: begin
			
		end
		default begin
			b12_enb = 0;
			b5_enb = 0;
			ramp_enb = 0;
			cnt_enb = 0;
			test = 0;
			newLine = 0;
			BinaryOrGray = 0;
			delta = 0;
			Xmode = 0;
			ValSel = 0;
		end
	endcase
	
end

always@(posedge clk, negedge rst_n) begin
	if(rst_n) begin
		STATE <= IDEAL;
	end else begin
		STATE <= NEXT_STATE;
	end
	
end

endmodule
/*------------------------------------------------------------------------------
 * File          : Counter.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : This module calculates the sum between a predefined deltaX and an input value.
 *------------------------------------------------------------------------------*/
module Counter( // =================
				//		Inputs
				// =================
	 			clk,
				rst_n, 
				cnt_enb,
				Xmode,
				LoadVal,
				
				// =================
				//		Outputs
				// =================
				out
				);
//******************************************
//			Inputs & Outputs
//******************************************
// =================
//		Inputs
// =================
input 				clk;		//16ns master clock	
input 				rst_n;		//Asynchronous active low reset
input 				cnt_enb;	//Active high enable
input [1:0] 		Xmode;		//The value of deltaX (00 for 0, 01 for 1, 10 for 4, 11 for 8)
input [11:0] 		LoadVal;	//The value to add to deltaX

// =================
//		Outputs
// =================
output [11:0]		out;		//The counter output

//----------------------------------------------------------------------------------------------------------------------------
reg [11:0]			out;		
reg [3:0] 			deltaX;

parameter ZERO=2'b00, ONE=2'b01, FOUR=2'b10, EIGHT=2'b11;
		
//initialize the value of deltaX
always@(Xmode) begin
	case(Xmode)
		ZERO:		deltaX = 4'h0;
		ONE:		deltaX = 4'h1;
		FOUR:		deltaX = 4'h4;
		EIGHT:		deltaX = 4'h8;
		default:	deltaX = 4'h0;
	endcase
end
	
//Calculate the output
always@(posedge clk or negedge rst_n) begin
	if(rst_n) begin
		out <= 12'h000;
	end else begin //rst_n = 0
		if(cnt_enb) begin	
			out <= LoadVal + {8'b0, deltaX};
		end else begin
			out <= 12'h000;
		end
	end
end

endmodule
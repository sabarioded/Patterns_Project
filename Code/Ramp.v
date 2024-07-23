/*------------------------------------------------------------------------------
 * File          : Ramp.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : This module counts with jumps of deltaY from 0 to 4095.
				   Keep the last count value until delta rises, then add deltaY to the output.
				   possible values of delta Y:
				   Y = '00' => deltaY=0
				   Y = '01' => deltaY=1
				   Y = '10' => deltaY=16
				   Y = '11' => deltaY=1290
				   Also this module has an Asynchronous active low reset and an active high enable.
 *------------------------------------------------------------------------------*/
module Ramp( // =================
			 //		Inputs
			 // =================
			 clk,
			 rst_n, 
			 ramp_enb,
			 delta,
			 Y,
				
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
input 				clk;		//60ns master clock	
input 				rst_n;		//Asynchronous active low reset
input 				ramp_enb;	//Active high enable
input 		 		delta;		//1 - Increments the output by deltaY
input [1:0] 		Y;			//The value of deltaY (00 for 0, 01 for 1, 10 for 16, 11 for 1290)

// =================
//		Outputs
// =================
output [11:0]		out;	//num_of_delta*deltaY

//----------------------------------------------------------------------------------------------------------------------------
reg [11:0]			out;
reg [10:0] 			deltaY;

parameter Y0=2'b00, Y1=2'b01, Y16=2'b10, Y1290=2'b11;

//Initialize the value of deltaY
always@(Y) begin
	case(Y)
		Y0:			deltaY = 0;
		Y1:			deltaY = 1;
		Y16:		deltaY = 16;
		Y1290:		deltaY = 1290;
		default:	deltaY = 0;
	endcase
end
	
//add deltaY every time delta rises to the output
always@(posedge clk or negedge rst_n) begin
	if(rst_n) begin
		out <= 0;
	end else begin //rst_n = 0
		if(!ramp_enb) begin
			out <= 0;
		end else begin //ramp_enb = 1
			if(delta) begin
				out <= out + {1'b0,deltaY};
			end else begin
				out <= out;
			end
		end
	end
end
endmodule
/*------------------------------------------------------------------------------
 * File          : Binary2Gray.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : This module converts a Binary number at the input into a Gray code number at the output.
 *------------------------------------------------------------------------------*/
module Binary2Gray( // =================
					//		Inputs
					// =================
					in,
				
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
input [11:0] 		in;		//12 bits binary number to convert

// =================
//		Outputs
// =================
output reg [11:0]	out;	//converted gray code

//----------------------------------------------------------------------------------------------------------------------------

integer i;
always@(in) begin
	for(i = 0; i<11; i = i+1) begin
		out[i] = in[i] ^ in[i+1];
	end
	out[11] = in[11];
end
	
endmodule
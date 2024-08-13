/*------------------------------------------------------------------------------
 * File          : Counter12Bit.v
 * Project       : Patterns
 * Author        : Oded and Margarita
 * Description   : This module is a 12 bit counter that has 2 modes of work
 				   First mode is test = 0, normal work mode that counters until 1289.
 				   Second mode is test = 1, test mode that counts until 4095
 				   When the count ends send an endLine signal at the output
 *------------------------------------------------------------------------------*/
module Counter12Bit( // =================
					 //		Inputs
					 // =================
					 clk,
					 rst_n, 
					 b12_enb,
					 test,
				
					 // =================
				 	 //		Outputs
					 // =================
					 endLine
					 );
//******************************************
//			Inputs & Outputs
//******************************************
// =================
//		Inputs
// =================
input 			clk;		//16ns master clock	
input 			rst_n;		//Asynchronous active low reset
input 			b12_enb;	//Active high enable
input 		 	test;		// '1' for test, '0' for normal mode

// =================
//		Outputs
// =================
output	 		endLine;	//When the line ends

//----------------------------------------------------------------------------------------------------------------------------
reg 			endLine;
reg [11:0] 		count;
	
//check if the count has finished.
always@(test or count) begin
	if(test) begin //test = 1 test mode
		if(count == 12'd1289) begin
			endLine = 1'b1;
		end else begin
			endLine = 1'b0; 
		end
	end else begin //test = 0 normal mode
		if(count == 12'd4095) begin
			endLine = 1'b1;
		end else begin
			endLine = 1'b0; 
		end
	end //end test = 0
end // end always

//count until the line is finished
always@(posedge clk or negedge rst_n) begin
	if(~rst_n) begin
		count <= 12'h000;
	end else begin
		if(b12_enb) begin
			count <= count + 12'h001;
		end else begin
			count <= 12'h000;
		end
	end
end
endmodule
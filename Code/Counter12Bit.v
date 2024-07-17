/*
 * This module is a 12 bit counter that has 2 modes of work
 * First mode is test = 0, normal work mode that counters until 1289.
 * Second mode is test = 1, test mode that counts until 4095
 * When the count ends send an endLine signal at the output
 */
module Counter12Bit(
	input clk,
	input rst_n, //Asynchronous active low
	input b12_enb,//Active high
	input test, // '1' for test, '0' for normal mode
	output reg endLine);

	reg[11:0] count;
	
	//check if the count has finished.
	always@(*) begin
		if(test) begin //test = 1 test mode
			if(count == 12'd1289) begin
				endLine = 1;
			end else begin
				endLine = 0; 
			end
		end else begin //test = 0 normal mode
			if(count == 12'd4095) begin
				endLine = 1;
			end else begin
				endLine = 0; 
			end
		end
	end

	//count until the line is finished
	always@(posedge clk,negedge rst_n) begin
		if(rst_n) begin
			count <= 0;
		end else begin
			if(b12_enb) begin
				count <= count +1;
			end else begin
				count <= 0;
			end
		end
	end
endmodule
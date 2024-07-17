/*
 * This module is a counter that counts to 24, with increments each time NewLine rises
 * If the count reached 24, the counter sends an EndFrame signal
 * The counter has an active low asynchronous reset and active high enable
 */
module Counter5Bit(
	input clk,
	input rst_n, //Asynchronous active low
	input b5_enb,//Active high
	input newLine,
	output reg endFrame);

	reg[4:0] count;

	//check if the fame is finished.
	always@(*) begin
		if(count == 5'd24) begin
			endFrame = 1;
		end else begin
			endFrame = 0;
		end
	end

	//count until the frame is finished every time newLine rises.
	always@(posedge clk,negedge rst_n) begin
		if(rst_n) begin
			count <= 0;
		end else begin ///rst_n = 0
			if(b5_enb) begin
				if(newLine) begin
					count <= count + 1;
				end else begin
					count <= count;
				end
			end else begin //5b_enb = 0
				count <= 0;
			end
		end
	end
endmodule
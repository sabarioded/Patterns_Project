/*------------------------------------------------------------------------------
 * File          : t_counter.v
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 17, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module t_counter(
	input clk,
	input rst_n, //Asynchronous active low
	input enb,//Active high
	input rise,
	output reg [11:0]cnt);
	
	reg[11:0] count;

	always@(posedge clk,negedge rst_n) begin
		if(rst_n) begin
			count <= 0;
		end else begin ///rst_n = 0
			if(enb) begin
				if(rise) begin
					count <= count + 1;
				end else begin
					count <= count;
				end
			end else begin //enb = 0
				count <= 0;
			end
		end
	end
assign cnt = count;

endmodule
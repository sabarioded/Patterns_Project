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
	
	//reg[11:0] count;

	always@(posedge clk or negedge rst_n) begin
		if(rst_n) begin
			cnt <= 0;
		end else begin ///rst_n = 0
			if(enb) begin
				if(rise) begin
					cnt <= cnt + 1;
				end else begin
					cnt <= cnt;
				end
			end else begin //enb = 0
				cnt <= 0;
			end
		end
	end
//assign cnt = count;

endmodule
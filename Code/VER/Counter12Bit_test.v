/*------------------------------------------------------------------------------
 * File          : Counter12Bit_test.v
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 17, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Counter12Bit_test;
reg clk;
reg rst_n;
reg b12_enb;
reg test;
reg rise;
wire endLine;
wire [11:0] cnt;

Counter12Bit dut(.clk(clk),.rst_n(rst_n),.b12_enb(b12_enb),.test(test),.endLine(endLine));
t_counter test_cnt(.clk(clk),.rst_n(rst_n),.enb(b12_enb),.rise(rise),.cnt(cnt));

initial begin
	clk = 1'b0;
end
always begin
	#8 clk = ~clk; //16 nsec clk cycle
end

initial begin
	rst_n = 1;
	rise = 1;
	@(negedge clk);
	rst_n = 0;
	b12_enb = 0;
	repeat(5)@(negedge clk);
	repeat(5000) begin
		@(negedge clk)
		rst_n = 0;
		b12_enb = 1;
		test = 0;
	end
	@(negedge clk);
	b12_enb = 0;
	repeat(2000) begin
		@(negedge clk)
		rst_n = 0;
		b12_enb = 1;
		test = 1;
	end

	
	#10000 $finish;
end


endmodule

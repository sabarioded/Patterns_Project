/* 
This is a test module for the Binary2Gray module 
*/
module Binary2Gray_test;
	reg clk;
	reg rst_n;
	reg enb;
	reg rise;
	wire [11:0] cnt;
	wire [11:0] out;
	t_counter test_cnt(.clk(clk),.rst_n(rst_n),.enb(enb),.rise(rise),.cnt(cnt));
	Binary2Gray t1(.in(cnt),.out(out));
	
	initial begin
		clk = 0;
	end
	always begin
		#8 clk = ~clk; //16 nsec
	end

	initial begin
		rst_n = 1;
		@(negedge clk);
		rst_n = 0;
		enb = 1;
		rise = 1;
		
		#5000 $finish;
	end


endmodule
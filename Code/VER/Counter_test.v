/*------------------------------------------------------------------------------
 * File          : Counter_test.v
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 17, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Counter_test;
	reg clk;
	reg rst_n;
	reg cnt_enb;
	reg [1:0]Xmode;
	reg [11:0] LoadVal;
	wire [11:0] out;
	Counter dut(.clk(clk),.rst_n(rst_n),.cnt_enb(cnt_enb),.Xmode(Xmode),.LoadVal(LoadVal),.out(out));
	
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
		cnt_enb = 1;
		Xmode = 00;
		LoadVal = 12'd50;
		@(negedge clk);
		Xmode = 01;
		LoadVal = 12'd50;
		@(negedge clk);
		Xmode = 10;
		LoadVal = 12'd50;
		@(negedge clk);
		Xmode = 11;
		LoadVal = 12'd50;
		@(negedge clk);
		Xmode = 01;
		LoadVal = 12'd4095;
		@(negedge clk);
		Xmode = 10;
		LoadVal = 12'd4095;
		@(negedge clk);
		Xmode = 11;
		LoadVal = 12'd4095;
		@(negedge clk);
		Xmode = 00;
		LoadVal = 12'd4095;
		@(negedge clk);
		Xmode = 10;
		LoadVal = 12'd4000;
		@(negedge clk);
		Xmode = 11;
		LoadVal = 12'd4000;
		
		#200 $finish;
		
	end
	
	
endmodule

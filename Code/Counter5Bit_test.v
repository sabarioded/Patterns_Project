/*------------------------------------------------------------------------------
 * File          : 5BitCounter_test.v
 * Project       : RTL
 * Author        : epmkos
 * Creation date : Jul 17, 2024
 * Description   :
 *------------------------------------------------------------------------------*/

module Counter5Bit_test;
reg clk;
reg rst_n;
reg b5_enb;
reg newLine;
wire endFrame;

Counter5Bit dut (.clk(clk),.rst_n(rst_n),.b5_enb(b5_enb),.newLine(newLine),.endFrame(endFrame));

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
	b5_enb = 0;
	newLine = 1;
	repeat(30)@(negedge clk);
	repeat(60) begin
		@(negedge clk)
		rst_n = 0;
		b5_enb = 1;
		newLine = ~newLine;
	end
	repeat(60) begin
		@(negedge clk)
		rst_n = 0;
		b5_enb = 0;
		newLine = ~newLine;
	end
	repeat(60)@(negedge clk);
	b5_enb = 1;
	newLine = 1;
	
	#1200 $finish;
	
end



endmodule
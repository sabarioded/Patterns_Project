module Ramp_test;
reg clk;
reg rst_n;
reg [1:0]Y;
reg ramp_enb;
reg delta;
wire[11:0] out;

Ramp t1(.clk(clk),
		.rst_n(rst_n),
		.Y(Y),
		.ramp_enb(ramp_enb),
		.delta(delta),
		.out(out));

		initial begin
			clk = 1'b0;
		end
		always begin
			#8 clk = ~clk; //16 nsec clk cycle
		end
		
		initial begin
			rst_n=1;
			@(negedge clk);
			rst_n=0;
			ramp_enb=1;
			@(negedge clk);
			Y = 01;
			delta =0;
			repeat(3) @(negedge clk);
			delta =1;
			@(negedge clk);
			delta = 0;
			repeat(2) @(negedge clk);
			delta =1;
			repeat(3) @(negedge clk);
			delta = 0;
			Y = 10;
			@(negedge clk);
			delta = 1;
			@(negedge clk);
			Y=11;
			@(negedge clk);
			Y= 00;
			@(negedge clk);
			Y=10;
			@(negedge clk);
			ramp_enb = 0;
			repeat(3) @(negedge clk);
			Y=01;
			@(negedge clk);
			Y=11;
			@(negedge clk);
			ramp_enb = 1;
			repeat(3) @(negedge clk);
			
			#800 $finish;
		end

endmodule

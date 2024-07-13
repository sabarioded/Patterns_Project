/* 
This is a test module for the Binary2Gray module 
*/
module Binary2Gray_test;
    reg [11:0]in;
    wire [11:0] out;
    Binary2Gray t1(.in(in),.out(out));

    initial begin
        for(int i =0;i<4096;i++) begin
            in = i;
        end
    end


endmodule
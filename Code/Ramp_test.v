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

            intial begin
                #8 clk = ~clk; //16 nsec clk cycle
            end

            inital begin
            end

endmodule
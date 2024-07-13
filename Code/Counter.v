/*
*/
module Counter(
    input clk,
    input rst_n, //Asynchronous active low
    input cnt_enb,//Active high
    input [1:0]Xmode,
    input [11:0] LoadVal,
    output [11:0] out);

    reg[11:0] deltaX;

    //initialize the value of deltaX
    always@(*) begin
        if(Xmode == 2'b00) begin
            deltaX = 0;
        end
        else if(Xmode == 2'b01) begin
                deltaX = 1;
        end 
        else if(Xmode == 2'b10) begin
                deltaX = 4;
        end
        else if(Xmode == 2'b11) begin
                deltaX = 8;
        end
    end
    
    //Calculate the output
    always@(posedge clk, negedge rst_n) begin
        if(rst_n) begin
            out <= 0;
        end else begin
            if(cnt_enb) begin
                out <= LoadVal + deltaX;
            end else begin
                out <= 0;
            end
        end
    end

endmodule
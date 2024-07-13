/*
*/
module 5BitCounter(
    input clk,
    input rst_n, //Asynchronous active low
    input 5b_enb,//Active high
    input newLine,
    output endFrame);

    reg[4:0] count;

    //check if the fame is finished.
    always@(*) begin
        if(count == 5'd23) begin
            endframe = 1;
        end else begin
            endFrame = 0;
        end
    end

    //count until the frame is finished every time newLine rises.
    always@(posedge clk,negedge rst_n) begin
        if(rst_n) begin
            count <= 0;
        end else begin
            if(5b_enb) begin
                if(newLine) begin
                    count <= count + 1;
                end else begin
                    count <= count;
                end
            end else begin
                count <= 0;
            end
        end
    end
endmodule
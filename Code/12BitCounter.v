/*
*/
module 12BitCounter(
    input clk,
    input rst_n, //Asynchronous active low
    input 12b_enb,//Active high
    input test, // '1' for test, '0' for normal mode
    output endLine);

    reg[11:0] count;
    
    //check if the count has finished.
    always@(*) begin
        if(test) begin //test = 1 test mode
            if(count == 12'd1289) begin
                endLine = 1;
            end else begin
                endLine = 0; 
            end
        end else begin //test = 0 normal mode
            if(count == 12'd4095) begin
                endLine = 1;
            end else begin
                endLine = 0; 
            end
        end
    end

    //count until the line is finished
    always@(posedge clk,negedge rst_n) begin
        if(rst_n) begin
            count <= 0;
        end else begin
            if(12b_enb) begin
                count <= count +1;
            end else begin
                count <= 0;
            end
        end
    end
endmodule
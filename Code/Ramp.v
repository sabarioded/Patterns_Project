/*
This module counts with jumps of deltaY from 0 to 4095.
Keep the last count value until delta rises, then add deltaY to the output.
possible values of delta Y:
Y = '00' => deltaY=0
Y = '01' => deltaY=1
Y = '10' => deltaY=16
Y = '11' => deltaY=1290
Also this module has an Asynchronous active low reset and an active high enable.
*/
module Ramp(
    input clk,
    input rst_n, //Asynchronous active low
    input [1:0] Y,
    input ramp_enb, //Active high
    input delta,
    output [11:0]out );

    reg[11:0] deltaY;

    //Initialize the value of deltaY
    always@(*) begin
        if(Y == 2'b00) begin
            deltaY = 0;
        end
        else if(Y == 2'b01) begin
                deltaY = 1;
        end 
        else if(Y == 2'b10) begin
                deltaY = 16;
        end
        else if(Y == 2'b11) begin
                deltaY = 1290;
        end
    end
    
    //add deltaY every time delta rises to the output
    always@(posedge clk,negedge rst) begin
        if(rst_n) begin
            out <= 0;
        end else begin
            if(!ramp_enb) begin
                out <= 0;
            end else begin
                if(delta) begin
                    out <= out + deltaY;
                end else begin
                    out <= out;
                end
            end
        end
    end
endmodule
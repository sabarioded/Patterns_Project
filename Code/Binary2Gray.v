/*
This module converts a Binary number at the input into a Gray code number at the output.
*/
module Binary2Gray (
    input [11:0] in,
    output [11:0] out );
    
    always@(*) begin
        for(int i =0; i<11; i++) begin
            out[i] = in[i] ^ in[i+1];
        end
        out[11] = in[11];
    end
    
endmodule
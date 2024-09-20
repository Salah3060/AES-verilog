module bcd12_to_7seg(
    input [3:0] bcd_input,
    output reg [6:0] seven_segment_output
);

    always @* begin
        case(bcd_input)
            4'h0: seven_segment_output = 7'b1000000; // 0
            4'h1: seven_segment_output = 7'b1111001; // 1
            4'h2: seven_segment_output = 7'b0100100; // 2
            4'h3: seven_segment_output = 7'b0110000; // 3
            4'h4: seven_segment_output = 7'b0011001; // 4
            4'h5: seven_segment_output = 7'b0010010; // 5
            4'h6: seven_segment_output = 7'b0000010; // 6
            4'h7: seven_segment_output = 7'b1111000; // 7
            4'h8: seven_segment_output = 7'b0000000; // 8
            4'h9: seven_segment_output = 7'b0010000; // 9
            4'ha: seven_segment_output = 7'b0001000; // 9
            4'hb: seven_segment_output = 7'b0000011; // 9
            4'hc: seven_segment_output = 7'b1000110; // 9
            4'hd: seven_segment_output = 7'b0100001; // 9
            4'he: seven_segment_output = 7'b0000110; // 9
            4'hf: seven_segment_output = 7'b0001110; // 9
            
            default: seven_segment_output = 7'b1111111; // Blank
        endcase
 end

endmodule
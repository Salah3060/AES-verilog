module sub_word (
    input [0:31] data,
    output wire [0:31] out
);

genvar i;
generate 
    for(i=0; i < 32; i=i+8) begin : convert
        wire [0:7] res;
        s_box box (data[i +: 8], res);
        assign out[i +: 8] = res;
    end
endgenerate

endmodule
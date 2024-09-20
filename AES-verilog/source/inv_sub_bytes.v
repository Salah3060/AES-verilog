module inv_sub_bytes (
    input [0:127] data,
    output [0:127] out
);

genvar i;
generate 
    for(i=0; i < 128; i=i+8) begin : convert
        inv_s_box box (data[i +: 8], out[i +: 8]);
    end
endgenerate

endmodule
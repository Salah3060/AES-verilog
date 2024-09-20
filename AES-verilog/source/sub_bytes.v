module sub_bytes
(input [127:0] state, output wire [127:0]result);

genvar i;
generate
    for (i = 0; i < 128; i = i + 8) begin : gen_block	
	  s_box s(state[i + 7:i], result[i+7:i]);
	end
endgenerate
endmodule
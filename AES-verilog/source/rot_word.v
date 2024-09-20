module rot_word (
    input [0:31] word,
    output [0:31] out
);

assign out[0 : 7 ] = word[8 : 15];
assign out[8 : 15] = word[16: 23];
assign out[16: 23] = word[24: 31];
assign out[24: 31] = word[0 : 7 ];

endmodule
module inv_mix_column (
    input [127:0] state,
    output wire [127:0] result
);
    function [7:0] xtime;
        input [7:0] mul;
        reg [7:0] data;
        begin
            data = mul * 8'h02;
            if (mul[7] == 1'b0) begin
                xtime = data;
            end
            else begin
                xtime = data ^ 8'h1b;
            end
        end
    endfunction

    function [7:0] product;
        input [7:0] y;
        input [7:0] x;
        reg [7:0] res;
        begin
            case (y)
                8'h0d: res = xtime(xtime(xtime(x))) ^ xtime(xtime(x)) ^ x;
                8'h0e: res = xtime(xtime(xtime(x))) ^ xtime(xtime(x)) ^ xtime(x);
                8'h0b: res = xtime(xtime(xtime(x))) ^ xtime(x) ^ x;
                8'h09: res = xtime(xtime(xtime(x))) ^ x;
            endcase
            product = res;
        end
    endfunction



    genvar c;
    genvar r;
    generate
    for (c = 0; c < 4; c = c + 1) begin : gen_block
        assign result[c * 32 + 7 : c * 32] = product(8'h0e,state[c*32+7:c*32]) ^ product(8'h09,state[c*32+15:c*32+8]) ^ product(8'h0d,state[c*32+23:c*32+16]) ^ product(8'h0b,state[c*32+31:c*32+24]);
        assign result[c * 32 + 15 : c * 32 + 8] = product(8'h0b,state[c*32+7:c*32]) ^ product(8'h0e,state[c*32+15:c*32+8]) ^ product(8'h09,state[c*32+23:c*32+16]) ^ product(8'h0d,state[c*32+31:c*32+24]);
        assign result[c * 32 + 23 : c * 32 + 16] = product(8'h0d,state[c*32+7:c*32]) ^ product(8'h0b,state[c*32+15:c*32+8]) ^ product(8'h0e,state[c*32+23:c*32+16]) ^ product(8'h09,state[c*32+31:c*32+24]);
        assign result[c * 32 + 31 : c * 32 + 24] = product(8'h09,state[c*32+7:c*32]) ^ product(8'h0d,state[c*32+15:c*32+8]) ^ product(8'h0b,state[c*32+23:c*32+16]) ^ product(8'h0e,state[c*32+31:c*32+24]);
        end
        endgenerate
endmodule

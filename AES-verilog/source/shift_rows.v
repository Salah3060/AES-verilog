module shift_rows (
    input [0:127] data,
    output wire [0:127] result
);
    reg [0:127] state;
    reg [0:7] temp;
    integer r;
    integer n;

    initial begin
        r = 0;
        n = 0;
    end

    always @(data) begin
        state = data;
        // [a b c d]
        for(r = 0; r < 4; r=r+1) 
            for(n = 0; n < r; n=n+1) begin
                temp = state[(0*32) + r*8 +: 8];
                state[(0*32) + r*8 +: 8]      = state[(1*32) + r*8 +: 8];      // a = b
                state[(1*32) + r*8 +: 8]      = state[(2*32) + r*8 +: 8];     // b = c
                state[(2*32) + r*8 +: 8]      = state[(3*32) + r*8 +: 8];     // c = d
                state[(3*32) + r*8 +: 8]      = temp;          // d = a
            end
    end
    assign result = state;

endmodule
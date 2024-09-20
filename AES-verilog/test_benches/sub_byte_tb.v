module sub_byte_tb();
    reg [127:0] state;
    wire [127:0] res;

    sub_bytes sb(
        .state(state),
        .result(res)
    );
    initial begin
        state = 128'h63cab7040953d051cd60e0e7ba70e18c;
        #10; // Wait for 10 time units (adjust as needed)
        
        $display("Result: %h", res);
    end
endmodule

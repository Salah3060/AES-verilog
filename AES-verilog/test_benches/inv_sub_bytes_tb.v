`define assert(signal, value) \
        if (signal !== value) \
            $display("Test Failed in %m: signal != value"); \
        else \
            $display("Test OK in %m"); \

module inv_sub_bytes_tb ();
    reg [0:127] data;
    wire [0:127] result;

    inv_sub_bytes sub(data, result);

    initial begin
        data =          128'h5411f4b56bd9700e96a0902fa1bb9aa1; #100
        `assert(result, 128'hfde3bad205e5d0d73547964ef1fe37f1)

        data =          128'h3e175076b61c04678dfc2295f6a8bfc0; #100
        `assert(result, 128'hd1876c0f79c4300ab45594add66ff41f)

        data =          128'hb415f8016858552e4bb6124c5f998a4c; #100
        `assert(result, 128'hc62fe109f75eedc3cc79395d84f9cf5d)
    end
endmodule
`define assert(signal, value) \
        if (signal !== value) \
            $display("Test Failed in %m: signal != value"); \
        else \
            $display("Test OK in %m"); \

module shift_rows_tb ();
    reg [0:127] data;
    wire [0:127] result;

    shift_rows shift(data, result);

    initial begin
        data =          128'h63cab7040953d051cd60e0e7ba70e18c; #100
        `assert(result, 128'h6353e08c0960e104cd70b751bacad0e7)

        data =          128'h3b59cb73fcd90ee05774222dc067fb68; #100
        `assert(result, 128'h3bd92268fc74fb735767cbe0c0590e2d)

        data =          128'h36400926f9336d2d9fb59d23c42c3950; #100
        `assert(result, 128'h36339d50f9b539269f2c092dc4406d23)
    end
endmodule
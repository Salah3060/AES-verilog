
`define assert(signal, value) \
        if (signal !== value) \
            $display("Test Failed in %m: signal != value  s:%h",signal,"     v:%h",value); \
        else \
            $display("Test OK in %m  s:%h",signal,"     v:%h",value); \


 module mytask_tb ();
    reg [0:127] data;
    wire [0:127] result;

    mixed_column mk(data, result);

    initial begin
        data =          128'h1f2bc3771f2bc3771f2bc3771f2bc377; #100
        `assert(result, 128'h046681e5e0cb199a48f8d37a2806264c)
     //    $display("At time , data is ",  result);

        data =          128'h6353e08c0960e104cd70b751bacad0e7; #100
        `assert(result, 128'h5f72641557f5bc92f7be3b291db9f91a)
// $display("At time , data is ",  result);
        data =          128'h3bd92268fc74fb735767cbe0c0590e2d; #100
        `assert(result, 128'h4c9c1e66f771f0762c3f868e534df256)
    end
endmodule
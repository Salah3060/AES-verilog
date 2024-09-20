module  AES_tb ();
integer i = 0;

reg [1:0] mode = 0;
reg CLK = 1;
reg reset = 0;
wire assert;
wire [0:6] Display1; // Most Left
wire [0:6] Display2;
wire [0:6] Display3; // Most Right
wire [0:6] Display4; // Most Left
wire [0:6] Display5;
wire [0:6] Display6; // Most Right

AES aes( CLK, mode, reset, assert, Display1, Display2, Display3 , Display4, Display5, Display6 );

    initial begin
        for(i=0; i < 56; i=i+1) begin
            CLK = ~CLK;
            #100;
        end

        CLK = 0; reset = 1; mode = 1; #100
        CLK = 1; reset = 1; #100
        
        CLK = 0; reset = 0;  #100
        CLK = 1; reset = 0; #100

        for(i=0; i < 36 * 2; i=i+1) begin
          CLK = ~CLK;
          #100;
        end

        CLK = 0; reset = 1; mode = 2; #100
        CLK = 1; reset = 1; #100
        
        CLK = 0; reset = 0;  #100
        CLK = 1; reset = 0; #100

        for(i=0; i < 40 * 2; i=i+1) begin
          CLK = ~CLK;
          #100;
        end
    end
    
endmodule
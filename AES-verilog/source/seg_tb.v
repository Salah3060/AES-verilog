module seg_tb();
reg [3:0]in;
reg [6:0]out;

bcdto7seg bcd(in, out);

initial begin
in = 4'd4; #100
in = 4'd5; #100
in = 4'd6; #100
in = 4'd7; #100;
end
endmodule
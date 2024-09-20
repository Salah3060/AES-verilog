module shift_add_3_tb();
wire [11:0]result;
reg [7:0]state;
shift_add_3 s(state, result);
initial begin
state = 8'b00001111; #100
state = 8'b11110111; #100
state = 8'b01000111; #100;
end
endmodule
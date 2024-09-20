module s_box_tb();
reg [7:0]data;
wire [7:0]result;

s_box s(data, result);
initial begin
data = 8'h52; #100
data = 8'hf1; #100
data = 8'he5; #100;
end
endmodule
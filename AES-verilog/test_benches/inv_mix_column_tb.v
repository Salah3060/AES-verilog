module inv_mix_column_tb();
reg [127:0]data;
wire [127:0]out;
inv_mix_column imc(data, out);
initial begin
	data = 128'hfde3bad205e5d0d73547964ef1fe37f1; #10

	data = 128'hfde3bad205e5d0d73547964ef1fe37f1; #10

	data = 128'hd1876c0f79c4300ab45594add66ff41f; #10
       
	data = 128'hc62fe109f75eedc3cc79395d84f9cf5d; #10;

end
endmodule
/*module shift_add_3(input [7:0] state, output reg [11:0] result);

//assign result[15:14] = 2'b00;
wire [3:0]temp1 = state[7:5] > 5 ? state[3:0] + 3
:state[7:5]
;
assign temp1[3] = 0;

wire [3:0]temp2 = {temp1[2:0],state[4]} > 5 ? {temp1[3:0],state[4]} + 3
:state[7:5]
;
endmodule*/



module add3(input [3:0]in,output wire [3:0]out);

  assign out =  (in >= 4'b0101) ? (in + 4'b0011) : in;

endmodule



module shift_add_3(input [7:0] state, output [11:0] result);


wire [3:0]temp0;
wire [3:0]temp1;
wire [3:0]temp2;
wire [3:0]temp3;
wire [3:0]temp4;
wire [3:0]temp5;
wire [3:0]temp6;
  add3 A0({1'b0,state[7:5]}, temp0);
  add3 A1({temp0[2:0],state[4]}, temp1);
  add3 A2({temp1[2:0],state[3]}, temp2);
  add3 A4({1'b0,temp0[3], temp1[3], temp2[3]}, temp3);
  add3 A5({temp2[2:0], state[2]}, temp4);
  add3 A6({temp3[2:0], temp4[3]}, temp5);
  add3 A7({temp4[2:0],state[1]}, temp6);
  assign result = {2'b00, temp3[3], temp5, temp6, state[0]};



endmodule
 module invShiftRow(input[0:127] Data , output [0:127] Result);

reg[0:7] temp;
reg [0:127] state;
integer r=0;
integer i=0;

  //  [ b c d a ] --> [ a b c d ]
 always@(Data) begin
  state=Data;
    for(r=0;r<4;r=r+1) begin 
      for(i=0 ; i<r;i=i+1) begin
         temp = state [(3*32) + r*8 +: 8 ];
      state[(3*32) + r*8 +: 8] =     state[(2*32) + r*8 +: 8]   ; //  [b c d d ]
      state[(2*32) + r*8 +: 8] =     state[(1*32) + r*8 +: 8]   ; //  [b c c d ] 
      state[(1*32) + r*8 +: 8] =     state[(0*32) + r*8 +: 8]   ; //  [b b c d ]
      state[(0*32) + r*8 +: 8] = temp ;                          //  [a b c d ]
      end 
    end 
 end 
assign Result = state ;

 endmodule
module inv_cipher(input  [0 : 127] data , input wire [0 : 127] Outkey ,  input Clk , input Reset , input [0:1] mode, input wire enable ,  output wire [0 : 127]  Result , output wire endInvCipher   ) ;


reg [0:127] state = 128'h_00_00_00  ; 
 /// Key Expansion Module
 
wire Zirno;
reg endFlag;

initial begin 
endFlag =0;
end

integer round  = 1 ;

//key_expansion KEY(Clk , load , mode , Word , Outkey , Zirno );

/// Zero Round
wire [0:127] state0;
assign state0 = data ^ Outkey;


//1-9 rounds


wire [0:127] stateAfterinv_SubBytes;
wire [0:127] stateAfterinv_ShiftRowResult;
wire [0:127] stateAfterinv_MixedColoum;
wire [0:127] state1_9;
wire [0:127] state2_12;
wire [0:127] state2_14;

wire [0:127] Temp;

invShiftRow inv_Shift ( state  , stateAfterinv_ShiftRowResult) ;
inv_sub_bytes inv_SUB ( stateAfterinv_ShiftRowResult, stateAfterinv_SubBytes);
assign Temp = stateAfterinv_SubBytes ^ Outkey;
inv_mix_column inv_Mix (  Temp ,stateAfterinv_MixedColoum );
assign  state1_9 = stateAfterinv_MixedColoum  ;
assign  state2_12 = stateAfterinv_MixedColoum ;
assign  state2_14 = stateAfterinv_MixedColoum ;





// //// Last State 

wire [0:127] lastState;
wire [0:127] stateAfterLinv_SubBytes;
wire [0:127] stateAfterShiftLinv_RowResult;
			
invShiftRow inv_SHift ( state ,stateAfterShiftLinv_RowResult );
inv_sub_bytes inv_SuB ( stateAfterShiftLinv_RowResult  ,stateAfterLinv_SubBytes );

assign  lastState = stateAfterLinv_SubBytes ^ Outkey;


always@(posedge Clk ) begin
  if(Reset) begin 
    round=1;
    endFlag<=0;
    state <= 0;
  end else if( enable && endFlag < 1 ) begin 
    if(round==1)
       begin
         state<=state0;
          round=round+1;
       end
   else if(mode==0)
      begin 
        if(round < 11)
          begin 
             state<=state1_9 ;
             round=round+1;
          end 
       else 
         begin
          state<=lastState;
            endFlag<=1;
          end
      end 
  else if(mode==1)
    begin 
       if(round<13)
        begin 
         state<=state2_12 ;
          round=round+1;
         end 
      else begin
         state<=lastState; 
          endFlag<=1;
      end
    end 
  else 
   begin
      if(round<15)
        begin 
           state<=state2_14 ;
           round=round+1;
        end 
      else begin
          state<=lastState; 
                endFlag<=1;
         end 
     end 
   end 
end 
 assign endInvCipher = endFlag;
 assign Result = state;
endmodule

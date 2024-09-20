module cipher(input  [0 : 127] data , input wire [0 : 127] Outkey ,  input Clk , input Reset , input Enable  ,  input [0:1] mode  , output wire [0 : 127]  Result , output wire endCipher ) ;


reg [0:127] state = 128'h_00_00_00  ; 
reg endFlag ;
reg stop ;

initial begin
endFlag =0;
stop=0;
end
 /// Key Expansion Module
 
wire Zirno;
//wire [0:127] Outkey ;
reg [4:0] round  = 1 ;

//key_expansion KEY(Clk , load , mode , Word , Outkey , Zirno );

/// Zero Round
wire [0:127] state0;
assign state0 = data ^ Outkey;


//1-9 rounds


wire [0:127] stateAfterSubBytes;
wire [0:127] stateAfterShiftRowResult;
wire [0:127] stateAfterMixedColoum;
wire [0:127] state1_9;
wire [0:127] state2_12;
wire [0:127] state2_14;




sub_bytes SUB ( state , stateAfterSubBytes);
shift_rows SHItf ( stateAfterSubBytes  , stateAfterShiftRowResult) ;
mixed_column Mix ( stateAfterShiftRowResult ,stateAfterMixedColoum );
assign  state1_9 = stateAfterMixedColoum  ^ Outkey;
assign  state2_12 = stateAfterMixedColoum  ^ Outkey;
assign  state2_14 = stateAfterMixedColoum  ^ Outkey;





// //// Last State 

wire [0:127] lastState;
wire [0:127] stateAfterLSubBytes;
wire [0:127] stateAfterShiftLRowResult;

sub_bytes SuB ( state  ,stateAfterLSubBytes );
shift_rows SHift ( stateAfterLSubBytes ,stateAfterShiftLRowResult );
assign  lastState = stateAfterShiftLRowResult ^ Outkey;

always@(posedge Clk) begin

  if(Reset == 1) begin 
  endFlag<=0;   
  round=1;
  state<=data;
  stop=0;
  end else
  if(Enable)begin 
  if(stop<1) begin
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
        if(round==10)
        begin
           endFlag<=1;
        end 

          round=round+1;
         end 
       else if(round==11)
       begin
       state<=lastState;
       endFlag<=1;
        stop<=1;
         end
   end 
 else if(mode==1)
  begin 
     if(round<13)
       begin 
       state<=state2_12 ;
       if(round==12) begin
         endFlag<=1;
       end

          round=round+1;
      end 
      else if(round==13) begin
         state<=lastState; 
       endFlag<=1;
       stop<=1;
      end
  end 
 else 
  begin
     if(round<15)
       begin 
       state<=state2_14 ;
       if(round==14)
           endFlag<=1;

          round=round+1;
      end 
      else if(round==15) begin
         state<=lastState; 
       endFlag<=1;
        stop<=1;
      end
  end 
  end 
end 
end 
 assign Result = state;
 assign endCipher = endFlag;
endmodule

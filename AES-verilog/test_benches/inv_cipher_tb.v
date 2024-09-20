module inv_cipher_tb();
reg[0:255] Key ;
wire [0:127] outKey;
wire[0:127] OUT;
reg clk ;
reg [0:127] Data ;
reg Load;
reg Rev ;
reg [0:1]mode;
wire [4:0] ROund;
wire EndFlag;
reg E;
wire EIC ;
key_expansion K (clk , Load , Rev , mode ,Key , outKey , ROund  );
inv_cipher In ( Data , outKey , clk , Load ,mode ,E  ,OUT , EIC);

integer i ;

initial begin
  mode=2;
  Rev=0;
  E=0;
//  Data= 128'h69c4e0d86a7b0430d8cdb78070b4c55a;
//  Key = 128'h000102030405060708090a0b0c0d0e0f;
  //  Data = 128'hdda97ca4864cdfe06eaf70a0ec0d7191;
  //  Key = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
  Data =128'h8ea2b7ca516745bfeafc49904b496089;
  Key=256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
    

$monitor("Round --> %h Key --> %h" , ROund, outKey);

  clk = 0; Load = 1; #20;
  clk = 1; Load = 1;  #20;

    for(i=0;i < 15; i=i+1) begin
    clk = 0; Load = 0; #20;
    clk = 1; Load = 0; #20;
  end 

 clk =0; Rev = 1; E =1; #20;
   clk =1; #20;

  $monitor("Inv -->  %h" , OUT);
 
  for(i=0;i < 15; i=i+1) begin
    clk = 0; Load = 0; #20;
    clk = 1; Load = 0;  #20;
  end 

   



end



endmodule

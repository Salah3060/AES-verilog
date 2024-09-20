module cipher_tb();

reg[0:255] Key ;
wire [0:127] outKey;
wire[0:127] OUT;
reg clk ;
reg [0:127] Data ;
reg Load;
reg Rev ;
reg r;
reg [0:1]mode;
wire [4:0] ROund;
wire EndFlag;
reg E;
key_expansion K (clk , Load , Rev , mode ,Key , outKey , ROund  );
cipher CIP(Data ,outKey , clk , r , E  ,  mode, OUT , EndFlag);

integer i ;

initial begin
  Rev =0;
  r=0;
  E =0;
  // Case 128
  //Data= 128'h3243f6a8885a308d313198a2e0370734;
  //Key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
  //mode=0;

//Case 192 
  //  Data = 128'h00112233445566778899aabbccddeeff;
  //  Key =  192'h000102030405060708090a0b0c0d0e0f1011121314151617;
  //  mode =1;

  //Case 256 
  Data = 128'h00112233445566778899aabbccddeeff;
  Key =  256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
  mode =2;

$monitor("Output===<>      %h" , OUT);
    
   clk =0;  Load=1; #20;
   clk =1; Load=1; #20;

  clk = 0; Load = 0; #20;
            clk = 1; Load = 0; #20; 
             clk = 0; Load = 0; #20;
            clk = 1; Load = 0; #20;
              clk = 0; Load = 0; #20;
            clk = 1; Load = 0; #20; 
             clk = 0; Load = 0; #20;
            clk = 1; Load = 0; #20;
              clk = 0; Load = 0; #20;
            clk = 1; Load = 0; #20;

            E=1;

  for(i=0;i < 15; i=i+1)
    begin
            clk = 0; Load = 0; #20;
            clk = 1; Load = 0; #20;
    end 

  
    // clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    // clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    // clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    // clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    // clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    // clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    //   clk =0;  Load=0; #20;
    // clk =1; Load=0; #20; 
    //  clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    //   clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    //     clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;
    //   clk =0;  Load=0; #20;
    // clk =1; Load=0; #20;


    


end



endmodule

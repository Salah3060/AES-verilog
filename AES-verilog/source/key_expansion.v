//
// 0 -> 128
// 1 -> 192
// 2 -> 256

module key_expansion (
    input CLK,
    input LOAD,
    input REVERS,
    input [1:0] mode,
    input  [0:255] in_key,
    output [0:127] key,
    output [4:0] current_round
);

wire [0:7] round_constant [0: 13];
assign round_constant[0] = 8'h01;
assign round_constant[1] = 8'h02;
assign round_constant[2] = 8'h04;
assign round_constant[3] = 8'h08;
assign round_constant[4] = 8'h10;
assign round_constant[5] = 8'h20;
assign round_constant[6] = 8'h40;
assign round_constant[7] = 8'h80;
assign round_constant[8] = 8'h1B;
assign round_constant[9] = 8'h36;
assign round_constant[10] = 8'h6C;
assign round_constant[11] = 8'hD8;
assign round_constant[12] = 8'hAB;
assign round_constant[13] = 8'h4D;

wire [3:0] max_round = (mode == 0 ? 10 : mode == 1 ?  12 : 14 );

integer wordIndex;
integer currentWord;
reg [0:32 * 60 - 1] all_keys;

reg [0:255] state;
integer round_number = 0;

reg [0:31] temp;
wire [0:255] next_key;

wire [0:31] rot_word_result;
rot_word rot(temp, rot_word_result);

wire [0:31] sub_result;
sub_word sub(rot_word_result, sub_result);

wire [0:31] g_word;
assign g_word = sub_result ^ ({round_constant[round_number], 24'h_00_00_00});

wire [0:31] mid_sub_result;
sub_word mid_sub(next_key[32 * 3  +: 32], mid_sub_result);

wire [0:31] seconed_gword = (mode == 2? mid_sub_result : next_key[32*3 +: 32]);



assign next_key[0  +: 32] = state[0 +: 32] ^  g_word  ;
genvar i;
generate
    for(i=32;i<255;i=i+32) begin : xor_results
        if(i == 32 * 4) // 256 bit extra step
            assign next_key[i +: 32] = state[i +: 32] ^ seconed_gword;
        else
            assign next_key[i +: 32] = state[i +: 32] ^ next_key[(i - 32) +: 32];
    end
endgenerate

always @(posedge CLK) begin
    if(REVERS) begin
        if(round_number > 0) begin 
            round_number <= round_number - 1;
            currentWord  <= currentWord  - 4;
        end
    end else if(LOAD) begin
        
        if(mode == 0)
            state[0:127] <= in_key;
        else if(mode == 1)
            state[0:191] <= in_key;
        else 
            state[0:255] <= in_key;
        
        if(mode == 0)
            all_keys[0:127] <= in_key;
        else if(mode == 1)
            all_keys[0:191] <= in_key;
        else 
            all_keys[0:255] <= in_key;
        wordIndex <= (mode == 0? 4 : mode ==1? 6: 8);
        currentWord <= 0;
        round_number <= 0;
        temp <= in_key[255 -: 32];
    end else begin
        if(currentWord < (max_round * 4)) begin
            currentWord = currentWord +  4;
        end

        if(round_number < max_round) begin
            
            state <= next_key;
            if(mode == 0)
                temp <= next_key[32*3 +:32];
            else if(mode == 1)
                temp <= next_key[32*5 +:32];
            else 
                temp <= next_key[32*7 +:32];

            if(mode == 0)
                all_keys[wordIndex*32 +:128] <= next_key[0+:128];
            else if(mode == 1)
                all_keys[wordIndex*32 +:192] <= next_key[0+:192];
            else 
                all_keys[wordIndex*32 +:256] <= next_key[0+:256];
            wordIndex = wordIndex + (mode == 0? 4 : mode ==1? 6: 8);

            round_number <= round_number + 1;
        end
    end
end


assign key = all_keys[currentWord*32 +:128];
assign current_round = round_number;
    
endmodule
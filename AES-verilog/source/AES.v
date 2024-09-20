/*
0 -> Input
1 -> encryption
2 -> decryption
3 -> Load
*/
module AES (
    input CLK,
    input [1:0] mode,
    input reset,
    output assert,
    output [6:0] Display1, // Most Left
    output [6:0] Display2,
    output [6:0] Display3, // Most Right
    output [6:0] Display4, // Most Left
    output [6:0] Display5,
    output [6:0] Display6 // Most Right
);
localparam [2:0] LOADING = 0;
localparam [2:0] ENCRYPTION = 1;
localparam [2:0] DECRYPTION = 2;
localparam [2:0] TRANS_STATE = 4;
localparam [2:0] IDLE = 3;

reg [2:0] state;

localparam [0:127] data =    128'h00112233445566778899aabbccddeeff;
localparam [0:127] Key128 =  128'h000102030405060708090a0b0c0d0e0f;
localparam [0:191] Key192 = 192'h000102030405060708090a0b0c0d0e0f1011121314151617;
localparam [0:255] Key256 = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;

wire [0:255] corresponding_key = (mode == 0? Key128 : mode == 1? Key192 : Key256);


reg key_load = 0;
reg key_revers = 0;

wire [0:127] out_key ;
wire [4:0] current_round;
key_expansion expansion(CLK, key_load, key_revers, mode, corresponding_key, out_key, current_round);

wire [0:127] cipher_state;
wire is_cipher_done;
reg cipher_enable = 0;
reg cipher_reset = 1;
cipher cipher(data, out_key, CLK,cipher_reset, cipher_enable, mode, cipher_state, is_cipher_done);


wire [0:127] inv_cipher_state;
wire is_inv_cipher_done;
reg inv_cipher_enable = 0;
reg inv_cipher_reset = 1;
inv_cipher inv_cipher(cipher_state, out_key, CLK, inv_cipher_reset, mode, inv_cipher_enable, inv_cipher_state, is_inv_cipher_done);

initial begin
  state = LOADING;

  cipher_enable = 0;
  cipher_reset = 1;

  inv_cipher_reset = 0;
  inv_cipher_enable = 1;

  key_load = 1;
  key_revers = 0;
end

reg hey = 0;
always @(posedge CLK) begin
  // hey = (hey == 0 ? 1 : 0);
  if(reset == 1) begin
    cipher_enable = 0;
    cipher_reset = 1;

    inv_cipher_enable = 0;
    inv_cipher_reset = 1;

    key_load = 1;
    key_revers = 0;

    state = LOADING;
  end else
    case(state)
    LOADING: begin
      cipher_enable = 1;
      cipher_reset = 0;

      inv_cipher_enable = 0;
      inv_cipher_reset = 1;

      key_load = 0;
      key_revers = 0;

      state <= ENCRYPTION;
    end
    ENCRYPTION: begin

      if(is_cipher_done) begin
          state <= TRANS_STATE;

          inv_cipher_reset <= 0;
          inv_cipher_enable <= 1;

          key_revers <= 1;
      end
    end
    TRANS_STATE: begin
      state <= DECRYPTION;
    end
    DECRYPTION: begin
         if(is_inv_cipher_done) begin
            state <= IDLE;
         end
    end
    IDLE: begin
        ////////
    end
    default: begin
        
    end
    endcase
end

wire [0:127] corresponding_state = ((state == ENCRYPTION || state == TRANS_STATE) ? cipher_state : inv_cipher_state);
//TODO: Wire to output

assign assert = state == IDLE && inv_cipher_state == data;
// assign assert = hey;

wire [11:0] shited_data;
shift_add_3 shift(corresponding_state[127 -: 8],shited_data);

bcd12_to_7seg seg1(shited_data[3:0], Display1);
bcd12_to_7seg seg2(shited_data[7:4], Display2);
bcd12_to_7seg seg3(shited_data[11:8], Display3);

wire [3:0] state_code = (state == ENCRYPTION || state == TRANS_STATE) ? 4'he :
                        (state == DECRYPTION || state == IDLE) ? 4'hd : 0;

wire[6:0] state_code_display_res;
bcd12_to_7seg state_code_display(state_code, state_code_display_res);
assign Display4[6:0] = (state == LOADING? 7'b1000111 :  state_code_display_res);

bcd12_to_7seg current_round_disp_coder(current_round, Display6);
assign Display5[6:0] = 7'b1111111;



endmodule

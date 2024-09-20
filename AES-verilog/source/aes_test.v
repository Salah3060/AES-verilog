module aes_test ();
    
wire [0:127] out_key ;
wire [4:0] current_round;
key_expansion expansion(CLK, key_load, key_revers, mode, corresponding_key, out_key, current_round);

wire [0:127] inv_cipher_state;
wire is_inv_cipher_done;
reg inv_cipher_enable = 0;
reg inv_cipher_reset = 1;
inv_cipher inv_cipher(cipher_state, out_key, CLK, inv_cipher_reset, mode, inv_cipher_enable, inv_cipher_state, is_inv_cipher_done);


endmodule
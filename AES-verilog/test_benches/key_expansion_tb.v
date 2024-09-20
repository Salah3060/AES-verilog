`define assert(signal, value) \
        if (signal !== value) \
            $display("Test Failed in %m: signal != value"); \
        else \
            $display("Test OK in %m"); \

`define print_key(round, signal) \
        $display("Round: %d, Key => w%d: %h, w%d: %h, w%d: %h, w%d: %h",round, (round * 4) + 0, signal[0 +: 32],(round * 4) + 1, signal[1*32 +: 32],(round * 4) + 2, signal[2*32 +: 32], (round * 4) + 3, signal[3*32 +: 32]);

module key_expansion_tb ();

    reg CLK;
    reg LOAD;
    reg REVERS;
    reg [1:0] mode;
    reg  [0:255] key;
    wire [0:127] out_key;
    wire [4:0] current_round;

    key_expansion expansion(CLK,LOAD,REVERS,mode, key,out_key, current_round);

    integer i;

    initial begin
        key = 128'h2b_7e_15_16_28_ae_d2_a6_ab_f7_15_88_09_cf_4f_3c;
        CLK = 0; LOAD = 1; mode = 0; REVERS = 0; #100;
        CLK = 1; LOAD = 1; #100;
        `print_key(current_round, out_key)

        for(i=0;i < 12; i=i+1) begin
            CLK = 0; LOAD = 0; #100;
            CLK = 1; LOAD = 0; #100;
            `print_key(current_round, out_key)
        end

        CLK = 0; LOAD = 0; REVERS = 1; #100;
      

        for(i=0;i < 12; i=i+1) begin
            CLK = 0; LOAD = 0; #100;
            CLK = 1; LOAD = 0; #100;
            `print_key(current_round, out_key)
        end

        // key = 192'h8e73b0f7_da0e6452_c810f32b_809079e5_62f8ead2_522c6b7b;
        // CLK = 0; LOAD = 1; mode = 1; #100; 
        // CLK = 1; LOAD = 1; #100;
        // `print_key(current_round, out_key)

        // for(i=0;i < 15; i=i+1) begin
        //     CLK = 0; LOAD = 0; #100;
        //     CLK = 1; LOAD = 0; #100;
        //     `print_key(current_round, out_key)
        // end


        // key = 256'h60_3d_eb_10_15_ca_71_be_2b_73_ae_f0_85_7d_77_81_1f_35_2c_07_3b_61_08_d7_2d_98_10_a3_09_14_df_f4;
        // CLK = 0; LOAD = 1; mode = 2; #100; 
        // CLK = 1; LOAD = 1; #100;
        // `print_key(current_round, out_key)

        // for(i=0;i < 15; i=i+1) begin
        //     CLK = 0; LOAD = 0; #100;
        //     CLK = 1; LOAD = 0; #100;
        //     `print_key(current_round, out_key)
        // end



    end

endmodule
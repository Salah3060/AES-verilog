onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /AES_tb/CLK
add wave -noupdate /AES_tb/assert
add wave -noupdate /AES_tb/mode
add wave -noupdate -radix decimal /AES_tb/i
add wave -noupdate /AES_tb/reset
add wave -noupdate /AES_tb/aes/state
add wave -noupdate /AES_tb/aes/corresponding_key
add wave -noupdate /AES_tb/aes/key_load
add wave -noupdate /AES_tb/aes/key_revers
add wave -noupdate /AES_tb/aes/out_key
add wave -noupdate /AES_tb/aes/cipher_enable
add wave -noupdate /AES_tb/aes/cipher_reset
add wave -noupdate /AES_tb/aes/cipher_state
add wave -noupdate /AES_tb/aes/inv_cipher_enable
add wave -noupdate /AES_tb/aes/inv_cipher_reset
add wave -noupdate /AES_tb/aes/current_round
add wave -noupdate /AES_tb/aes/is_cipher_done
add wave -noupdate /AES_tb/aes/inv_cipher_state
add wave -noupdate /AES_tb/aes/is_inv_cipher_done
add wave -noupdate /AES_tb/aes/delay
add wave -noupdate /AES_tb/aes/corresponding_state
add wave -noupdate /AES_tb/aes/shited_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {411 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 244
configure wave -valuecolwidth 222
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {3186 ps}

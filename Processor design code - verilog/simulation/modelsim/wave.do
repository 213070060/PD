onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/reset
add wave -noupdate /testbench/pc_out
add wave -noupdate /testbench/alu_result
add wave -noupdate /testbench/i
add wave -noupdate -radix hexadecimal -childformat {{{/testbench/uut/register/reg_array[7]} -radix hexadecimal} {{/testbench/uut/register/reg_array[6]} -radix hexadecimal} {{/testbench/uut/register/reg_array[5]} -radix hexadecimal} {{/testbench/uut/register/reg_array[4]} -radix hexadecimal} {{/testbench/uut/register/reg_array[3]} -radix hexadecimal} {{/testbench/uut/register/reg_array[2]} -radix hexadecimal} {{/testbench/uut/register/reg_array[1]} -radix hexadecimal} {{/testbench/uut/register/reg_array[0]} -radix hexadecimal}} -expand -subitemconfig {{/testbench/uut/register/reg_array[7]} {-height 15 -radix hexadecimal} {/testbench/uut/register/reg_array[6]} {-height 15 -radix hexadecimal} {/testbench/uut/register/reg_array[5]} {-height 15 -radix hexadecimal} {/testbench/uut/register/reg_array[4]} {-height 15 -radix hexadecimal} {/testbench/uut/register/reg_array[3]} {-height 15 -radix hexadecimal} {/testbench/uut/register/reg_array[2]} {-height 15 -radix hexadecimal} {/testbench/uut/register/reg_array[1]} {-height 15 -radix hexadecimal} {/testbench/uut/register/reg_array[0]} {-height 15 -radix hexadecimal}} /testbench/uut/register/reg_array
add wave -noupdate -radix hexadecimal /testbench/uut/pc
add wave -noupdate /testbench/uut/rr_ex_branch
add wave -noupdate -radix hexadecimal /testbench/uut/branch_mux/a
add wave -noupdate -radix hexadecimal /testbench/uut/branch_mux/b
add wave -noupdate /testbench/uut/branch_mux/sel
add wave -noupdate -radix hexadecimal /testbench/uut/branch_mux/y
add wave -noupdate /testbench/uut/alu_unit/reset
add wave -noupdate /testbench/uut/alu_unit/a
add wave -noupdate /testbench/uut/alu_unit/b
add wave -noupdate -radix binary /testbench/uut/alu_unit/alu_control
add wave -noupdate /testbench/uut/alu_unit/result
add wave -noupdate /testbench/uut/alu_unit/carry
add wave -noupdate /testbench/uut/alu_unit/zero
add wave -noupdate /testbench/uut/alu_unit/write_en
add wave -noupdate /testbench/uut/alu_unit/temp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {544775 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
configure wave -valuecolwidth 100
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
configure wave -timelineunits ps
update
WaveRestoreZoom {413948 ps} {761326 ps}

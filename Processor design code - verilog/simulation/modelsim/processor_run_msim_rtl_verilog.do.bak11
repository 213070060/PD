transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/control.v}
vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/alu.v}
vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/register_file.v}
vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/instr_mem.v}
vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/processor.v}
vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/mux2x1.v}
vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/mux4x1.v}

vlog -vlog01compat -work work +incdir+C:/Data/QuartusPrimeWorkingDirectory/Processor\ Design\ Till\ Branch\ and\ Jump/Processor\ Design {C:/Data/QuartusPrimeWorkingDirectory/Processor Design Till Branch and Jump/Processor Design/testbench.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  testbench

add wave *
view structure
view signals
run -all

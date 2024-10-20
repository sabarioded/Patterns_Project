#------------------------------------------------------------------------------
# File          : Makefile
# Project       : RTL
# Author        : epmkos
# Creation date : Aug 13, 2024
# Description   : This Makefile is used to compile and run a UVM-based testbench 
#                 using Synopsys VCS simulator. It sets up UVM paths, compilation 
#                 flags, and specifies the files required for the Pattern Generator project.
#------------------------------------------------------------------------------

# Path to UVM library
UVM_HOME = /eda/synopsys/2020-21/RHELx86/VCS_2020.12/vcs/R-2020.12/etc/uvm-1.2

# UVM verbosity level (options: UVM_NONE, UVM_LOW, UVM_MEDIUM, UVM_HIGH, UVM_FULL)
UVM_VERBOSITY = UVM_MEDIUM

# Compiler flags to enable 64-bit compilation
CFLAGS = full64

# VCS command with options:
#   -sverilog         : Enable SystemVerilog compilation
#   -kdb              : Enable VCS knowledge database
#   +warn=noOBSV2G    : Suppress specific warning
#   -timescale        : Set timescale for simulation (1ns/1ns)
#   -debug_access     : Enable debug access with specific options (regions, memory callbacks)
#   +define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR : Define necessary for UVM objects
#   +incdir           : Add directory to search path for includes
#   -cm               : Enable code coverage with various options (line, cond, fsm, etc.)
#   -CFLAGS -DVCS     : Pass flags to the C compiler for DPI usage
VCS = vcs -sverilog -kdb +warn=noOBSV2G -full64 -timescale=1ns/1ns \
        -debug_access+r+w+nomemcbk -debug_region+cell +vpi -debug_access+nomemcbk+dmptf -debug_region+cell \
	+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
	+incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv \
	-cm_cond allops+anywidth+event -cm_noconst \
	-cm line+cond+fsm+branch+tgl -cm_dir ./coverage.vdb\
	$(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS -debug_acc+all -debug_region+cell+encrypt +define+nobanner

# Simulation execution command:
#   +UVM_VERBOSITY    : Set the verbosity level for UVM messages
#   +UVM_TR_RECORD    : Enable UVM transaction recording
#   +UVM_LOG_RECORD   : Enable UVM log recording
#   -cm               : Specify which types of coverage to collect (line, cond, fsm)
#   +ntb_random_seed  : Set a specific seed for randomization in simulation
#   -l vcs.log        : Log file for VCS messages
SIMV = ./simv +UVM_VERBOSITY=$(UVM_VERBOSITY) \
	+UVM_TR_RECORD +UVM_LOG_RECORD \
	-cm line+cond+fsm \
	+verbose=1 +ntb_random_seed=244 -l vcs.log

# Default target: compiles and runs the simulation
x: comp run

# Compilation target:
#   $(VCS)           : Compiles the design and testbench files
#   +incdir+.        : Adds the current directory to the include search path
#   Lists all design files, interface files, and testbench files necessary for the project.
comp:
	$(VCS) +incdir+. /users/epmkos/Project/design/Binary2Gray.v  \
					/users/epmkos/Project/design/Control.v /users/epmkos/Project/design/Counter.v \
					/users/epmkos/Project/design/Counter12Bit.v /users/epmkos/Project/design/Counter5Bit.v \
					/users/epmkos/Project/design/Ramp.v /users/epmkos/Project/design/Pattern_Generator.v \
					Pattern_Generator_if.sv Pattern_Generator_ref.sv Pattern_Generator_Ref_if.sv Pattern_Generator_sequencer.sv Pattern_Generator_driver.sv Pattern_Generator_monitor.sv Pattern_Generator_agent.sv Pattern_Generator_scoreboard.sv  Pattern_Generator_env.sv Pattern_Generator_test.sv 	Pattern_Generator_top_tb.sv

# Run target: runs the simulation after compilation
run:
	$(SIMV)

# Clean target: removes generated files from the previous compilation and simulation runs
clean:
	rm -rf coverage.vdb csrc DVEfiles inter.vpd simv simv.daidir ucli.key vc_hdrs.h vcs.log .inter.vpd.uvm

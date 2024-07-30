UVM_HOME = /eda/synopsys/2020-21/RHELx86/VCS_2020.12/vcs/R-2020.12/etc/uvm-1.2
UVM_VERBOSITY = UVM_MEDIUM
CFLAGS = full64
	
VCS = vcs -sverilog -kdb +warn=noOBSV2G -full64 -timescale=1ns/1ns \
        -debug_access+r+w+nomemcbk -debug_region+cell +vpi -debug_access+nomemcbk+dmptf -debug_region+cell \
	+define+UVM_OBJECT_MUST_HAVE_CONSTRUCTOR \
	+incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv \
	-cm_cond allops+anywidth+event -cm_noconst \
	-cm line+cond+fsm+branch+tgl -cm_dir ./coverage.vdb\
	$(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS -debug_acc+all -debug_region+cell+encrypt +define+nobanner
		
SIMV = ./simv +UVM_VERBOSITY=$(UVM_VERBOSITY) \
	+UVM_TR_RECORD +UVM_LOG_RECORD \
	-cm line+cond+fsm \
	+verbose=1 +ntb_random_seed=244 -l vcs.log
	
x: comp run
	
comp:
	$(VCS) +incdir+. /users/epmkos/Project/design/Binary2Gray.v  \
					/users/epmkos/Project/design/Control.v /users/epmkos/Project/design/Counter.v \
					/users/epmkos/Project/design/Counter12Bit.v /users/epmkos/Project/design/Counter5Bit.v \
					/users/epmkos/Project/design/Ramp.v /users/epmkos/Project/design/Pattern_Generator.v \
					Pattern_Generator_if.sv NeuralNet_Ref.sv Pattern_Generator_Ref_if.sv NeuralNet_sequencer.sv NeuralNet_driver.sv NeuralNet_monitor.sv NeuralNet_agent.sv NeuralNet_scoreboard.sv  NeuralNet_env.sv NeuralNet_test.sv 	NeuralNet_test_tb.sv
	
run:
	$(SIMV)
	
clean:
	rm -rf coverage.vdb csrc DVEfiles inter.vpd simv simv.daidir ucli.key vc_hdrs.h vcs.log .inter.vpd.uvm

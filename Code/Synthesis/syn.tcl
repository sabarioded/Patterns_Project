# Set the top module for the design
set TopModule Pattern_Generator

# Define the design library 'work'
define_design_lib work -path ./WORK

# Read the design files in SystemVerilog format
read_file -format verilog Control.v
read_file -format verilog Ramp.v
read_file -format verilog Counter.v
read_file -format verilog Counter5Bit.v
read_file -format verilog Counter12Bit.v
read_file -format verilog Pattern_Generator.v

# Set the current design to the top module
current_design Pattern_Generator

# Create the clock signal with a period of 16 units and a 50% duty cycle
create_clock -name "clk" -period 16 -waveform { 0 8 } [get_ports clk]

# Set optimization options for sequential mapping
set compile_seqmap_propagate_constants false
set compile_seqmap_propagate_high_effort false

# Compile the design using exact mapping
compile -exact_map

# Write the synthesized design to a Verilog file
write -hierarchy -format verilog -output Pattern_Generator_syn.v

# Report area and timing
report_area
report_timing

# Write reports (optional)
report_constraint -all_violators > constraints_report.rpt
report_power > power_report.rpt


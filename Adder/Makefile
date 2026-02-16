#1. Khai báo biến

# Compiler
COMPILER = iverilog

#Simulator
SIMULATOR = vvp

#Viewer
VIEWER = gtkwave.exe

#Used Files
DESIGN_FILE = Multiple_bits_Adder.v
TESTBENCH_FILE = Multiple_bits_Adder_tb.v
OUTPUT_FILE = Multiple_bits_Adder_out.out
WAVE_FILE = Multiple_bits_Adder_wave.vcd

#Rules
all: compile run view

compile:
	$(COMPILER) -o $(OUTPUT_FILE) $(DESIGN_FILE) $(TESTBENCH_FILE)

run:
	$(SIMULATOR) $(OUTPUT_FILE)

view:
	$(VIEWER) $(WAVE_FILE)

clean:
	rm -f %(OUTPUT_FILE) $(WAVE_FILE)
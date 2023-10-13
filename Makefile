VIVADO_SETTINGS := C:/Xilinx/Vivado/2023.1/settings64.sh

PROJ_NAME		:= example
SIM_TOP			:= example_tb

SRC_DIR			:= src
SIM_DIR			:= sim
BUILD_DIR		:= .build

WAVEFORM_CFG := $(SIM_DIR)/$(SIM_TOP).sim.wcfg

WAVEFORM_VCD := simulation_${PROJ_NAME}.wdb

all: sim

sim: $(WAVEFORM_VCD)

$(WAVEFORM_VCD): $(SRC_DIR)/*.vhdl
	source $(VIVADO_SETTINGS) && \
	cd $(BUILD_DIR) && \
	xelab -debug typical -top $(SIM_TOP) -snapshot $(SIM_TOP)_snapshot && \
	xsim $(SIM_TOP)_snapshot -gui -view ../$(WAVEFORM_CFG)

$(SRC_DIR)/*.vhdl: $(BUILD_DIR) 
	source $(VIVADO_SETTINGS) && \
	cd $(BUILD_DIR) && \
	xvhdl ../$(SRC_DIR)/*.vhdl ../$(SIM_DIR)/*.vhdl

$(BUILD_DIR):
	source $(VIVADO_SETTINGS) && \
	mkdir -p $@

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) *.log *.pb *.jou *.wdb *.str xsim.dir .Xil
VIVADO_SETTINGS := C:/Xilinx/Vivado/2023.1/settings64.sh

PROJ_NAME		:= example
SIM_TOP			:= example_tb

SRC_DIR			:= src
SIM_DIR			:= sim
BUILD_DIR		:= .build

WAVEFORM_CFG := $(SIM_DIR)/$(SIM_TOP).sim.wcfg

WAVEFORM_VCD := simulation_${PROJ_NAME}.wdb

sim: $(WAVEFORM_VCD)

$(WAVEFORM_VCD): $(SRC_DIR)/*.vhdl
	cd $(BUILD_DIR) && \
	xelab -debug typical $(SIM_TOP) -s $(SIM_TOP).sim && \
	xsim $(SIM_TOP).sim -gui -view ../$(WAVEFORM_CFG)

$(SRC_DIR)/*.vhdl: $(BUILD_DIR)
	cd $(BUILD_DIR) && \
	xvhdl ../$(SRC_DIR)/*.vhdl ../$(SIM_DIR)/*.vhdl

$(BUILD_DIR):
	source $(VIVADO_SETTINGS) && \
	mkdir -p $@

clean:
	rm -rf $(BUILD_DIR) *.log *.pb
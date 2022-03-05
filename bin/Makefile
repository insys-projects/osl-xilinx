SHELL := /bin/bash
TOOLS := /opt/xilinx/Vitis
VERSION := 2020.2
SOC_TYPE := zynqmp

all:
	$(TOOLS)/$(VERSION)/bin/xsct -eval "source jtag-boot-$(SOC_TYPE).tcl"

boot.scr: rmboot
	mkimage -A arm64 -O linux -T script -C none -a 0 -e 0 -n 'U-boot Script' -d boot.cmd boot.scr

rmboot:
	rm -fv boot.scr

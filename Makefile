
#BOARD ?= fmc130e
#BOARD_VER ?= v12
#BOARD ?= fmc133v
#BOARD_VER ?= v12
BOARD ?= fmc138m
BOARD_VER ?= v12

#SOC_TYPE ?= zynq
SOC_TYPE ?= zynqmp
HDF_EXT ?= xsa

SHELL := /bin/bash
TOOLS_ROOT ?= /opt/xilinx
TOOLS ?= $(TOOLS_ROOT)/Vitis
TOOLS_VERSION ?= 2020.2
DTS_VERSION ?= 2021.2
MAKE := make
MKDIR := mkdir

SRC_DIR := $(HOME)/xilsrc
#SRC_DIR := $(HOME)/xilinx-sdk-tools

SRC_KERNEL_LINK := https://github.com/Xilinx
SRC_KERNEL_NAME := linux-xlnx

#SRC_KERNEL_LINK := https://github.com/analogdevicesinc
#SRC_KERNEL_NAME := linux.git

#SRC_VER := xilinx-v$(VERSION)
SRC_VER := master

EXT := $(HDF_EXT)

include Makefile.$(SOC_TYPE)
include Makefile.src

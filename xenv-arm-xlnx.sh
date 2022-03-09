source /opt/xilinx/Vivado/2020.2/settings64.sh

export BOARD=fmc130e

export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

export CC=${CROSS_COMPILE}gcc
export CPP="${CROSS_COMPILE}gcc"
export CXX="${CROSS_COMPILE}g++"

export NM=${CROSS_COMPILE}nm
export RANLIB=${CROSS_COMPILE}ranlib
export OBJCOPY=${CROSS_COMPILE}objcopy
export STRIP=${CROSS_COMPILE}strip
export AS=${CROSS_COMPILE}as
export AR=${CROSS_COMPILE}ar
export OBJDUMP=${CROSS_COMPILE}objdump

export INSTALL_MOD_PATH=/tftpboot/${BOARD}/nfsroot
export KERNELDIR=`pwd`/$BOARD-linux
export KERNEL_SRC=${KERNELDIR}

export PS1="\[\e[32;1m\][${ARCH}]\[\e[0m\]:\w> "

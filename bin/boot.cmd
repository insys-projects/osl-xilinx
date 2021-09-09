setenv board fmc130e;
setenv dtbaddr 0x20000000;
setenv loadaddr 0x10000000;
setenv sel_pin 48;
setenv led_y 46;
setenv yellow_on 'gpio clear $led_y;'
setenv yellow_off 'gpio set $led_y;'
setenv sd_on 'gpio clear ${sel_pin}; mmc rescan;'
setenv emmc_on 'gpio set ${sel_pin}; mmc rescan;'
setenv setenv ipaddr 192.168.0.242; setenv serverip 192.168.0.102;
setenv sd_dev 0;

setenv fname system.bit.bin;
setenv loadfile 'fatload mmc ${sd_dev}:1 ${loadaddr} ${fname};'
setenv savefile 'fatwrite mmc ${sd_dev}:1 ${loadaddr} ${fname} ${filesize};'
setenv copyfile 'run sd_on; run loadfile; run emmc_on; run savefile; run sd_on;'
setenv copyboot 'setenv fname BOOT.BIN; run copyfile;'
setenv copydtb 'setenv fname system.dtb; run copyfile;'
setenv copybit 'setenv fname system.bit.bin; run copyfile;'
setenv copyimg 'setenv fname image.ub.sd; run copyfile;'
setenv copyimgr 'setenv fname image.ub.ramfs; run copyfile;'
setenv copyfs 'setenv fname rootfs-arm.tar; run copyfile;'
setenv copyenv 'setenv fname uboot.env; run copyfile;'
setenv copyall 'run copyboot; run copydtb; run copybit; run copyimg; run copyimgr; run copyfs; run copyenv;'

setenv loadbit  'fatload mmc ${sd_dev}:1 0x10000000 system.bit.bin; fpga load 0 0x10000000 ${filesize};'
setenv loadimg  'fatload mmc ${sd_dev}:1 0x10000000 image.ub.sd;'
setenv loadbit  'fatload mmc ${sd_dev}:1 0x10000000 system.bit.bin; fpga load 0 0x10000000 ${filesize};'
setenv loaddtb  'fatload mmc ${sd_dev}:1 0x20000000 system.dtb;'
setenv loadimgr 'fatload mmc ${sd_dev}:1 0x10000000 image.ub.ramfs;'

setenv bootargs_sd 'console=ttyPS0,115200 earlyprintk root=/dev/mmcblk0p2 rootfstype=ext4 nolock rw rootwait cpuidle.off=1';
setenv bootargs_nfs 'console=ttyPS0,115200 earlyprintk root=/dev/nfs nfsroot=192.168.0.102:/tftpboot/nfsroot-fmc130e, tcp rw ip=dhcp';
setenv bootargs_ramfs 'console=ttyPS0,115200 earlyprintk root=/dev/ram0 rw ramdisk_size=131072 ip=dhcp';

setenv start 'run sd_on; run loadbit; run loadimg; run loaddtb; setenv bootargs ${bootargs_sd}; bootm 0x10000000 - 0x20000000;'
setenv start 'run sd_on; run loadbit; run loadimg; run loaddtb; setenv bootargs ${bootargs_nfs}; bootm 0x10000000 - 0x20000000;'
setenv startr 'run sd_on; run loadbit; run loadimgr; setenv bootargs ${bootargs_ramfs}; bootm 0x10000000;'

setenv bootcmd 'run start;'

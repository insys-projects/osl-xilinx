setenv board fmc138m;
setenv dtbaddr 0x20000000;
setenv loadaddr 0x10000000;
setenv ipaddr 192.168.0.242; 
setenv serverip 192.168.0.102;
setenv sd_dev 1;

setenv loadbitn  'tftpboot 0x10000000 ${board}/system.bit.bin; fpga load 0 0x10000000 ${filesize};'
setenv loadimgn  'tftpboot 0x10000000 ${board}/image.ub.sd'
setenv loaddtbn  'tftpboot 0x20000000 ${board}/system.dtb;'
setenv loadimgrn 'tftpboot 0x10000000 ${board}/image.ub.ramfs;'

setenv bootargs_nfs 'console=ttyPS0,115200 earlyprintk clk_ignore_unused cpuidle.off=1 root=/dev/nfs rootwait rw \
nfsroot=192.168.0.102:/tftpboot/fmc138m/nfsroot,tcp,nfsvers=3 \
ip=192.168.0.232:192.168.0.102:192.168.0.1:255.255.255.0:fmc138m-axi:eth0:off';

setenv startn 'run loadbitn; run loadimgn; run loaddtbn; setenv bootargs ${bootargs_nfs}; bootm 0x10000000 - 0x20000000;'
setenv bootcmd 'run startn;'
boot
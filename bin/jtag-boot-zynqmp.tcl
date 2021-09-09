connect

targets -set 4
fpga -state -file system.bit
puts "Downloading bitsream"
puts ""

after 2000

#Add the Microblaze PMU to target
targets -set -nocase -filter {name =~ "PSU"}
mwr 0xFFCA0038 0x1FF

# Download PMUFW to PMU
target -set -filter {name =~ "MicroBlaze PMU"}
puts "Downloading pmufw"
dow pmufw.elf
con
puts ""
after 500
state

targets -set -nocase -filter {name =~ "PSU"}
mwr 0xffff0000 0x14000000
mwr 0xFD1A0104 0x380E
after 500
state

# Download FSBL to A53 #0
targets -set -filter {name =~ "Cortex-A53 #0"}
puts "Downloading fsbl"
dow zynqmp_fsbl.elf
con
puts ""
after 500

dow -data boot.scr 0x20000000
puts "Downloading boot.scr"
puts ""
after 500

targets -set -filter {name =~ "Cortex-A53 #0"}
puts "Downloading u-boot"
dow u-boot.elf
dow bl31.elf
con
puts ""
after 500

#stop

disconnect

exit 0

/*
  Targets List:

  1  PS TAP
     2  PMU
        3  MicroBlaze PMU (Sleeping. No clock)
     4* PL
  5  PSU (JTAG port open error. AXI AP transaction error, DAP status 30000021)
     6  RPU (Reset)
        7  Cortex-R5 #0 (RPU Reset)
        8  Cortex-R5 #1 (RPU Reset)
     9  APU
       10  Cortex-A53 #0 (Running)
       11  Cortex-A53 #1 (Power On Reset)
       12  Cortex-A53 #2 (Power On Reset)
       13  Cortex-A53 #3 (Power On Reset)

*/
connect

#targets
#puts "\n"
#after 100

targets -set -filter {name =~ "ARM*#0"}
rst -processor

#puts "Downloading bitstream"
#targets -set -filter {name =~ "xc7z*"}
#fpga -file system.bit
#after 1000

targets -set -filter {name =~ "ARM*#0"}

puts "Start loading fsbl"
#dow jtag-executable.elf
dow zynq_fsbl.elf
puts "Complete loading fsbl"
con

after 500

puts "Start Downloading u-boot"
dow u-boot.elf
puts "Downloading u-boot"
con

after 500
#jtagterminal
#after 5000

#dow -data system.dtb 0x10000000
#after 100
#puts "Downloading system.dtb"

#dow -data image.ub.sd 0x20000000
#after 100
#puts "Downloading image.ub"



#after 500000
#jtagterminal -stop

disconnect

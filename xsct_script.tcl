
#------------------------------------------------------------------------------

proc fsblmp {args} {
    set board 0
    for {set i 0} {$i < [llength $args]} {incr i} {
        if {[lindex $args $i] == "-board"} {
            set board [string tolower [lindex $args [expr {$i + 1}]]]
        }
    }
    set xsa [glob -nocomplain -directory ${board}-xsa -type f *.xsa *.hdf]
    hsi::open_hw_design $xsa
    set fsbl_design [hsi::create_sw_design fsbl_1 -proc psu_cortexa53_0 -app zynqmp_fsbl]
    if {$board != 0} {
        common::set_property -name APP_COMPILER_FLAGS -value "-DXPS_BOARD_${board}" -objects $fsbl_design
    }
    hsi::generate_app -dir ${board}-fsblmp -compile
    hsi::close_hw_design [hsi::current_hw_design]
}

#------------------------------------------------------------------------------

proc zynqmp_dts {args} {
    set board 0
    set version 2021.2
    for {set i 0} {$i < [llength $args]} {incr i} {
        if {[lindex $args $i] == "-board"} {
            set board [string tolower [lindex $args [expr {$i + 1}]]]
        }
        if {[lindex $args $i] == "-version"} {
            set version [string toupper [lindex $args [expr {$i + 1}]]]
        }
    }
        set xsa [glob -nocomplain -directory ${board}-xsa -type f *.xsa *.hdf]
        hsi::open_hw_design $xsa
        hsi::set_repo_path ./dts
        hsi::create_sw_design device-tree -os device_tree -proc psu_cortexa53_0
        hsi::generate_target -dir ${board}-dts
        hsi::close_hw_design [hsi::current_hw_design]
        if {$board != 0} {
        foreach lib [glob -nocomplain -directory ./dts/device-tree-xlnx/device_tree/data/kernel_dtsi/${version}/include/dt-bindings -type d *] {
            if {![file exists ${board}-dts/include/dt-bindings/[file tail $lib]]} {
                file copy -force $lib ${board}-dts/include/dt-bindings
            }
        }
        set dtsi_files [glob -nocomplain -directory ./dts/device-tree-xlnx/device_tree/data/kernel_dtsi/${version}/BOARD -type f *${board}*]
        puts ${dtsi_files}
        if {[llength $dtsi_files] != 0} {
            file copy -force [lindex $dtsi_files end] ${board}-dts
            set fileId [open ${board}-dts/system-user.dtsi "w"]
            puts $fileId "/include/ \"[file tail [lindex $dtsi_files end]]\""
            puts $fileId "/ {"
            puts $fileId "};"
            close $fileId
        }
    }
}

#------------------------------------------------------------------------------

proc pmufw {args} {
    set board 0
    for {set i 0} {$i < [llength $args]} {incr i} {
        if {[lindex $args $i] == "-board"} {
            set board [string tolower [lindex $args [expr {$i + 1}]]]
        }
    }
    set xsa [glob -nocomplain -directory ${board}-xsa -type f *.xsa *.hdf]
    hsi::open_hw_design $xsa
    hsi::generate_app -app zynqmp_pmufw -proc psu_pmu_0 -dir ${board}-pmufw -compile
    hsi::close_hw_design [hsi::current_hw_design]
}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------

proc fsbl {args} {
    set board 0
    for {set i 0} {$i < [llength $args]} {incr i} {
        if {[lindex $args $i] == "-board"} {
            set board [string tolower [lindex $args [expr {$i + 1}]]]
        }
    }
    set xsa [glob -nocomplain -directory ${board}-xsa -type f *.xsa *.hdf]
    hsi::open_hw_design $xsa
    set fsbl_design [hsi::create_sw_design fsbl_1 -proc ps7_cortexa9_0 -app zynq_fsbl]
    if {$board != 0} {
        common::set_property -name APP_COMPILER_FLAGS -value "-DXPS_BOARD_${board}" -objects $fsbl_design
    }
    hsi::generate_app -dir ${board}-fsbl -compile
    hsi::close_hw_design [hsi::current_hw_design]
}

#------------------------------------------------------------------------------

proc zynq_dts {args} {
    set board 0
    set version 2021.2
    for {set i 0} {$i < [llength $args]} {incr i} {
        if {[lindex $args $i] == "-board"} {
            set board [string tolower [lindex $args [expr {$i + 1}]]]
        }
        if {[lindex $args $i] == "-version"} {
            set version [string toupper [lindex $args [expr {$i + 1}]]]
        }
    }
        set xsa [glob -nocomplain -directory ${board}-xsa -type f *.xsa *.hdf]
        hsi::open_hw_design $xsa
        hsi::set_repo_path ./dts
        hsi::create_sw_design device-tree -os device_tree -proc ps7_cortexa9_0
        hsi::generate_target -dir ${board}-dts
        hsi::close_hw_design [hsi::current_hw_design]
        if {$board != 0} {
        foreach lib [glob -nocomplain -directory ./dts/device-tree-xlnx/device_tree/data/kernel_dtsi/${version}/include/dt-bindings -type d *] {
            if {![file exists ${board}-dts/include/dt-bindings/[file tail $lib]]} {
                file copy -force $lib ${board}-dts/include/dt-bindings
            }
        }
        set dtsi_files [glob -nocomplain -directory ./dts/device-tree-xlnx/device_tree/data/kernel_dtsi/${version}/BOARD -type f *${board}*]
        puts ${dtsi_files}
        if {[llength $dtsi_files] != 0} {
            file copy -force [lindex $dtsi_files end] ${board}-dts
            set fileId [open ${board}-dts/system-user.dtsi "w"]
            puts $fileId "/include/ \"[file tail [lindex $dtsi_files end]]\""
            puts $fileId "/ {"
            puts $fileId "};"
            close $fileId
        }
    }
}

#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------
#------------------------------------------------------------------------------


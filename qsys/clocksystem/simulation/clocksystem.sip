set_global_assignment -entity "clocksystem" -library "lib_clocksystem" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "clocksystem" -library "lib_clocksystem" -name IP_TOOL_VERSION "13.0sp1"
set_global_assignment -entity "clocksystem" -library "lib_clocksystem" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_clocksystem" -name SPD_FILE [file join $::quartus(sip_path) "../../clocksystem.spd"]
set_global_assignment -library "lib_clocksystem" -name MISC_FILE [file join $::quartus(sip_path) "../../clocksystem.qsys"]

set_global_assignment -library "lib_clocksystem" -name MISC_FILE [file join $::quartus(sip_path) "clocksystem.v"]
set_global_assignment -library "lib_clocksystem" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_clocksystem" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_clocksystem" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_clocksystem" -name MISC_FILE [file join $::quartus(sip_path) "submodules/clocksystem_up_clocks_0.v"]

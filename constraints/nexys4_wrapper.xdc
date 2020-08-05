## This file is a general .xdc for the Nexys4 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports Clock]
set_property IOSTANDARD LVCMOS33 [get_ports Clock]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports Clock]
create_clock -period 20.000 -name ahb_clock -waveform {1.000 11.000} [get_nets Clock50]

## Buttons
set_property PACKAGE_PIN C12 [get_ports nReset]
set_property IOSTANDARD LVCMOS33 [get_ports nReset]

# This is the top button in the cluster of 5
set_property PACKAGE_PIN F15 [get_ports {Buttons[0]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Buttons[0]' has been applied to the port object 'Buttons[0]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Buttons[0]}]

# This is the bottom button in the cluster of 5
set_property PACKAGE_PIN V10 [get_ports {Buttons[1]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Buttons[1]' has been applied to the port object 'Buttons[1]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Buttons[1]}]

## Switches
set_property PACKAGE_PIN U9 [get_ports {Switches[0]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[0]' has been applied to the port object 'Switches[0]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[0]}]
set_property PACKAGE_PIN U8 [get_ports {Switches[1]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[1]' has been applied to the port object 'Switches[1]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[1]}]
set_property PACKAGE_PIN R7 [get_ports {Switches[2]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[2]' has been applied to the port object 'Switches[2]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[2]}]
set_property PACKAGE_PIN R6 [get_ports {Switches[3]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[3]' has been applied to the port object 'Switches[3]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[3]}]
set_property PACKAGE_PIN R5 [get_ports {Switches[4]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[4]' has been applied to the port object 'Switches[4]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[4]}]
set_property PACKAGE_PIN V7 [get_ports {Switches[5]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[5]' has been applied to the port object 'Switches[5]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[5]}]
set_property PACKAGE_PIN V6 [get_ports {Switches[6]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[6]' has been applied to the port object 'Switches[6]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[6]}]
set_property PACKAGE_PIN V5 [get_ports {Switches[7]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[7]' has been applied to the port object 'Switches[7]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[7]}]
set_property PACKAGE_PIN U4 [get_ports {Switches[8]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[8]' has been applied to the port object 'Switches[8]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[8]}]
set_property PACKAGE_PIN V2 [get_ports {Switches[9]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[9]' has been applied to the port object 'Switches[9]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[9]}]
set_property PACKAGE_PIN U2 [get_ports {Switches[10]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[10]' has been applied to the port object 'Switches[10]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[10]}]
set_property PACKAGE_PIN T3 [get_ports {Switches[11]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[11]' has been applied to the port object 'Switches[11]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[11]}]
set_property PACKAGE_PIN T1 [get_ports {Switches[12]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[12]' has been applied to the port object 'Switches[12]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[12]}]
set_property PACKAGE_PIN R3 [get_ports {Switches[13]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[13]' has been applied to the port object 'Switches[13]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[13]}]
set_property PACKAGE_PIN P3 [get_ports {Switches[14]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[14]' has been applied to the port object 'Switches[14]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[14]}]
set_property PACKAGE_PIN P4 [get_ports {Switches[15]}]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'Switches[15]' has been applied to the port object 'Switches[15]'.
set_property IOSTANDARD LVCMOS33 [get_ports {Switches[15]}]


## LEDs
##Bank = 34, Pin name = IO_L24N_T3_34,						Sch name = LED0
set_property PACKAGE_PIN T8 [get_ports {DataOut[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[0]}]
##Bank = 34, Pin name = IO_L21N_T3_DQS_34,					Sch name = LED1
set_property PACKAGE_PIN V9 [get_ports {DataOut[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[1]}]
##Bank = 34, Pin name = IO_L24P_T3_34,						Sch name = LED2
set_property PACKAGE_PIN R8 [get_ports {DataOut[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[2]}]
##Bank = 34, Pin name = IO_L23N_T3_34,						Sch name = LED3
set_property PACKAGE_PIN T6 [get_ports {DataOut[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[3]}]
##Bank = 34, Pin name = IO_L12P_T1_MRCC_34,					Sch name = LED4
set_property PACKAGE_PIN T5 [get_ports {DataOut[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[4]}]
##Bank = 34, Pin name = IO_L12N_T1_MRCC_34,					Sch name = LED5
set_property PACKAGE_PIN T4 [get_ports {DataOut[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[5]}]
##Bank = 34, Pin name = IO_L22P_T3_34,						Sch name = LED6
set_property PACKAGE_PIN U7 [get_ports {DataOut[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[6]}]
##Bank = 34, Pin name = IO_L22N_T3_34,						Sch name = LED7
set_property PACKAGE_PIN U6 [get_ports {DataOut[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[7]}]

set_property PACKAGE_PIN V4 [get_ports {DataOut[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[8]}]
set_property PACKAGE_PIN U3 [get_ports {DataOut[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[9]}]
set_property PACKAGE_PIN V1 [get_ports {DataOut[10]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[10]}]
set_property PACKAGE_PIN R1 [get_ports {DataOut[11]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[11]}]
set_property PACKAGE_PIN P5 [get_ports {DataOut[12]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[12]}]
set_property PACKAGE_PIN U1 [get_ports {DataOut[13]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[13]}]
set_property PACKAGE_PIN R2 [get_ports {DataOut[14]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[14]}]
set_property PACKAGE_PIN P2 [get_ports {DataOut[15]}]
set_property IOSTANDARD LVCMOS33 [get_ports {DataOut[15]}]

# LD16 RGB LED Signals
set_property PACKAGE_PIN K5 [get_ports Status_Red]
set_property IOSTANDARD LVCMOS33 [get_ports Status_Red]
set_property PACKAGE_PIN F13 [get_ports Status_Green]
set_property IOSTANDARD LVCMOS33 [get_ports Status_Green]
# LD17 RGB LED Signals
set_property PACKAGE_PIN K6 [get_ports DataInvalid]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'DataInvalid' has been applied to the port object 'DataInvalid'.
set_property IOSTANDARD LVCMOS33 [get_ports DataInvalid]
set_property PACKAGE_PIN H6 [get_ports DataValid]
# The conversion of 'IOSTANDARD' constraint on 'net' object 'DataValid' has been applied to the port object 'DataValid'.
set_property IOSTANDARD LVCMOS33 [get_ports DataValid]

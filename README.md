# ARM_SOC
An ARM Cortex M0 processor is used as the central processing unit for the system. It
uses a simple AHB-LITE bus that acts as an interface between the Cortex M0 a third
party processor which is part of ARM Cortex M0 Design start which acts as an AHB
master and all the other units in the ARM-SoC which act as AHB slaves. The blocks
mentioned in the Figure below as RAM and SWITCH INTERFACE are part of custom third party
modules. The OUTPUT INTERFACE was modified to spit out pixel coordinates in x and y axis to make a red square. 
The razzle block is a modified VGA interface which is not connected to the ARM SOC.
![Capture](https://github.com/ks6n19/arm_soc/blob/master/Capture.PNGs)
# PIXEL COLOUR
The colour of the pixel is specified in the VGA interface (Razzle block). 
# ARM PROGRAM
The coordinates of the squares are specified in hex format in the main.c of software.

# SimVision command script arm_soc.tcl

simvision {

  # Open new waveform window

    window new WaveWindow  -name  "Waves for ARM SoC Example"
    waveform  using  "Waves for ARM SoC Example"

  # Add Waves

    waveform  add  -signals  de1_soc_wrapper_stim.CLOCK_50
    waveform  add  -signals  de1_soc_wrapper_stim.SW
    waveform  add  -signals  de1_soc_wrapper_stim.LEDR
    waveform  add  -signals  de1_soc_wrapper_stim.HEX0
    waveform  add  -signals  de1_soc_wrapper_stim.HEX1
    waveform  add  -signals  de1_soc_wrapper_stim.HEX2
    waveform  add  -signals  de1_soc_wrapper_stim.HEX3
    waveform  add  -signals  de1_soc_wrapper_stim.KEY
    waveform  add  -signals  de1_soc_wrapper_stim.VGA_R
    waveform  add  -signals  de1_soc_wrapper_stim.VGA_G
    waveform  add  -signals  de1_soc_wrapper_stim.VGA_B
    waveform  add  -signals  de1_soc_wrapper_stim.VGA_HS
    waveform  add  -signals  de1_soc_wrapper_stim.VGA_VS
    waveform  add  -signals  de1_soc_wrapper_stim.VGA_CLK
    waveform  add  -signals  de1_soc_wrapper_stim.VGA_BLANK_N
    waveform  add  -signals  de0_wrapper_stim.dut.soc_inst.HADDR
    waveform  add  -signals  de0_wrapper_stim.dut.soc_inst.HWRITE
    waveform  add  -signals  de0_wrapper_stim.dut.soc_inst.HSEL_RAM
    waveform  add  -signals  de0_wrapper_stim.dut.soc_inst.HSEL_SW
    waveform  add  -signals  de0_wrapper_stim.dut.soc_inst.HSEL_DOUT

}


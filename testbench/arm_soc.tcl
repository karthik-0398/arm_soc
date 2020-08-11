# SimVision command script arm_soc.tcl

simvision {

  # Open new waveform window

    window new WaveWindow  -name  "Waves for ARM SoC Example"
    waveform  using  "Waves for ARM SoC Example"

  # Add Waves

    waveform  add  -signals  arm_soc_stim.HCLK
    waveform  add  -signals  arm_soc_stim.HRESETn
    waveform  add  -signals  arm_soc_stim.Switches
    waveform  add  -signals  arm_soc_stim.Buttons
    waveform  add  -signals  arm_soc_stim.x1
    waveform  add  -signals  arm_soc_stim.x2
    waveform  add  -signals  arm_soc_stim.y1
    waveform  add  -signals  arm_soc_stim.y2    
    waveform  add  -signals  arm_soc_stim.LOCKUP
    waveform  add  -signals  arm_soc_stim.dut.HADDR
    waveform  add  -signals  arm_soc_stim.dut.HWRITE
    waveform  add  -signals  arm_soc_stim.dut.HSEL_RAM
    waveform  add  -signals  arm_soc_stim.dut.HSEL_SW
    waveform  add  -signals  arm_soc_stim.dut.HSEL_DOUT

}


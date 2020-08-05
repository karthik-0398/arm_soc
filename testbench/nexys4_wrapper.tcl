# SimVision command script arm_soc.tcl

simvision {

  # Open new waveform window

    window new WaveWindow  -name  "Waves for ARM SoC Example"
    waveform  using  "Waves for ARM SoC Example"

  # Add Waves

    waveform  add  -signals  nexys4_wrapper_stim.Clock
    waveform  add  -signals  nexys4_wrapper_stim.nReset
    waveform  add  -signals  nexys4_wrapper_stim.Switches
    waveform  add  -signals  nexys4_wrapper_stim.Buttons
    waveform  add  -signals  nexys4_wrapper_stim.DataOut
    waveform  add  -signals  nexys4_wrapper_stim.DataValid
    waveform  add  -signals  nexys4_wrapper_stim.DataInvalid
    waveform  add  -signals  nexys4_wrapper_stim.Status_Green
    waveform  add  -signals  nexys4_wrapper_stim.Status_Red
    waveform  add  -signals  nexys4_wrapper_stim.dut.soc_inst.HADDR
    waveform  add  -signals  nexys4_wrapper_stim.dut.soc_inst.HWRITE
    waveform  add  -signals  nexys4_wrapper_stim.dut.soc_inst.HSEL_RAM
    waveform  add  -signals  nexys4_wrapper_stim.dut.soc_inst.HSEL_SW
    waveform  add  -signals  nexys4_wrapper_stim.dut.soc_inst.HSEL_DOUT

}


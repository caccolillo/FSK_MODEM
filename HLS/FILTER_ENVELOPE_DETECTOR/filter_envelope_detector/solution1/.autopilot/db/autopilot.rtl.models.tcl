set SynModuleInfo {
  {SRCNAME applyIIRFilter MODELNAME applyIIRFilter RTLNAME applyIIRFilter IS_TOP 1
    SUBMODULES {
      {MODELNAME applyIIRFilter_mul_31ns_32s_63_2_1 RTLNAME applyIIRFilter_mul_31ns_32s_63_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_mul_32s_32s_63_2_1 RTLNAME applyIIRFilter_mul_32s_32s_63_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_mul_32s_31ns_63_2_1 RTLNAME applyIIRFilter_mul_32s_31ns_63_2_1 BINDTYPE op TYPE mul IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_NUM_1_0_ROM_AUTO_1R RTLNAME applyIIRFilter_NUM_1_0_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_delay_RAM_AUTO_1R1W RTLNAME applyIIRFilter_delay_RAM_AUTO_1R1W BINDTYPE storage TYPE ram IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_NUM_1_1_ROM_AUTO_1R RTLNAME applyIIRFilter_NUM_1_1_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_DEN_1_1_ROM_AUTO_1R RTLNAME applyIIRFilter_DEN_1_1_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_DEN_1_2_ROM_AUTO_1R RTLNAME applyIIRFilter_DEN_1_2_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME applyIIRFilter_flow_control_loop_pipe RTLNAME applyIIRFilter_flow_control_loop_pipe BINDTYPE interface TYPE internal_upc_flow_control INSTNAME applyIIRFilter_flow_control_loop_pipe_U}
    }
  }
}

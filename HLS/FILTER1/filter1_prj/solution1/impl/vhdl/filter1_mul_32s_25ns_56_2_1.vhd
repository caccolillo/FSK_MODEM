-- ==============================================================
-- Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
-- Version: 2022.2
-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- ==============================================================
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity filter1_mul_32s_25ns_56_2_1 is
generic (
    ID : INTEGER := 1;
    NUM_STAGE : INTEGER := 1;
    din0_WIDTH : INTEGER := 14;
    din1_WIDTH : INTEGER := 12;
    dout_WIDTH : INTEGER := 26);
port (
    clk: in std_logic;
    ce: in std_logic;
    reset: in std_logic;
    din0: in std_logic_vector(din0_WIDTH - 1 downto 0);
    din1: in std_logic_vector(din1_WIDTH - 1 downto 0);
    dout: out std_logic_vector(dout_WIDTH - 1 downto 0));
end entity;

architecture behav of filter1_mul_32s_25ns_56_2_1 is
    signal tmp_product : std_logic_vector(dout_WIDTH - 1 downto 0);
    signal a_i : std_logic_vector(din0_WIDTH - 1 downto 0);
    signal b_i : std_logic_vector(din1_WIDTH - 1 downto 0);
    signal p_tmp : std_logic_vector(dout_WIDTH - 1 downto 0);

begin
    a_i <= din0;
    b_i <= din1;
    dout <= p_tmp;

    tmp_product <= std_logic_vector(resize(unsigned(std_logic_vector(signed(a_i) * signed('0' & b_i))), dout_WIDTH));

    process(clk)
    begin
        if (clk'event and clk = '1') then
            if (ce = '1') then
                p_tmp <= tmp_product;
            end if;
        end if;
    end process;
end architecture;

--Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2022.1 (win64) Build 3526262 Mon Apr 18 15:48:16 MDT 2022
--Date        : Tue Aug 27 18:29:47 2024
--Host        : DESKTOP-T6T718M running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
  port (
    Backward_LM : out STD_LOGIC;
    Backward_RM : out STD_LOGIC;
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    Forward_LM : out STD_LOGIC;
    Forward_RM : out STD_LOGIC;
    Manual : in STD_LOGIC_VECTOR ( 3 downto 0 );
    PWM_LM : out STD_LOGIC;
    PWM_RM : out STD_LOGIC;
    e : out STD_LOGIC;
    echo1 : in STD_LOGIC;
    echo2 : in STD_LOGIC;
    echo3 : in STD_LOGIC;
    lcd_data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    mood : in STD_LOGIC;
    on_off : in STD_LOGIC;
    res : out STD_LOGIC;
    res2 : out STD_LOGIC;
    rs : out STD_LOGIC;
    rw : out STD_LOGIC;
    trigger1 : out STD_LOGIC;
    trigger2 : out STD_LOGIC;
    trigger3 : out STD_LOGIC
  );
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  port (
    PWM_LM : out STD_LOGIC;
    Forward_LM : out STD_LOGIC;
    Backward_LM : out STD_LOGIC;
    Backward_RM : out STD_LOGIC;
    Forward_RM : out STD_LOGIC;
    PWM_RM : out STD_LOGIC;
    rw : out STD_LOGIC;
    rs : out STD_LOGIC;
    lcd_data : out STD_LOGIC_VECTOR ( 7 downto 0 );
    e : out STD_LOGIC;
    echo3 : in STD_LOGIC;
    echo2 : in STD_LOGIC;
    trigger3 : out STD_LOGIC;
    trigger2 : out STD_LOGIC;
    res : out STD_LOGIC;
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    trigger1 : out STD_LOGIC;
    echo1 : in STD_LOGIC;
    res2 : out STD_LOGIC;
    Manual : in STD_LOGIC_VECTOR ( 3 downto 0 );
    on_off : in STD_LOGIC;
    mood : in STD_LOGIC
  );
  end component design_1;
begin
design_1_i: component design_1
     port map (
      Backward_LM => Backward_LM,
      Backward_RM => Backward_RM,
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      Forward_LM => Forward_LM,
      Forward_RM => Forward_RM,
      Manual(3 downto 0) => Manual(3 downto 0),
      PWM_LM => PWM_LM,
      PWM_RM => PWM_RM,
      e => e,
      echo1 => echo1,
      echo2 => echo2,
      echo3 => echo3,
      lcd_data(7 downto 0) => lcd_data(7 downto 0),
      mood => mood,
      on_off => on_off,
      res => res,
      res2 => res2,
      rs => rs,
      rw => rw,
      trigger1 => trigger1,
      trigger2 => trigger2,
      trigger3 => trigger3
    );
end STRUCTURE;

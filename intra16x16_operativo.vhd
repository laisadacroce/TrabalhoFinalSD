LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

ENTITY intra16x16_operativo IS
  PORT (
    clk, rst : IN std_logic;

    --ENTRADAS DE CONTROLE
    ch, cv, chv, ci, zi, cm2, cm3, cacc, sel_acc, cdc, cplane, sel_mode, csamples, cline, cabc, sel_hv, sel_i, ci : IN std_logic;

    --ENTRADAS DE DADOS
    v_sample, h_sample : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    corner_sample : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    abc_constants : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
    
    --SAÍDAS DE CONTROLE
    line_index: OUT std_logic_vector(3 DOWNTO 0);
    less: OUT STD_LOGIC;

    --SAÍDAS DE DADOS
    line: OUT STD_LOGIC_VECTOR(127 DOWNTO 0));
END intra16x16_operativo;

ARCHITECTURE arch OF intra16x16_operativo IS
      SIGNAL y : STD_LOGIC_VECTOR(3 DOWNTO 0);
      SIGNAL out_mode2, 8_lsb_samples : STD_LOGIC_VECTOR(7 DOWNTO 0); --saída do módulo mode2, a ser concatenada 16 vezes para gerar o resultado do modo 2; 8 bits menos significativos das samples
      SIGNAL out1_hvconstants, out2_hvconstant, out_v_value, out_h_value : STD_LOGIC_VECTOR(14 DOWNTO 0); --saídas dos H_V_constants e saídas de V_value_reg e H_value_reg
      SIGNAL abc_in, abc_out : STD_LOGIC_VECTOR(35 DOWNTO 0); --entrada e saída do abc_reg
      SIGNAL in_m3_reg, out_m3_reg : STD_LOGIC_VECTOR(39 DOWNTO 0); --entrada e saída do m3_reg
      SIGNAL out_v_reg, out_h_reg, out_mux_hv, result_mode2, 128_bits_h, 128_bits_v, result_mode3, in_line_reg : STD_LOGIC_VECTOR(127 DOWNTO 0); --saída dos registradores H e V; saída do mux hv; redimensionamento do vetor samples; resultado do modo 3; entrada de line_reg
      SIGNAL corner&h, corner&v : STD_LOGIC_VECTOR(135 DOWNTO 0); --entradas de H_V_constants
      SIGNAL samples : STD_LOGIC_VECTOR(263 DOWNTO 0); --concatenação de v_sample, h_sample e corner_sample
BEGIN

END arch;
    

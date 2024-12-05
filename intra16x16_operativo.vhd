LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

ENTITY intra16x16_operativo IS
  port (
    clk, rst : IN std_logic;

    --ENTRADAS DE CONTROLE
    ch, cv, ci, zi, cm2, cm3, cacc, sel_acc, cdc, cplane, sel_mode, csamples, cline, cabc : IN std_logic;

    --ENTRADAS DE DADOS
    v_sample, h_sample : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    corner_sample : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    
    --SAÍDAS DE CONTROLE
    line_address: OUT std_logic_vector(3 DOWNTO 0);
    less: OUT STD_LOGIC;

    --SAÍDAS DE DADOS
    line: OUT STD_LOGIC_VECTOR(127 DOWNTO 0));
END intra16x16_operativo;

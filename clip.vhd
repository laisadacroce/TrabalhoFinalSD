--INCOMPLETO

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

entity clip is
  port(
    input : in std_logic_vector(10 downto 0);
    output : out std_logic_vector(7 downto 0)
    );
end clip;

  architecture arch of clip is
    signal sel_mux1, sel_mux2 : std_logic;
    signal mux1_in0, mux2_in0, reg_in : std_logic_vector(7 downto 0);
    begin

      MUX1 : entity work.mux2_1
      

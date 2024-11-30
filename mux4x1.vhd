LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY mux4x1 IS
    GENERIC (N : POSITIVE);
    PORT (
        F1 : IN std_logic_vector(N - 1 DOWNTO 0);
        F2 : IN std_logic_vector(N - 1 DOWNTO 0);
        F3 : IN std_logic_vector(N - 1 DOWNTO 0);
        F4 : IN std_logic_vector(N - 1 DOWNTO 0);
        sel : IN std_logic_vector(1 DOWNTO 0);
        F : OUT std_logic_vector(N - 1 DOWNTO 0)
    );
END mux4x1;

ARCHITECTURE arch OF mux4x1 IS
BEGIN
   --uso da estrutura de seleção condicional when else
    F <= F1 WHEN sel = "00" ELSE 
         F2 WHEN sel = "01" ELSE
         F3 WHEN sel = "10" ELSE 
         F4;
END arch;

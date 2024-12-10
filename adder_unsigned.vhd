LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder_unsigned IS 
    GENERIC (width : INTEGER);
    PORT (
        A, B : IN unsigned(width - 1 DOWNTO 0);
        result : OUT std_logic_vector(width - 1 DOWNTO 0)
    );
END adder_unsigned;

ARCHITECTURE arch OF adder_unsigned IS
    SIGNAL sum : unsigned(width DOWNTO 0);
BEGIN
    sum <= resize(A, width + 1) + resize(B, width + 1);
    result <= std_logic_vector(sum(width - 1 DOWNTO 0)); --desconsidera Cout do resultado da soma
END arch;

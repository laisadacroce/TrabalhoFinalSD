LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY adder IS
    GENERIC (width : POSITIVE;
			is_unsigned: BOOLEAN
	 );
    PORT (
        A, B : IN std_logic_vector(width - 1 DOWNTO 0);
        result : OUT std_logic_vector(width DOWNTO 0)
    );
END adder;

ARCHITECTURE Behavioral OF adder IS
    SIGNAL signed_sum : signed(width DOWNTO 0);
    SIGNAL unsigned_sum : unsigned(width DOWNTO 0);
BEGIN
    unsigned_adder: if (is_unsigned) generate
        unsigned_sum <= resize(unsigned(A), width + 1) + resize(unsigned(B), width + 1);
        result <= std_logic_vector(unsigned_sum);
    end generate;

    signed_adder: if (not is_unsigned) generate
        signed_sum <= resize(signed(A), width + 1) + resize(signed(B), width + 1);
        result <= std_logic_vector(signed_sum);
    end generate;

END Behavioral;

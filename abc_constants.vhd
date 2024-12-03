LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY abc_constants IS
	PORT (
		H_value, V_value : IN STD_LOGIC_VECTOR(14 DOWNTO 0);
		H_byte15, V_byte15 : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		a : OUT STD_LOGIC_VECTOR(13 DOWNTO 0);
		b, c : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE Behavioral OF abc_constants IS
	SIGNAL auxiliar_a : STD_LOGIC_VECTOR(12 DOWNTO 0);
	SIGNAL auxiliar_b, auxiliar_c : STD_LOGIC_VECTOR(16 DOWNTO 0);
BEGIN

	auxiliar_b <= STD_LOGIC_VECTOR(signed(H_value & "00") + resize(signed(H_value), 17) + to_signed(32, 17));
	b <= auxiliar_b(16 DOWNTO 6);

	auxiliar_c <= STD_LOGIC_VECTOR(signed(V_value & "00") + resize(signed(V_value), 17) + to_signed(32, 17));
	c <= auxiliar_c(16 DOWNTO 6);

	auxiliar_a <= STD_LOGIC_VECTOR(resize(unsigned(H_byte15), 9) + resize(unsigned(V_byte15), 9)) & "0000"; -- (H_byte15 + V_byte15) * 16
	a <= '0' & auxiliar_a; -- 0 concatenated to represent a positive number in 2's complement

END Behavioral;
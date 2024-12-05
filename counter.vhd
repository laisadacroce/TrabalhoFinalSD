LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY counter IS
	GENERIC (
		width : POSITIVE
	);
	PORT (
		clk, zi, ci, rst : IN STD_LOGIC;
		adder_in : IN STD_LOGIC_VECTOR(width - 1 DOWNTO 0);
		less : OUT STD_LOGIC;
		address : OUT STD_LOGIC_VECTOR(width - 2 DOWNTO 0)
	);
END counter;

ARCHITECTURE Behavioral OF counter IS
	SIGNAL regOut: STD_LOGIC_VECTOR(width - 1 DOWNTO 0);

BEGIN
	accumulator : ENTITY work.accumulator
		GENERIC MAP(width, 0) --valor inicial igual a 0
		PORT MAP(clk, rst, ci, zi, adder_in, regOut);

	-- Splitter logic and status signal --
	less <= NOT regOut(width - 1);
	address <= regOut(width - 2 DOWNTO 0);
	------------------------------------
	
END Behavioral;

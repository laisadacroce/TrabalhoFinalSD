LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY accumulator IS
	GENERIC (width : POSITIVE;
		initial_value : INTEGER);
	PORT (
		clk, rst, enable, sel_mux : IN STD_LOGIC; --entradas dos registradores e seletor do mux
		adder_in : IN STD_LOGIC_VECTOR(width - 1 DOWNTO 0); --entrada do acumulador
		result : OUT STD_LOGIC_VECTOR(width - 1 DOWNTO 0) --saída do acumulador
	);
END accumulator;

ARCHITECTURE arch OF accumulator IS
	SIGNAL mux_out : STD_LOGIC_VECTOR(width - 1 DOWNTO 0); -- saída do multiplexador
	SIGNAL reg_in : STD_LOGIC_VECTOR(width - 1 DOWNTO 0); -- entrada do registrador
	SIGNAL reg_out : STD_LOGIC_VECTOR(width - 1 DOWNTO 0); -- saída do registrador
	SIGNAL adder_out : STD_LOGIC_VECTOR(width - 1 DOWNTO 0); -- saída do somador
	CONSTANT unsigned_initial_value : STD_LOGIC_VECTOR(width - 1 DOWNTO 0) := STD_LOGIC_VECTOR(to_unsigned(initial_value, width));

BEGIN
	MUX : ENTITY work.mux2_1
		GENERIC MAP(width => width)
		PORT MAP(adder_out, unsigned_initial_value, sel_mux, mux_out);

	REG : ENTITY work.reg
		GENERIC MAP(width => width)
		PORT MAP(clk, enable, rst, mux_out, reg_out);

	ADDER : ENTITY work.adder_unsigned
		GENERIC MAP(width => width)
		PORT MAP(unsigned(adder_in), unsigned(reg_out), adder_out);

	result <= reg_out;

END arch;

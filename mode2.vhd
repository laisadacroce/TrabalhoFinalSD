LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

ENTITY mode2 IS
	GENERIC (
		width : POSITIVE;
		b : POSITIVE
	);
	PORT (
		clk, csample, cdc, cacc, sel_acc, reset : IN STD_LOGIC;
		sample : IN STD_LOGIC_VECTOR(width * b - 1 DOWNTO 0);
		dc : OUT STD_LOGIC_VECTOR(b - 1 DOWNTO 0)
	);
END mode2;

ARCHITECTURE arch OF mode2 IS
	SIGNAL reg_sample_out : STD_LOGIC_VECTOR(width * b - 1 DOWNTO 0);
	SIGNAL adder_tree_out : STD_LOGIC_VECTOR(b + POSITIVE(ceil(log2(width))) - 1 DOWNTO 0);
	SIGNAL acc_in, acc_out : STD_LOGIC_VECTOR(b + POSITIVE(ceil(log2(width))) DOWNTO 0);
	SIGNAL reg_dc_in : STD_LOGIC_VECTOR(b - 1 DOWNTO 0);

BEGIN
	REG_SAMPLE : ENTITY work.reg
		GENERIC MAP(width => width * b)
		PORT MAP(clk, csample, reset, sample, reg_sample_out);

	REG_DC : ENTITY work.reg
		GENERIC MAP(width => b)
		PORT MAP(clk, cdc, reset, reg_dc_in, dc);

	ACC : ENTITY work.accumulator
		GENERIC MAP(width => b + POSITIVE(ceil(log2(width))) + 1)
		PORT MAP(clk, reset, cacc, sel_acc, acc_in, acc_out);

	ADDERTREE : ENTITY work.adder_tree
		GENERIC MAP(
			B => b,
			P => width,
			is_unsigned => true)
		PORT MAP(sample, adder_tree_out);

	reg_dc_in <= acc_out(b + POSITIVE(ceil(log2(width))) DOWNTO POSITIVE(ceil(log2(width)))) --Divisão por 32 (desloca 5 bits para a direita)

	END arch;

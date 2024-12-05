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
		clk, cm2, cdc, cacc, sel_acc, reset : IN STD_LOGIC;
		sample : IN STD_LOGIC_VECTOR(width * b - 1 DOWNTO 0);
		dc : OUT STD_LOGIC_VECTOR(b - 1 DOWNTO 0)
	);
END mode2;

ARCHITECTURE arch OF mode2 IS
	SIGNAL m2_reg_out : STD_LOGIC_VECTOR(width * b - 1 DOWNTO 0);
	SIGNAL adder_tree_out : STD_LOGIC_VECTOR(b + POSITIVE(ceil(log2(width))) - 1 DOWNTO 0);
	SIGNAL acc_in, acc_out : STD_LOGIC_VECTOR(b + POSITIVE(ceil(log2(width))) DOWNTO 0);
	SIGNAL dc_reg_in : STD_LOGIC_VECTOR(b - 1 DOWNTO 0);

BEGIN
	M2_REG : ENTITY work.reg
		GENERIC MAP(width => width * b)
		PORT MAP(clk, cm2, reset, sample, m2_reg_out);

	DC_REG : ENTITY work.reg
		GENERIC MAP(width => b)
		PORT MAP(clk, cdc, reset, dc_reg_in, dc);

	ACC : ENTITY work.accumulator
		GENERIC MAP(width => b + POSITIVE(ceil(log2(width))) + 1)
		PORT MAP(clk, reset, cacc, sel_acc, acc_in, acc_out);

	ADDERTREE : ENTITY work.adder_tree
		GENERIC MAP(
			B => b,
			P => width,
			is_unsigned => true)
		PORT MAP(sample, adder_tree_out);

	dc_reg_in <= acc_out(b + POSITIVE(ceil(log2(width))) DOWNTO POSITIVE(ceil(log2(width)))); --Divisão por 32 (desloca 5 bits para a direita)

	END arch;

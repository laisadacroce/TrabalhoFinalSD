LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.math_real.ALL;
USE ieee.numeric_std.ALL;

ENTITY mode2 IS
	PORT (
		clk, sel_sample, csamples2, sel_acc, cacc, cdc : IN STD_LOGIC;
		sample0, sample1 : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
		dc : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END mode2;

ARCHITECTURE Behavioral OF mode2 IS
	SIGNAL muxOut, samples_reg2Out: std_logic_vector(127 DOWNTO 0);
	SIGNAL adder_treeOut: std_logic_vector(11 DOWNTO 0);
	SIGNAL accumulatorOut: std_logic_vector(12 DOWNTO 0);
BEGIN

	mux: entity work.mux2_1
	generic map(128)
	port map(sample0, sample1, sel_sample, muxOut);

	samples2_reg: entity work.reg
	generic map(128)
	port map(clk, csamples2, '0', muxOut, samples_reg2Out);

	adder_tree: entity work.adder_tree
	generic map(8, 16, true)
	port map(samples_reg2Out, adder_treeOut);

	accumulator: entity work.accumulator
	generic map(13, 16)
	port map(clk, cacc, sel_acc, '0' & adder_treeOut, accumulatorOut);

	dc_reg: entity work.reg
	generic map(8)
	port map(clk, cdc, '0', accumulatorOut(12 downto 5), dc);


END Behavioral;

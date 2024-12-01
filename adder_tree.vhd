LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY adder_tree IS
	GENERIC (
		B : POSITIVE;
		P : POSITIVE
	);

	PORT (
		input_vector : IN STD_LOGIC_VECTOR(B * P - 1 DOWNTO 0);
		is_unsigned: IN BOOLEAN;
		result : OUT STD_LOGIC_VECTOR((B + INTEGER(log2(real(P)))) - 1 DOWNTO 0)
	);
END adder_tree;

ARCHITECTURE Behavioral OF adder_tree IS
	CONSTANT width : POSITIVE := B * P;
	SIGNAL left_tree_result, right_tree_result : STD_LOGIC_VECTOR(B + INTEGER(log2(real(P)/real(2))) - 1 DOWNTO 0);


BEGIN
	general_case : IF (P > 2) GENERATE
		left_tree : ENTITY work.adder_tree
			GENERIC MAP(B, P/2)
			PORT MAP(input_vector(width - 1 DOWNTO width/2), left_tree_result);

		right_tree : ENTITY work.adder_tree
			GENERIC MAP(B, P/2)
			PORT MAP(input_vector(width/2 - 1 DOWNTO 0), right_tree_result);
		
		at_adder: entity work.at_adder
			generic map(left_tree_result'length)
			port map(left_tree_result, right_tree_result, is_unsigned, result);

	END GENERATE;

	base_case : IF P = 2 GENERATE
		
		at_adder: entity work.at_adder
			generic map(width/2)
			port map(input_vector(width - 1 DOWNTO width/2), input_vector(width/2 - 1 DOWNTO 0), is_unsigned, result);
			
	END GENERATE;

	pass_case : IF P = 1 GENERATE
		result <= input_vector;
	END GENERATE;

END Behavioral;
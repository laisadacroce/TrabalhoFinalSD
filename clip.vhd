LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE ieee.math_real.ALL;

ENTITY clip IS
	PORT (
		input : IN STD_LOGIC_VECTOR(10 DOWNTO 0); --in
		output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) --out
	);
END clip;

ARCHITECTURE arch OF clip IS
	SIGNAL sel_mux2, or_indexes_8_9 : STD_LOGIC; --envolvem manipulação do vetor input
	SIGNAL mux2_in0 : STD_LOGIC_VECTOR(7 DOWNTO 0); --conexões internas entre os módulos
BEGIN

	or_indexes_8_9 <= input(8) OR input(9);

	--se algum dos bits mais significativos, exceto o bit de sinal, for igual a 1, o número excede 255, 
	--então retorna 255 para manter no intervalo; senão, retorna os 8 bits menos significativos de input
	MUX1 : ENTITY work.mux2_1
		GENERIC MAP(width => 8)
		PORT MAP(input(7 DOWNTO 0), "11111111", or_indexes_8_9, mux2_in0);

	--se o seletor de mux2 for igual a 1, o número é negativo, então retorna 0; senão, retorna o valor positivo
	MUX2 : ENTITY work.mux2_1
		GENERIC MAP(width => 8)
		PORT MAP(mux2_in0, "00000000", input(10), output);

END arch;

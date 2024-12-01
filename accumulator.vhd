library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity accumulator is
generic (width : positive);
port(
	clk, rst, enable, sel_mux: in std_logic; --entradas dos registradores e seletor do mux
	adder_in: in std_logic_vector(width-1 downto 0); --entrada do acumulador
	result: out std_logic_vector(width-1 downto 0) --saída do acumulador
);
end accumulator;

architecture arch of accumulator is
  signal mux_in0: std_logic_vector(width-1 downto 0); -- entrada do multiplexador quando seletor é 0
  signal mux_out: std_logic_vector(width-1 downto 0); -- saída do multiplexador
  signal reg_in: std_logic_vector(width-1 downto 0); -- entrada do registrador
  signal reg_out: std_logic_vector(width-1 downto 0); -- saída do registrador
  signal adder_out: std_logic_vector(width-1 downto 0); -- saída do somador

begin
	MUX : entity work.mux2_1
		generic map (width => width)
		port map(adder_out, (others => '0'), sel_mux, mux_out);

	REG: entity work.reg
		generic map (width => width)
		port map(clk, enable, rst, mux_out, reg_out); 

	ADDER: entity work.adder_unsigned
		generic map (width => width)
		port map(unsigned(adder_in), unsigned(reg_out), adder_out);

	result <= reg_out; 

end arch;

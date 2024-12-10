library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity testbench is
end testbench;

architecture tb of testbench is

  signal H_value, V_value : std_logic_vector(14 downto 0);
  signal H_byte15, V_byte15 : std_logic_vector(7 downto 0);
  signal a : std_logic_vector(13 downto 0);
  signal b, c : std_logic_vector(10 downto 0);

  constant passo : time := 20 ns;

begin

  DUV: entity work.abc_constants
    port map (
      H_value => H_value,
      V_value => V_value,
      H_byte15 => H_byte15,
      V_byte15 => V_byte15,
      a => a,
      b => b,
      c => c
    );

  stim_proc: process
    file stimulus_file : text open read_mode is "estimulos_abd.dat";
    variable line_data : line;
    variable H_val, V_val : bit_vector(14 downto 0);
    variable H_byte, V_byte : bit_vector(7 downto 0);
    variable expected_a : bit_vector(13 downto 0);
    variable expected_b, expected_c : bit_vector(10 downto 0);
    variable delimiter : character;
  begin
    while not endfile(stimulus_file) loop
      readline(stimulus_file, line_data);
      read(line_data, H_val);
      read(line_data, delimiter);
      read(line_data, V_val);
      read(line_data, delimiter);
      read(line_data, H_byte);
      read(line_data, delimiter);
      read(line_data, V_byte);
      read(line_data, delimiter);
      read(line_data, expected_a);
      read(line_data, delimiter);
      read(line_data, expected_b);
      read(line_data, delimiter);
      read(line_data, expected_c);

      H_value <= to_stdlogicvector(H_val);
      V_value <= to_stdlogicvector(V_val);
      H_byte15 <= to_stdlogicvector(H_byte);
      V_byte15 <= to_stdlogicvector(V_byte);

      wait for passo;

      -- Check results
      assert (a = to_stdlogicvector(expected_a) and
              b = to_stdlogicvector(expected_b) and
              c = to_stdlogicvector(expected_c))
        report "Falha nas saídas." severity error;
    end loop;

    -- Indicate simulation end
    report "Fim dos testes." severity note;
    wait;
  end process;

end tb;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity testbench_H_V_constants is
end testbench_H_V_constants;

architecture tb of testbench_H_V_constants is

  signal H_V_vector : std_logic_vector(135 downto 0);
  signal H_V_value  : std_logic_vector(14 downto 0);

  constant step_time : time := 20 ns;

begin

  DUV: entity work.H_V_constants
    port map (
      H_V_vector => H_V_vector,
      H_V_value  => H_V_value
    );

  stim_proc: process
    file stimulus_file : text open read_mode is "../../estimulosHV.dat";
    variable line_content : line;
    variable input_vector : bit_vector(135 downto 0);
    variable expected_value : bit_vector(14 downto 0);
    variable separator : character;
  begin
    while not endfile(stimulus_file) loop
      readline(stimulus_file, line_content);
      read(line_content, input_vector);
      H_V_vector <= to_stdlogicvector(input_vector);

      read(line_content, separator);
      read(line_content, expected_value);

      wait for step_time;

      assert H_V_value = to_stdlogicvector(expected_value)
        report "Falha na saída. Input: " & std_logic_vector(input_vector) &
               " | Esperado: " & std_logic_vector(expected_value) &
               " | Recebido: " & H_V_value
        severity error;
    end loop;

    wait for step_time;
    assert false report "Fim dos testes." severity note;
    wait;
  end process;

end tb;

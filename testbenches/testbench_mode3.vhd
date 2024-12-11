library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity testbench_mode3 is
end testbench_mode3;

architecture tb of testbench_mode3 is

  signal x, y : std_logic_vector(3 downto 0);
  signal a : std_logic_vector(13 downto 0);
  signal b, c : std_logic_vector(10 downto 0);
  signal plane : std_logic_vector(7 downto 0);

  constant passo : time := 20 ns;

begin

  DUV: entity work.mode3
    port map (
      x => x,
      y => y,
      a => a,
      b => b,
      c => c,
      plane => plane
    );

  stim_proc: process
    file stimulus_file : text open read_mode is "estimulos_mode3.dat";
    variable line_content : line;
    variable input_x, input_y : bit_vector(3 downto 0);
    variable input_a : bit_vector(13 downto 0);
    variable input_b, input_c : bit_vector(10 downto 0);
    variable expected_plane : bit_vector(7 downto 0);
    variable separator : character;
  begin
    while not endfile(stimulus_file) loop
      readline(stimulus_file, line_content);

      read(line_content, separator);
      read(line_content, input_a);
      a <= to_stdlogicvector(input_a);

      read(line_content, separator);
      read(line_content, input_b);
      b <= to_stdlogicvector(input_b);

      read(line_content, separator);
      read(line_content, input_c);
      c <= to_stdlogicvector(input_c);

      read(line_content, input_x);
      x <= to_stdlogicvector(input_x);

      read(line_content, separator);
      read(line_content, input_y);
      y <= to_stdlogicvector(input_y);

      read(line_content, separator);
      read(line_content, expected_plane);

      wait for passo;

      assert plane = to_stdlogicvector(expected_plane)
        report "Falha na simulaçao: Inputs: x=" & std_logic_vector(input_x) &
               " y=" & std_logic_vector(input_y) &
               " a=" & std_logic_vector(input_a) &
               " b=" & std_logic_vector(input_b) &
               " c=" & std_logic_vector(input_c) &
               " | Esperado: " & std_logic_vector(expected_plane) &
               " | Recebido: " & plane
        severity error;
    end loop;

    wait for passo;
    assert false report "Fim dos testes." severity note;
    wait;
  end process;

end tb;

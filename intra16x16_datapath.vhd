LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY intra16x16_datapath IS
  PORT (
    -- Clock
    clk: in std_logic;
    -- Samples input
    V_sample, H_sample: in std_logic_vector(127 downto 0);
    corner_sample: in std_logic_vector(7 downto 0);

    -- Command signals for counter
    sel_i, ci: in std_logic;
    -- Command signals for mode2
    sel_sample, csamples2, sel_acc, cacc, cdc: in std_logic;
    -- Command signals for mode3
    csamples, chv, cabcy: in std_logic;
    -- Common command signals
    sel_mode: in std_logic_vector(1 downto 0);
    cmode, cline: in std_logic;
    line_index: out std_logic_vector(3 downto 0);
    less: out std_logic;
    -- Output
    line: out std_logic_vector(127 DOWNTO 0)
  );

END intra16x16_datapath;

ARCHITECTURE Behavioral OF intra16x16_datapath IS
  CONSTANT x_values: std_logic_vector(63 downto 0) := "0000000100100011010001010110011110001001101010111100110111101111";
  SIGNAL samples_regOut: std_logic_vector(263 downto 0);
  SIGNAL V_value, H_value, V_value_regOut, H_value_regOut: std_logic_vector(14 DOWNTO 0);
  SIGNAL a: std_logic_vector(13 downto 0);
  SIGNAL b, c: std_logic_vector(10 downto 0);
  SIGNAL counterOut: std_logic_vector(4 downto 0);
  SIGNAL y: std_logic_vector(3 downto 0);
  SIGNAL dc: std_logic_vector(7 downto 0);
  SIGNAL abcy_vector: std_logic_vector(39 downto 0);
  SIGNAL plane_line, dc_line, mode_muxOut, mode_regOut: std_logic_vector(127 downto 0);
begin

-- MODE 2 : DC Prediction --------------------------------------------------------------
  mode2: entity work.mode2
  port map(clk, sel_sample, csamples2, sel_acc, cacc, cdc, V_sample, H_sample, dc);
  
  -- Concatenating dc 16 times
  process (dc)
        variable temp_vec : std_logic_vector(127 downto 0); 
    begin
        temp_vec := (others => '0'); 
        for i in 0 to 15 loop
            temp_vec((i+1)*8-1 downto i*8) := dc;
        end loop;
        dc_line <= temp_vec;
  end process;

-- COUNTER -----------------------------------------------------------------------------
  counter: ENTITY work.accumulator
  GENERIC MAP(5, 0)
  PORT MAP(clk, ci, sel_i, "00001", counterOut);

  less <= NOT counterOut(4);
  y <= counterOut(3 DOWNTO 0);

-- MODE 3 : Plane Prediction -----------------------------------------------------------
  samples_reg: entity work.reg
  generic map(264)
  port map(clk, csamples, '0', V_sample & H_sample & corner_sample, samples_regOut);

  V_constant: entity work.H_V_constants
  port map(samples_regOut(7 DOWNTO 0) & samples_regOut(263 DOWNTO 136), V_value);

  H_constant: entity work.H_V_constants
  port map(samples_regOut(7 downto 0) & samples_regOut(135 DOWNTO 8), H_value);

  V_value_reg: entity work.reg
  generic map(15)
  port map(clk, chv, '0', V_value, V_value_regOut);

  H_value_reg: entity work.reg
  generic map(15)
  port map(clk, chv, '0', H_value, H_value_regOut);

  abc_constants: entity work.abc_constants
  port map(H_value_regOut, V_value_regOut, H_sample(7 DOWNTO 0), V_sample(7 DOWNTO 0), a, b, c);

  abcy_reg: entity work.reg
  generic map(40)
  port map(clk, cabcy, '0', a & b & c & y, abcy_vector);
  
  generate_plane_line: for i in 0 to 15 generate

    plane_byte: entity work.mode3
    port map(x_values(63 - 4*i DOWNTO 64 - 4*(i+1)), -- x(i)
    abcy_vector(3 DOWNTO 0),  -- y
    abcy_vector(39 DOWNTO 26),  -- a
    abcy_vector(25 DOWNTO 15),   -- b
    abcy_vector(14 DOWNTO 4),    -- c
    plane_line(127 - 8*i DOWNTO 128 - 8*(i + 1))); 

  end generate;
-----------------------------------------------------------------------------------------
  mode_mux: entity work.mux4_1
  generic map(128)
  port map(V_sample, H_sample, dc_line, plane_line, sel_mode, mode_muxOut);

  mode_reg: entity work.reg
  generic map(128)
  port map(clk, cmode, '0', mode_muxOut, mode_regOut);

  line_reg: entity work.reg
  generic map(128)
  port map(clk, cline, '0', mode_regOut, line);

  line_index <= y;

END Behavioral;
    

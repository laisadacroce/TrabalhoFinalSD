LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity intra16x16prediction is
port(
    clk, reset, start: in std_logic;
    mode: in std_logic_vector(1 downto 0);
    V_sample, H_sample: in std_logic_vector(127 DOWNTO 0);
    corner_sample: in std_logic_vector(7 DOWNTO 0);
    line_index: out std_logic_vector(3 downto 0);
    line: out std_logic_vector(127 downto 0);
    done: out std_logic
);
end intra16x16prediction;

architecture Behavioral of intra16x16prediction is
    -- Command signals
    SIGNAL sel_i, ci, csamples, chv, sel_sample, csamples2, sel_acc, cacc, cdc, cabcy, cmode, cline: std_logic;
    SIGNAL sel_mode: std_logic_vector(1 downto 0);
    -- Status signal
    signal less: std_logic;
begin

    controller: entity work.intra16x16_controller
    port map(clk, reset, start, less, mode, done, sel_i, ci, csamples, chv,
    sel_sample, csamples2, sel_acc, cacc, cdc, cabcy, cmode, cline, sel_mode
    );

    datapath: entity work.intra16x16_datapath
    port map(clk, V_sample, H_sample, corner_sample, sel_i, ci, sel_sample, csamples2,
    sel_acc, cacc, cdc, csamples, chv, cabcy, sel_mode, cmode, cline, line_index, less, line 
    );

end Behavioral;
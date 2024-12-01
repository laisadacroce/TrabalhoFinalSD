LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY H_V_constants IS
    PORT (
        H_V_vector: in std_logic_vector(135 downto 0); -- length = 17 * 8
        H_V_value: out std_logic_vector(14 downto 0) -- 2's complement number typed as std_logic_vector
    );
END H_V_constants;

ARCHITECTURE Behavioral OF H_V_constants IS
    signal subtractions_result: std_logic_vector(71 DOWNTO 0);
    signal multiplications_result: std_logic_vector(95 downto 0); -- length = 96 = 12*8
begin

    multiplications: for i in 0 to 7 generate
        subtractor : entity work.subtractor
        generic map(8)
        port map(H_V_vector(63 - 8*i DOWNTO 64 - 8*(i+1)), H_V_vector(79 + 8*i DOWNTO 80 + 8*(i-1)), subtractions_result(71 - 9*i DOWNTO 72 - 9*(i+1)));


        multiplications_result(95 - 12 * i DOWNTO 96 - 12 *(i + 1)) <= std_logic_vector(resize(to_signed(i + 1, 4) * signed(subtractions_result(71 - 9*i DOWNTO 72 - 9*(i+1))), 12));

    end generate;

    adder_tree: entity work.adder_tree
    generic map(12, 8 , false)
    port map(multiplications_result, H_V_value);

END Behavioral;
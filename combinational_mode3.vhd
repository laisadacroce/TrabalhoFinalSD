LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity combinational_mode3 is
port(
    x, y: in std_logic_vector(3 downto 0); -- unsigned integers
    a: in std_logic_vector(13 downto 0); -- signed integer
    b, c: in std_logic_vector(10 downto 0); -- signed integer
    plane: out std_logic_vector(7 downto 0) -- unsigned integer

);
end combinational_mode3;

architecture Behavioral of combinational_mode3 is
    SIGNAL subtractorsIn: std_logic_vector(7 downto 0);
    SIGNAL subtractorsOut: std_logic_vector(9 downto 0);
    SIGNAL multiplicationsIn: std_logic_vector(21 downto 0);
    SIGNAL multiplications_result: std_logic_vector(27 downto 0);
    SIGNAL adder_treeOut: std_logic_vector(15 downto 0);

begin

    sub_mult: for i in 0 to 1 generate

        mux_xy: entity work.mux2_1
        generic map(4)
        port map(x, y, i, subtractorsIn(7 - 4*i downto 8 - 4*(i+1)));


        unsigned_subtractor: entity work.subtractor
        generic map(4)
        port map(subtractorsIn(7 - 4*i downto 8 - 4*(i+1)), "0111", subtractorsOut(9 - 5*i downto 10 - 5*(i+1)));
    
        mux_bc: entity work.mux2_1
        generic map(11)
        port map(b, c, i, multiplicationsIn(21 - 11 * i downto 22 - 11*(i + 1)));
        
        multiplications_result(27 - 14*i downto 28 - 14*(i+1)) <= std_logic_vector(resize(signed(subtractorsOut(9 - 5*i downto 10 - 5*(i+1))) * signed(multiplicationsIn(21 - 11 * i downto 22 - 11*(i + 1))), 14));

    end generate;

        adder_tree: entity work.adder_tree
        generic map(14, 4)
        port map(a & multiplications_result & std_logic_vector(to_signed(16, 14)), adder_treeOut);

        clip: entity work.clip
        port map(adder_treeOut(15 downto 5), plane);

end Behavioral;

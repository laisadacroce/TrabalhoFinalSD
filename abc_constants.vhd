LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity abc_constants is
port(H_value, V_value: in std_logic_vector(14 downto 0);
    H_byte15, V_byte15: in std_logic_vector(7 downto 0);
    a: out std_logic_vector(13 downto 0);
    b, c: out std_logic_vector(10 DOWNTO 0)
);
end entity;

architecture Behavioral of abc_constants is
    SIGNAL auxiliar_a: std_logic_vector(12 downto 0);
    SIGNAL auxiliar_b, auxiliar_c: std_logic_vector(16 downto 0);
begin

    auxiliar_b <= std_logic_vector(signed(H_value & "00") + resize(signed(H_value), 17) + resize(signed("0100000"), 17));
    b <= auxiliar_b(16 downto 6);

    auxiliar_c <= std_logic_vector(signed(V_value & "00") + resize(signed(V_value), 17) + resize(signed("0100000"), 17));
    c <= auxiliar_c(16 downto 6);

    auxiliar_a <= std_logic_vector(resize(unsigned(H_byte15), 9) + resize(unsigned(V_byte15), 9)) & "0000"; -- (H_byte15 + V_byte15) * 16
    a <= '0' & auxiliar_a; -- 0 concatenated to represent a positive number in 2's complement

end Behavioral;
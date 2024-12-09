-- MODULO INCOMPLETO!!
--> Verificar como vai ser feita a entrada na entidade (primeiro H depois V (?)) e arrumar os tempos de espera

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;
use IEEE.std_logic_textio.all;
use std.textio.all;

entity testbench is
end testbench;

architecture tb of testbench is

    signals clk, cm2, cdc, cacc, sel_acc, reset: std_logic;
    signal sample: std_logic_vector(255 downto 0);
    signal dc: std_logic_vector(7 downto 0);

    constant passo : time := 20 ns; --Mudar de acordo com o atraso critico

begin
    DUT: entity work.modo2
        port map(
            clk, cm2, cdc, cacc, sel_acc, reset, sample, dc
        );

    process
    begin

        -- Os valores de teste foram gerados aleatoriamente com o golden model
        -- CORRIGIR OS TEMPOS DE ESPERA

        -- Teste 1
        wait for passo;
        sample <= std_logic_vector(to_unsigned(0010100110111000111100111000000001110011001100001000011100111011111000001000110001011001101111110011110110010001001101001000110011000101111000011010100100001101111010101011110111001111011111110011101100111000100000100010010101000110101011001101010000110010));
        wait for 10*passo;
        assert(sample="10000001")
        report "Falha no teste 1" severity error; 

        -- Teste 2
        wait for passo;
        sample <= std_logic_vector(to_unsigned(1101101110010110000110110100110110011000111000000111100101101011100110110100101000111011011000011110110000010010101101001001000101111001001100010101111100111111110000011000111001100111000010011101001110100111000000010001000010101000000001100111001011011000));
        wait for 10*passo;
        assert(sample="01110100")
        report "Falha no teste 2" severity error;

        -- Teste 3
        wait for passo;
        sample <= std_logic_vector(to_unsigned(1001011100001100111011110110110100101100001011010001111111010010001101111001100011111111001000010010100101100010001010111111101010110101011011001100111111001000100101110111011111001101000001000101111010000011100110100011010101111111011110101011111101110000));
        wait for 10*passo;
        assert(sample="01111010")
        report "Falha no teste 3" severity error;

        --
        wait for passo;
        assert false report "Passou!" severity note;

    end process;
end tb;

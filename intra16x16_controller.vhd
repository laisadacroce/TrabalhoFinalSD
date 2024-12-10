LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY intra16x16_controller IS
  PORT (
    clk, reset: in std_logic;
    -- Next State Logic
    start, less: in std_logic;
    mode: in std_logic_vector(1 downto 0);
    -- Status and output signals
    done, sel_i, ci, csamples, chv, sel_sample, csamples2, sel_acc, cacc, cdc, cabcy, cmode, cline: out std_logic;
    sel_mode: out std_logic_vector(1 downto 0)
  );

END intra16x16_controller;

ARCHITECTURE Behavioral OF intra16x16_controller IS
TYPE type_state IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17);
	SIGNAL CurrentState, NextState : type_state;
BEGIN
	PROCESS (clk, reset)
	BEGIN
		IF reset = '1' THEN
			CurrentState <= S0;
		ELSIF (rising_edge(clk)) THEN
			CurrentState <= NextState;
		END IF;
	END PROCESS;

	PROCESS (CurrentState, start, less, mode)
	BEGIN
		CASE CurrentState IS
            WHEN S0 => 

                done <= '1'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0'; 
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                IF start = '1' THEN
                    NextState <= S1;
                ELSE
                    NextState <= S0;
                END IF;
            
            WHEN S1 =>

                done <= '0'; sel_i <= '1'; ci <= '1'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                IF mode = "11" then
                    NextState <= S8;
                ELSIF mode = "10" then
                    NextState <= S2;
                else
                    NextState <= S10;
                end if;

            WHEN S2 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '1'; cacc <= '1'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                NextState <= S3;
            
            WHEN S3 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '0'; csamples2 <= '1';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                NextState <= S4;

            WHEN S4 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '0'; cacc <= '1'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0';  cline <= '0';

                NextState <= S5;

            WHEN S5 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '1'; csamples2 <= '1';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                NextState <= S6;

            WHEN S6 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '0'; cacc <= '1'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                NextState <= S7;

            WHEN S7 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '1'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                NextState <= S10;

            WHEN S8 => 

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '1'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                NextState <= S9;

            WHEN S9 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '1'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                NextState <= S10;

            WHEN S10 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';

                IF less = '1' then
                    NextState <= S11;
                else
                    NextState <= S0;
                end if;
            
            WHEN S11 => 

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '0';
                
                if mode = "00" then
                    NextState <= S12;
                ELSIF mode = "01" then
                    NextState <= S13;
                ELSIF mode = "10" then
                    NextState <= S14;
                ELSE
                    NextState <= S15;
                END if;

            WHEN S12 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "00"; cabcy <= '0'; cmode <= '1'; cline <= '0';

                NextState <= S17;

            WHEN S13 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "01"; cabcy <= '0'; cmode <= '1'; cline <= '0';

                NextState <= S17;

            WHEN S14 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "10"; cabcy <= '0'; cmode <= '1'; cline <= '0';

                NextState <= S17;

            WHEN S15 =>
                
                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '1'; cmode <= '0'; cline <= '0';

                NextState <= S16;

            WHEN S16 =>

                done <= '0'; sel_i <= '-'; ci <= '0'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "11"; cabcy <= '0'; cmode <= '1'; cline <= '0';

                NextState <= S17;

            WHEN S17 =>

                done <= '0'; sel_i <= '0'; ci <= '1'; csamples <= '0'; chv <= '0'; sel_sample <= '-'; csamples2 <= '0';
                sel_acc <= '-'; cacc <= '0'; cdc <= '0'; sel_mode <= "--"; cabcy <= '0'; cmode <= '0'; cline <= '1';

                NextState <= S10;

        END case;
    end process;


END Behavioral;

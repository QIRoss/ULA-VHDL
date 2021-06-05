LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decode_7seg IS 
    PORT (
    	inputNumbers : IN 	std_logic_vector (3 downto 0);
    	output7seg	 : OUT 	std_logic_vector (6 downto 0)
	);
END decode_7seg;

ARCHITECTURE behavioral OF  decode_7seg IS

BEGIN
	PROCESS (inputNumbers)
	
		VARIABLE aux: std_logic_vector (6 downto 0);
		
		BEGIN
			CASE inputNumbers IS
				WHEN "0000" => aux := "1000000";
				WHEN "0001" => aux := "1111001"; 
				WHEN "0010" => aux := "0100100";
				WHEN "0011" => aux := "0110000";
				WHEN "0100" => aux := "0011001"; 
				WHEN "0101" => aux := "0010010";
				WHEN "0110" => aux := "0000010";
				WHEN "0111" => aux := "1111000";
				WHEN "1000" => aux := "0000000";
				WHEN "1001" => aux := "0010000";
				WHEN "1010" => aux := "0001000";
				WHEN "1011" => aux := "0000011";
				WHEN "1100" => aux := "1000110";
				WHEN "1101" => aux := "0100001";
				WHEN "1110" => aux := "0000110";
				WHEN "1111" => aux := "0001110";
				WHEN OTHERS => aux := "1111111"; 
			END CASE;
			output7seg <= aux;
	END PROCESS;
END behavioral;
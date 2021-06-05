library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logics is
	Port ( 
	vectorA : in STD_LOGIC_VECTOR (3 downto 0);
	vectorB : in STD_LOGIC_VECTOR (3 downto 0);
	gateSelection : in STD_LOGIC_VECTOR (2 downto 0);
	vectorOut : inout STD_LOGIC_VECTOR (3 downto 0);
	zero : out STD_LOGIC
	);
end logics;

architecture Behavioral of logics is

begin

zero <= '1' when (vectorOut = "0000") else '0';

procGate: process(gateSelection,vectorA,vectorB)
begin

	if (gateSelection = "010") then vectorOut <= vectorA and vectorB;
	
	elsif (gateSelection = "011") then vectorOut <= vectorA or vectorB;

	elsif (gateSelection = "100") then vectorOut <= vectorA xor vectorB;
	
	elsif (gateSelection = "101") then vectorOut <= vectorA nor vectorB;
	
	elsif (gateSelection = "110") then vectorOut <= vectorA nand vectorB;
	
	elsif (gateSelection = "111") then vectorOut <= "ZZZZ";
	
	else vectorOut <= "0000";
	
	end if;
	
	end process procGate;
end Behavioral;
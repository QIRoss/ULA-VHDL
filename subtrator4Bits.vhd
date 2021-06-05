library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;
use ieee.std_logic_unsigned.all;

entity subtrator4Bits is

	Port ( 
		vectorA : in STD_LOGIC_VECTOR (3 downto 0);
		vectorB : in STD_LOGIC_VECTOR (3 downto 0);
		carryIn : in STD_LOGIC;
		carryOut : inout STD_LOGIC;
		vectorOut : inout STD_LOGIC_VECTOR (3 downto 0);
		overFlow : out STD_LOGIC;
		negative : out STD_LOGIC;
		zero : out STD_LOGIC
	);
	
end subtrator4Bits;

architecture Behavioral of subtrator4Bits is

signal interno : std_logic_vector(2 downto 0);

component somador1Bit
	Port ( A : in STD_LOGIC;
	B : in STD_LOGIC;
	Cin : in STD_LOGIC;
	Cout : out STD_LOGIC;
	Soma : out STD_LOGIC);
end component somador1Bit;

begin

	overflow <= (carryOut xor interno(2));
	
	zero <= '1' when (vectorOut = "0000") else '0';
	
	negative <= '1' when (vectorOut(3) = '1') else '0';
	
	subtrator0: somador1Bit PORT MAP ( vectorA(0), not vectorB(0), '1', interno(0),vectorOut(0));
	
	subtrator1: somador1Bit PORT MAP (
		vectorA(1),
		not vectorB(1),
		interno(0),
		interno(1),
		vectorOut(1)
	);
	
	subtrator2: somador1Bit PORT MAP (
		vectorA(2),
		not vectorB(2),
		interno(1),
		interno(2),
		vectorOut(2)
	);
	
	subtrator3: somador1Bit PORT MAP (
		vectorA(3),
		not vectorB(3),
		interno(2),
		carryOut,
		vectorOut(3)
	);
end Behavioral;
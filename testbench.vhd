library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.all;
use ieee.std_logic_unsigned.all;

entity testbench is
    port (
        CLOCK_50: in std_logic;
        LEDR: out std_logic_vector(17 downto 0);
        LEDG: out std_logic_vector(3 downto 0);
        SW: in std_logic_vector (9 downto 0);
        HEX0 : out std_logic_vector(6 downto 0);
        HEX1 : out std_logic_vector(6 downto 0);
        HEX3 : out std_logic_vector(6 downto 0)
    );
end testbench;

architecture behav of testbench is
    signal count : std_logic_vector(33 downto 0);
    signal outA, outB: STD_LOGIC_VECTOR(6 downto 0);
    signal output7seg: STD_LOGIC_VECTOR(6 downto 0);
    signal output: STD_LOGIC_VECTOR(3 downto 0);
    
    component ula is
    Port ( 
		ulaVectorA : inout STD_LOGIC_VECTOR (3 downto 0);
		ulaVectorB : inout STD_LOGIC_VECTOR (3 downto 0);
		ulaSelection : in STD_LOGIC_VECTOR (2 downto 0);
		ulaVectorOut : out STD_LOGIC_VECTOR (3 downto 0);
		cOutFlag : out STD_LOGIC;
		ulaOverFlow : out STD_LOGIC;
		negativeFlag : out STD_LOGIC;
		zeroFlag : out STD_LOGIC;
		ulaCarryIn : in STD_LOGIC
	);
	end component ula;
	
	component decode_7seg is
	PORT (
    	inputNumbers : in std_logic_vector (3 downto 0);
    	output7seg	 : OUT std_logic_vector (6 downto 0)
	);
	end component decode_7seg;
    
begin

    LEDR(8 downto 5) <= count(33 downto 30);
    LEDR(3 downto 0) <= count(29 downto 26);
    LEDR(17 downto 14) <= output;
    
    HEX0 <= outA;
    HEX1 <= outB;
    HEX3 <= output7seg;
    
    decodemapA: decode_7seg port map(count(33 downto 30), outA);
    decodemapB: decode_7seg port map(count(29 downto 26), outB);
    decodeOutput: decode_7seg port map(output,output7seg);
    
    ulamap: ula port map (count(33 downto 30), count(29 downto 26), SW(2 downto 0), output, LEDG(3), LEDG(2), LEDG(1), LEDG(0), SW(9) );

    process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            count <= count + 1;
        end if;
    end process;
end behav;

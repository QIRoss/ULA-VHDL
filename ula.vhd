library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula is
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
end ula;

architecture Behavioral of ula is

	signal saidaSoma, saidaSub, saidaLogic : STD_LOGIC_VECTOR (3 downto 0);
	signal carryOut_soma, carryOut_sub, carryOut_logic : STD_LOGIC;
	signal over_soma, over_sub, over_logic : STD_LOGIC;
	signal negat_soma, negat_sub, negat_logic : STD_LOGIC;
	signal zero_soma, zero_sub, zero_logic : STD_LOGIC;
	
component somador4Bits is
	Port ( 
		vectorA : in STD_LOGIC_VECTOR (3 downto 0);
		vectorB : in STD_LOGIC_VECTOR (3 downto 0);
		vectorOut : inout STD_LOGIC_VECTOR (3 downto 0);
		carryIn : in STD_LOGIC;
		carryOut : inout STD_LOGIC;
		overFlow : out STD_LOGIC;
		negative : out STD_LOGIC;
		zero : out STD_LOGIC
	);
end component somador4Bits;

component subtrator4Bits is
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
end component subtrator4Bits;

component logics is
	Port ( 
		vectorA : in STD_LOGIC_VECTOR (3 downto 0);
		vectorB : in STD_LOGIC_VECTOR (3 downto 0);
		gateSelection : in STD_LOGIC_VECTOR (2 downto 0);
		vectorOut : inout STD_LOGIC_VECTOR (3 downto 0);
		zero : out STD_LOGIC
	);
end component logics;

begin

	carryOut_logic <= '0';
	
	over_logic <= '0';
	
	negat_logic <= '0';
	
	SOMADOR: somador4Bits port map (ulaVectorA, ulaVectorB, saidaSoma, ulaCarryIn, carryOut_soma, over_soma, negat_soma, zero_soma);
	
	SUBTRATOR: Subtrator4Bits port map (ulaVectorA, ulaVectorB, ulaCarryIn, carryOut_sub, saidaSub, over_sub, negat_sub, zero_sub);
	
	LOGIC: logics port map (ulaVectorA, ulaVectorB, ulaSelection, saidaLogic, zero_logic);
	
	procSelection: process(ulaSelection,ulaVectorA,ulaVectorB,saidaSoma,saidaSub,saidaLogic,carryOut_soma,over_soma,
	negat_soma,zero_soma,carryOut_sub,over_sub,negat_sub,zero_sub,carryOut_logic,over_logic,negat_logic,zero_logic)
	begin
	
		if (ulaSelection = "000") then
		
		ulaVectorOut <= saidaSoma;
		cOutFlag <= carryOut_soma;
		ulaOverFlow <= over_soma;
		negativeFlag <= negat_soma;
		zeroFlag <= zero_soma;
		
		elsif (ulaSelection = "001") then
		
		ulaVectorOut <= saidaSub;
		cOutFlag <= carryOut_sub;
		ulaOverFlow <= over_sub;
		negativeFlag <= negat_sub;
		zeroFlag <= zero_sub;
		
		else
		
		ulaVectorOut <= saidaLogic;
		cOutFlag <= carryOut_logic;
		ulaOverFlow <= over_logic;
		negativeFlag <= negat_logic;
		zeroFlag <= zero_logic;
		
		end if;
		
	end process procSelection;
	
end Behavioral;
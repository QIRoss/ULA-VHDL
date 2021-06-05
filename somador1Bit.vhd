library ieee;
use ieee.std_logic_1164.all;

entity somador1Bit is
	port (	
		A,B, Cin : in std_logic;
		Soma, Cout: out std_logic
		);
end somador1Bit;

architecture dataflow of somador1Bit is

	signal x1, x2, x3, x4, y1 : std_logic;
	
begin

	x1 <= A and B;
	x2 <= A and Cin;
	x3 <= B and Cin;
	x4 <= x1 or x2;
	Cout <= x3 or x4;
	y1 <= A xor B;
	Soma <= y1 xor Cin;
	
end dataflow;
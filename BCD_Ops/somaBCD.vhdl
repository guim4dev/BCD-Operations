library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity somaBCD_1digito is
port (a,b      : in  std_logic_vector(3 downto 0);
		sum      : out std_logic_vector(3 downto 0);
		carryIN  : in  std_logic;
		carryOUT : out std_logic
);
end somaBCD_1digito;

architecture structure of somaBCD_1digito is
	signal sum_aux : std_logic_vector(4 downto 0);
	signal sum_6 : std_logic_vector(4 downto 0);
begin
	sum_aux <= ('0' & a) + ('0' & b) + ("0000" & carryIN); 
	sum_6 <= sum_aux + "00110";

	sum <= sum_6(3 downto 0) when sum_aux > 9 else sum_aux(3 downto 0);
	carryOUT <= '1' when sum_aux > 9 else '0';
end structure;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity somaBCD is
port (--a,b      : in  std_logic_vector(15 downto 0); --2 numeros de ate 4 algarismos (4*4 = 16bits)
		--sum      : out std_logic_vector(19 downto 0) --maior resultado possivel: 9999+9999 = 19.998 (5*4 = 20bits)
		a3,a2,a1,a0 : in  std_logic_vector(3 downto 0);
		b3,b2,b1,b0 : in  std_logic_vector(3 downto 0);
		sum4,sum3,sum2,sum1,sum0 : out std_logic_vector(3 downto 0)
);
end somaBCD;

architecture structure of somaBCD is
	
--	type BCDarray  is array (3 downto 0) of std_logic_vector(3 downto 0);
--
--	signal arrayA   : BCDarray := (a(15 downto 12),a(11 downto 8),a(7 downto 4),a(3 downto 0));
--	signal arrayB   : BCDarray := (b(15 downto 12),b(11 downto 8),b(7 downto 4),b(3 downto 0));
--	signal arraySUM : BCDarray;
	
	signal c_aux1,c_aux2,c_aux3,c_aux4 : std_logic; --cary's das somas parciais
	
	component somaBCD_1digito
		port (a,b      : in  std_logic_vector(3 downto 0);
				sum      : out std_logic_vector(3 downto 0);
				carryIN  : in  std_logic;
				carryOUT : out std_logic
		);
	end component;
	
	begin
	S0:somaBCD_1digito port map(a0, b0, sum0, '0', c_aux1);
	S1:somaBCD_1digito port map(a1, b1, sum1, c_aux1, c_aux2);
	S2:somaBCD_1digito port map(a2, b2, sum2, c_aux2, c_aux3);
	S3:somaBCD_1digito port map(a3, b3, sum3, c_aux3, c_aux4);
	
	sum4 <="000" & c_aux4;
	--sum <= ("000" & c_aux4) & arraySUM(3) & arraySUM(2) & arraySUM(1) & arraySUM(0);
end structure;

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
----use ieee.std_logic_unsigned.all; --so pra debugar
--
--entity somaBCD is
--port (a,b : in  unsigned(3 downto 0); --2 numeros de ate 4 algarismos (4*4 = 16bits)
--		sum : out unsigned(3 downto 0); --maior resultado possivel: 9999+9999 = 19.998 (5*4 = 20bits)
--		carry:out std_logic
--);
--end somaBCD;
--
--architecture structure of somaBCD is
--begin
--	
--	process(a,b)
--	
--		variable sum_temp : unsigned(4 downto 0);
--		begin
--			sum_temp := ('0' & a) + ('0' & b);
--			if sum_temp > 9 then
--				carry <= '1';
--				sum <= resize((sum_temp + "00110"),4);
--			else
--				carry <= '0';
--				sum <= sum_temp(3 downto 0);
--			end if;
--			
--	end process;
--end structure;

ENTITY testbench IS
END ENTITY testbench;

ARCHITECTURE tb OF testbench IS
COMPONENT FSM_alarm IS port 
(code: in bit_vector(3 downto 0);
reset: in bit;
day_time: in bit;
vdd: in bit;
vss: in bit;
clk: in bit;
door: out bit;
alarm: out bit);
end component;
COMPONENT FSM_alarm1 IS port 
(code: in bit_vector(3 downto 0);
reset: in bit;
day_time: in bit;
vdd: in bit;
vss: in bit;
clk: in bit;
door: out bit;
alarm: out bit);
end component;

COMPONENT FSM_alarm2 IS port 
(  code     : in      bit_vector(3 downto 0);
reset    : in      bit;
day_time : in      bit;
vdd      : in      bit;
vss      : in      bit;
clk      : in      bit;
door     : out     bit;
alarm    : out     bit;
scanin   : in      bit;
test     : in      bit;
scanout  : out     bit);
end component;


FOR test0: FSM_alarm USE ENTITY work.FSM_alarm (behavioral_description);
FOR test1: FSM_alarm1 USE ENTITY work.sdetj_b_l (structural);
FOR test2: FSM_alarm2 USE ENTITY work.sdetj_b_l_scan (structural);

SIGNAL code : bit_vector (3 downto 0) := "0000";
SIGNAL reset : bit := '0';
SIGNAL day_time : bit := '0';
SIGNAL vdd : bit := '1';
SIGNAL vss : bit := '0';
SIGNAL clk : bit := '0';
SIGNAL scanin : bit ;
SIGNAL test : bit := '0';
SIGNAL scanout : bit ;
SIGNAL door : bit ;
SIGNAL alarm : bit ;
SIGNAL door1 : bit ;
SIGNAL alarm1 : bit ;
SIGNAL door2 : bit ;
SIGNAL alarm2 : bit ;
constant sequence : bit_vector := "10101001010101100101111101001010101010101";

begin
test0: FSM_alarm PORT MAP (code,reset,day_time,vdd,vss,clk,door,alarm);
test1: FSM_alarm1 PORT MAP (code,reset,day_time,vdd,vss,clk,door1,alarm1);
test2: FSM_alarm2 PORT MAP (code,reset,day_time,vdd,vss,clk,door2,alarm2,scanin,test,scanout);


clk_gen: process is begin
wait for 50 ns;
if clk = '0' then
clk <= '1';
else
clk <= '0';
end if;
end process;
testing: process is begin
reset <= '1';
wait for 100 ns;
reset <= '0';
code <="0010";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="0110";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="1010";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="0000";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="0101";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

wait for 100 ns;
--test set 1

code <="1101";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error ;
wait for 100 ns;

code <="1101";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

wait for 100 ns ;
--test set 2

code <="0010";
day_time<='0';
wait for 100 ns;
code <="0110";
day_time<='0';
wait for 100 ns;
code <="1101";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;
wait for 100 ns;
--test set 3

code <="0010";
day_time<='0';
wait for 100 ns;
code <="1101";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;
wait for 100 ns;
--test set 4

code <="0010";
day_time<='0';
wait for 100 ns;
code <="0110";
day_time<='0';
wait for 100 ns;
code <="1010";
day_time<='0';
wait for 100 ns;
code <="0001";
day_time<='0';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;
wait for 100 ns;
--test set 5
code <="0010";
day_time<='0';
wait for 100 ns;
code <="0110";
day_time<='0';
wait for 100 ns;
code <="1010";
day_time<='0';
wait for 100 ns;
code <="0000";
day_time<='0';
wait for 100 ns;
code <="0001";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;
wait for 100 ns;
--test set 6
code <="0010";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="0110";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="1010";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="0000";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

code <="0101";
day_time<='1';
wait for 100 ns;
assert alarm=alarm1 and door=door1 and alarm =alarm2 and door=door2
report "wrong answer"
severity error;

wait for 100 ns;
--test case 7

test <= '1' ;

for i in 0 to sequence'length-1 loop
    scanin <= sequence(i);
    wait for 100 ns;
    if i>=2 then
        assert scanout = sequence (i-2)
        report "scanout does not follow scan in"
        severity error ;
    end if;
    end loop;
    wait;

end process;
end architecture tb;


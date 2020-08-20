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

FOR test: FSM_alarm USE ENTITY work.FSM_alarm (behavioral_description);

SIGNAL code : bit_vector (3 downto 0) := "0000";
SIGNAL reset : bit := '0';
SIGNAL day_time : bit := '0';
SIGNAL vdd : bit := '1';
SIGNAL vss : bit := '0';
SIGNAL clk : bit := '0';
SIGNAL door : bit := '0';
SIGNAL alarm : bit := '0';

begin
test: FSM_alarm PORT MAP (code,reset,day_time,vdd,vss,clk,door,alarm);
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
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="0110";
day_time<='0';
wait for 100 ns;
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="1010";
day_time<='0';
wait for 100 ns;
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="0000";
day_time<='0';
wait for 100 ns;
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="0101";
day_time<='0';
wait for 100 ns;
assert alarm = '0' and door = '1'
report "wrong answer"
severity error;

wait for 100 ns;
--test set 1

code <="1101";
day_time<='0';
wait for 100 ns;
assert alarm = '1' and door = '0'
report "wrong answer"
severity error ;
wait for 100 ns;

code <="1101";
day_time<='1';
wait for 100 ns;
assert alarm = '0' and door = '1'
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
assert alarm = '0' and door = '1'
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
assert alarm = '1' and door = '0'
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
assert alarm = '1' and door = '0'
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
assert alarm = '1' and door = '0'
report "wrong answer"
severity error;
wait for 100 ns;
--test set 6
code <="0010";
day_time<='1';
wait for 100 ns;
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="0110";
day_time<='1';
wait for 100 ns;
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="1010";
day_time<='1';
wait for 100 ns;
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="0000";
day_time<='1';
wait for 100 ns;
assert alarm = '0' and door = '0'
report "wrong answer"
severity error;

code <="0101";
day_time<='1';
wait for 100 ns;
assert alarm = '0' and door = '1'
report "wrong answer"
severity error;

wait for 100 ns;
--test case 7
wait;
end process;
end architecture tb;

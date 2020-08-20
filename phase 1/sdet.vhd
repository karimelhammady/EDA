entity FSM_alarm is port (
    code: in bit_vector(3 downto 0);
    reset: in bit;
    day_time: in bit;
    vdd: in bit;
    vss: in bit;
    clk: in bit;
    door: out bit;
    alarm: out bit);
    end FSM_alarm;
    
    architecture behavioral_description of FSM_alarm is
    type state_type is (ss0,ss1,ss2,ss3,ss4,ss5,ss6);
    signal cs: state_type;
    signal ns: state_type;

    --pragma current_state cs
    --pragma next_state ns
    --pragma clock clk
    
    begin
    process ( clk ) 
    begin
        if clk='1' and clk'event THEN cs <= ns;
    end if;
    end process ;
 process(cs,code,reset,day_time)
    begin
    if reset = '1' then
    ns <= ss0;
    else
    case cs is
    when ss0 =>
    alarm <= '0';
    door <= '0';
    if  code = "0010" then
    ns <= ss1;
    elsif code = "1101" and day_time = '1' then
    ns <= ss5;
    else
    ns <= ss6;          
    end if;


    when ss1 =>
    alarm <= '0';
    door <= '0';
    if code = "0110" then
    ns <= ss2;
    elsif  code = "1101" and day_time = '1' then
    ns <= ss5;
    else
    ns <= ss6;          
    end if; 


    when ss2 =>
    alarm <= '0';
    door <= '0';
    if code = "1010" then
    ns <= ss3;
    elsif  code = "1101" and day_time = '1' then
    ns <= ss5;
    else
    ns <= ss6;          
    end if;
    
    
    when ss3 =>
    alarm <= '0';
    door <= '0';
    if code = "0000" then
    ns <= ss4;
    elsif  day_time = '1' and code = "1101" then
    ns <= ss5;
    else
    ns <= ss6;
    end if;


    when ss4 =>
    alarm <= '0';
    door <= '0';
    if code = "0101" then
    ns <= ss5;
        elsif  day_time = '1' and code = "1101" then
        ns <= ss5;
        else
        ns <= ss6;
        end if;

        
    when ss5 =>
    alarm <= '0';
    door <= '1';
    ns <= ss0;
    when ss6 =>
    alarm <= '1';
    door <= '0';
    ns <= ss0;           
    end case;
    end if; 
    end process ;
    END behavioral_description;
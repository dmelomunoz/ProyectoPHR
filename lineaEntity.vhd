library ieee;
use ieee.std_logic_1164.all;

entity entityDetection is
  port (
    bitInput : in std_logic_vector(7 downto 0);
    detectedBit : out std_logic -- '1' si ha detectado la secuencia.
  ) ;
end entity;

architecture arquitectura of entityDetection is
 
    signal auxCorrect0,auxCorrect1,auxCorrect2,auxCorrect3,auxCorrect4,auxCorrect5,auxCorrect6,auxCorrect7,auxCorrect8,auxCorrect9:std_logic;
    type state_type is (A,B,C,D,E,F,G,H,I,J);
    signal state : state_type := A ;
    signal clk,reset : std_logic := '0';

    component memCompare
    port (
    charInput : in std_logic_vector(7 downto 0);
    address   : in integer range 0 to 27 ;
    isCorrect : out std_logic
  ) ;
    end component;
	
    component entityDetection is
     port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  end component;

    component is_Detector is
     port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  end component;

    component end_Detector is
     port (
      clk: in std_logic;
      reset : in std_logic;
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    ) ;
  
  end component;
    component caracteres_Detector is
	port (
      bitInput : in std_logic_vector(7 downto 0);
      detectedBit : out std_logic -- '1' si ha detectado la secuencia.
    );
  end component;

begin

--LLAMADAS A LAS ENTIDADES

entDet1: entityDetection port map (clk,reset,bitInput,auxCorrect0);
comp1 : memCompare port map (bitInput,26,isCorrect=>auxCorrect1);
caractDet: caracteres_Detector port map (bitInput,auxCorrect2);
comp2 : memCompare port map (bitInput,26,isCorrect=>auxCorrect3);
isDet: is_Detector port map (clk,reset,bitInput,auxCorrect4);
comp3 : memCompare port map (bitInput,26,isCorrect=>auxCorrect5);
endDet: end_Detector port map (clk,reset,bitInput,auxCorrect6);
comp4 : memCompare port map (bitInput,26,isCorrect=>auxCorrect7);
entDet2: entityDetection port map (clk,reset,bitInput,auxCorrect8);
comp5 : memCompare port map (bitInput,27,isCorrect=>auxCorrect9);


process (clk)
    begin
	if(reset='1') then
		detectedBit <='0' ;
        state <= A;
	elsif(rising_edge(clk)) then
		case state is
			when A=>
                		detectedBit <='0' ;
                		if(auxCorrect0 = '1') then
                 		   state <=B;
				else
                    		   state <=A;
               			end if;
			when B=>
				if(auxCorrect1 = '1') then
                 		   state <=C;
				else
                    		   state <=A;
               			end if;
			when C=>
				if(auxCorrect2 = '1') then
                 		   state <=D;
				else
                    		   state <=A;
               			end if;
			when D=>
				if(auxCorrect3 = '1') then
                 		   state <=E;
				else
                    		   state <=A;
               			end if;
			when E=>
				if(auxCorrect4 = '1') then
                 		   state <=F;
				else
                    		   state <=A;
               			end if;
			when F=>
				if(auxCorrect5 = '1') then
                       		  detectedBit <= '1' ;
                       		  state <=G;
                   		else
                      		  state <= A;
                    		end if;
			when G=>
				if(auxCorrect6 = '1') then
                       		  detectedBit <= '1' ;
                       		  state <=H;
                   		else
                      		  state <= A;
                    		end if;
			when H=>
				if(auxCorrect7 = '1') then
                       		  detectedBit <= '1' ;
                       		  state <=I;
                   		else
                      		  state <= A;
                    		end if;
			when I=>
				if(auxCorrect8 = '1') then
                       		  detectedBit <= '1' ;
                       		  state <=J;
                   		else
                      		  state <= A;
                    		end if;
			when J=>
				if(auxCorrect9 = '1') then
                       		  detectedBit <= '1' ;
                       		  state <=A;
                   		else
                      		  state <= A;
                    		end if;
			when others=> NULL;
		end case;
	end if;
   end process;
end arquitectura;


----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2017 11:22:13 AM
-- Design Name: 
-- Module Name: DISTANCE_DEDUCER - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity DISTANCE_DEDUCER is
	port(   
	       CLK: in STD_LOGIC;
	       RESET: in STD_LOGIC;
	       COMPARE: in STD_LOGIC;
	       REF:  in INTEGER;
	       MEAS: in INTEGER;
	       DISTANCE_RAW: out INTEGER;
	       DISTANCE_ONES: out INTEGER;
	       DISTANCE_TENS: out INTEGER;
	       DISTANCE_TENTHS: out INTEGER
	                     --;
	      -- DISTANCE_D: out INTEGER;
	     --  DISTANCE_X: out INTEGER  
	      );
	       
end DISTANCE_DEDUCER;

architecture Behavioural of DISTANCE_DEDUCER is

type int_array is array (2 downto 0) of integer;

type unit_conv_tab is array (399 downto 0) of int_array; 




signal  iDISTANCE_ONES,iDISTANCE_TENS, i_DISTANCE_X, i_DISTANCE_D, i_DISTANCE_RAW, snap, aquired: integer;

begin



sample: process(COMPARE)
begin
          if rising_edge(CLK) then
                            if (COMPARE = '0' and aquired = 0 and meas /= 0) then 
                                        
                                        DISTANCE_RAW <= MEAS;
                                        snap <= meas;
                                        aquired <= 1;
                                     --   i_DISTANCE_X <= (MEAS)+REF;   -- example distance mathematical expression for cm REQUIRES CALIBRATION
                                     --   i_DISTANCE_D <= (MEAS)+REF; -- example distance mathematical expression for mm REQUIRES CALIBRATION
                             
                             elsif(aquired = 1 and meas = 0) then 
                                       
                                    aquired <= 0;
                                    snap <= snap;
                                        
                            end if;
            end if;                
                                       
            
end process;

up_date: process(snap)
begin

                        if(rising_edge(CLK)) then 
                                   
                                   
                                   if (snap > (ref+433)) then
                                       DISTANCE_ONES <=  4;
                                       DISTANCE_TENS <=  0;
                                       
                                  elsif (snap > (ref+305)) then
                                       DISTANCE_ONES <=  5;
                                      DISTANCE_TENS <=  0;                                  
  
                                   elsif (snap > (ref+207)) then
                                       DISTANCE_ONES <=  6;
                                        DISTANCE_TENS <=  0;   
                                        
                                   elsif (snap >(ref+147)) then
                                        DISTANCE_ONES <=  7;
                                            DISTANCE_TENS <=  0;  
                                            
                                  elsif (snap > (ref+79)) then
                                          DISTANCE_ONES <=  8;
                                         DISTANCE_TENS <=  0;           
                                           
                                           
                               elsif (snap > (ref+39)) then
                                DISTANCE_ONES <=  9;
                                DISTANCE_TENS <=  0;     
                                
                               elsif (snap > (ref)) then
                                      DISTANCE_ONES <=  0;
                                      DISTANCE_TENS <=  1;                                               
  
                                 elsif (snap > (ref-22)) then
                                             DISTANCE_ONES <=  1;
                                             DISTANCE_TENS <=  1;
                                             
                                elsif (snap > (ref-41)) then
                                       DISTANCE_ONES <=  2;
                                  DISTANCE_TENS <=  1;    
   
                               elsif (snap > (ref-70) ) then
                                         DISTANCE_ONES <=  3;
                                  DISTANCE_TENS <=  1;  
                                            
                               elsif (snap > (ref-87)) then
                                     DISTANCE_ONES <=  4;
                                      DISTANCE_TENS <=  1; 
                                      
                                      
                               elsif (snap > (ref-102)) then
                                             DISTANCE_ONES <=  5;
                                             DISTANCE_TENS <=  1;                                       
                                      
                                      
                                elsif (snap > (ref-119) ) then
                                                    DISTANCE_ONES <=  6;
                                                    DISTANCE_TENS <=  1;                                      
                                      
                              
                                      
                               elsif (snap > (ref-134)) then
                                                           DISTANCE_ONES <=  7;
                                                           DISTANCE_TENS <=  1;                                       
                                      
                                      
 
                                elsif (snap > (ref-141)) then
                                                                  DISTANCE_ONES <=  8;
                                                                  DISTANCE_TENS <=  1;  
                                      
                                      
                                      
                                      
                                 elsif (snap > (ref-152)) then
                                                                         DISTANCE_ONES <=  9;
                                                                         DISTANCE_TENS <=  1;                                     
                                      
                                      
                                elsif (snap > (ref-164)) then
                            DISTANCE_ONES <=  0;
                             DISTANCE_TENS <=  2;  
                                                                                
                                                                                
                                                                                
                                 elsif (snap > (ref-172) ) then
                         DISTANCE_ONES <=  1;
                          DISTANCE_TENS <=  2;  
                                                                                                                              
                             elsif (snap > (ref-181) ) then
                      DISTANCE_ONES <=  2;
                       DISTANCE_TENS <=  2;  
                                                                                                
                                                                                
                                elsif (snap > (ref-187) ) then
                   DISTANCE_ONES <=  3;
                    DISTANCE_TENS <=  2;  
                                                                                                                             
                                                                                
                                 elsif (snap > (ref-193) ) then
                DISTANCE_ONES <=  4;
                 DISTANCE_TENS <=  2;  
                                                                                                                       
                                                                                
                                 elsif (snap > (ref-205) ) then
             DISTANCE_ONES <=  5;
              DISTANCE_TENS <=  2;  
                                                                                                                      
                                                                                
                                elsif (snap > (ref-211)) then
          DISTANCE_ONES <=  6;
           DISTANCE_TENS <=  2;  
                                                                                 
                                                                                                                    
                                elsif (snap > (ref-217) ) then
       DISTANCE_ONES <=  7;
        DISTANCE_TENS <=  2;  
                                                                       
  
  
                                  elsif (snap > (ref-223) ) then
    DISTANCE_ONES <=  8;
     DISTANCE_TENS <=  2;  
                              
  
                                elsif (snap > (ref-230) ) then
 DISTANCE_ONES <=  9;
  DISTANCE_TENS <=  2;  
                           
  
  
                                elsif (snap > (ref-236)) then
DISTANCE_ONES <=  0;
DISTANCE_TENS <=  3;  
                        
                        
                                elsif (snap > (ref-242)) then
DISTANCE_ONES <=  1;
DISTANCE_TENS <=  3;  
                      
  
  
                                elsif (snap > (ref-248)) then
DISTANCE_ONES <=  2;
DISTANCE_TENS <=  3;  
                      
  
  
                                  elsif (snap > (ref-251)) then
DISTANCE_ONES <=  3;
DISTANCE_TENS <=  3;  


                                elsif (snap > (ref-254)) then
DISTANCE_ONES <=  4;
DISTANCE_TENS <=  3;  
                      
                              elsif (snap > (ref-260)) then
DISTANCE_ONES <=  5;
DISTANCE_TENS <=  3;  



                                elsif (snap > (ref-263)) then
DISTANCE_ONES <=  6;
DISTANCE_TENS <=  3;  
                      
                                elsif (snap > (ref-266)) then
DISTANCE_ONES <=  7;
DISTANCE_TENS <=  3;  


                                elsif (snap > (ref-268)) then
DISTANCE_ONES <=  8;
DISTANCE_TENS <=  3;  
                      
                      
                                elsif (snap > (ref-270)) then
DISTANCE_ONES <=  9;
DISTANCE_TENS <=  3;  
   
                                else
DISTANCE_ONES <=  0;
DISTANCE_TENS <=  4;  

  
  end if;
  
  
  
  
  
                                     
                                    
                                   iDISTANCE_ONES <=  (snap - (snap/100)*100)/10;
                                   iDISTANCE_TENS <=  snap/100;
                                   DISTANCE_TENTHS <= (snap - (snap/100)*100 - ((snap - (snap/100)*100)/10)*10) ;
                          
                         end if;
                                        


end process;

	       
        
                               

end behavioural;
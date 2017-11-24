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
	       CHANGE: in STD_LOGIC;
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
                            if ((COMPARE = '0') and aquired = 0 and meas /= 0) then 
                                        
                                        DISTANCE_RAW <= MEAS;
                                        snap <= meas;
                                        aquired <= 1;

                             
                             elsif(aquired = 1 and meas = 0) then 
                                       
                                    aquired <= 0;
                                    snap <= snap;
                                     DISTANCE_RAW <= snap;
                                        
                            end if;
           end if;                
                                       
            
end process;

up_date: process(snap)
begin

             --        if(rising_edge(CLK)) then 
                                   
                                   
     
                                       
                                       
      if (CHANGE = '0') then                                     
                                       
                                  if (snap > (ref+3050)) then
                                       DISTANCE_ONES <=  4;
                                      DISTANCE_TENS <=  0;       
                                      
                                       if(snap > ref+4310) then 
                                              DISTANCE_TENTHS <= 0;
                                              
                                       elsif(snap > ref+4180) then 
                                              DISTANCE_TENTHS <= 1;

                                       elsif(snap > ref+4050) then 
                                              DISTANCE_TENTHS <= 2;
                                              
                                              
                                       elsif(snap > ref+3910) then 
                                                     DISTANCE_TENTHS <= 3;

                                      elsif(snap > ref+3780) then 
                                              DISTANCE_TENTHS <= 4;

                                       elsif(snap > ref+3650) then 
                                              DISTANCE_TENTHS <= 5;
                                              
                                              
                                       elsif(snap > ref+3530) then 
                                                     DISTANCE_TENTHS <= 6;


                                       elsif(snap > ref+ 3400) then 
                                              DISTANCE_TENTHS <= 7;

                                       elsif(snap > ref+3280) then 
                                              DISTANCE_TENTHS <= 8;
                                              
                                              
                                       else
                                                     DISTANCE_TENTHS <= 9;

                                     end if;

                                                                 
  
                                   elsif (snap > (ref+2070)) then
                                       DISTANCE_ONES <=  5;
                                        DISTANCE_TENS <=  0;   
                                        
                                        
               
                                                                               if(snap > ref+3050) then 
                                                                                     DISTANCE_TENTHS <= 0;
                                                                                     
                                                                              elsif(snap > ref+2930) then 
                                                                                     DISTANCE_TENTHS <= 1;
                                       
                                                                              elsif(snap > ref+2830) then 
                                                                                     DISTANCE_TENTHS <= 2;
                                                                                     
                                                                                     
                                                                              elsif(snap > ref+2720) then 
                                                                                            DISTANCE_TENTHS <= 3;
                                       
                                                                             elsif(snap > ref+2620) then 
                                                                                     DISTANCE_TENTHS <= 4;
                                       
                                                                              elsif(snap > ref+2520) then 
                                                                                     DISTANCE_TENTHS <= 5;
                                                                                     
                                                                                     
                                                                              elsif(snap > ref+2420) then 
                                                                                            DISTANCE_TENTHS <= 6;
                                       
                                       
                                                                              elsif(snap > ref+ 2330) then 
                                                                                     DISTANCE_TENTHS <= 7;
                                       
                                                                              elsif(snap > ref+2240) then 
                                                                                     DISTANCE_TENTHS <= 8;
                                                                                     
                                                                                     
                                                                              else
                                                                                            DISTANCE_TENTHS <= 9;
                                       
                                                                            end if;
                                        

   
                                        
                                   elsif (snap >(ref+1470)) then
                                        DISTANCE_ONES <=  6;
                                            DISTANCE_TENS <=  0;  
                                            

                
                                                                                                            if(snap > ref+2070) then 
                                                                                                                  DISTANCE_TENTHS <= 0;
                                                                                                                  
                                                                                                           elsif(snap > ref+1990) then 
                                                                                                                  DISTANCE_TENTHS <= 1;
                                                                    
                                                                                                           elsif(snap > ref+1920) then 
                                                                                                                  DISTANCE_TENTHS <= 2;
                                                                                                                  
                                                                                                                  
                                                                                                           elsif(snap > ref+1840) then 
                                                                                                                         DISTANCE_TENTHS <= 3;
                                                                    
                                                                                                          elsif(snap > ref+1770) then 
                                                                                                                  DISTANCE_TENTHS <= 4;
                                                                    
                                                                                                           elsif(snap > ref+1700) then 
                                                                                                                  DISTANCE_TENTHS <= 5;
                                                                                                                  
                                                                                                                  
                                                                                                           elsif(snap > ref+1630) then 
                                                                                                                         DISTANCE_TENTHS <= 6;
                                                                    
                                                                    
                                                                                                           elsif(snap > ref+ 1570) then 
                                                                                                                  DISTANCE_TENTHS <= 7;
                                                                    
                                                                                                           elsif(snap > ref+1510) then 
                                                                                                                  DISTANCE_TENTHS <= 8;
                                                                                                                  
                                                                                                                  
                                                                                                           else
                                                                                                                         DISTANCE_TENTHS <= 9;
                                                                    
                                                                                                         end if;                                           
                                            
                                            
                                            
                                            

                                            
                                  elsif (snap > (ref+790)) then
                                          DISTANCE_ONES <=  7;
                                         DISTANCE_TENS <=  0;    
                                         
               
                                                                                                         if(snap > ref+1460) then 
                                                                                                               DISTANCE_TENTHS <= 0;
                                                                                                               
                                                                                                        elsif(snap > ref+1390) then 
                                                                                                               DISTANCE_TENTHS <= 1;
                                                                 
                                                                                                        elsif(snap > ref+1320) then 
                                                                                                               DISTANCE_TENTHS <= 2;
                                                                                                               
                                                                                                               
                                                                                                        elsif(snap > ref+1250) then 
                                                                                                                      DISTANCE_TENTHS <= 3;
                                                                 
                                                                                                       elsif(snap > ref+1180) then 
                                                                                                               DISTANCE_TENTHS <= 4;
                                                                 
                                                                                                        elsif(snap > ref+1110) then 
                                                                                                               DISTANCE_TENTHS <= 5;
                                                                                                               
                                                                                                               
                                                                                                        elsif(snap > ref+1050) then 
                                                                                                                      DISTANCE_TENTHS <= 6;
                                                                 
                                                                 
                                                                                                        elsif(snap > ref+ 990) then 
                                                                                                               DISTANCE_TENTHS <= 7;
                                                                 
                                                                                                        elsif(snap > ref+930) then 
                                                                                                               DISTANCE_TENTHS <= 8;
                                                                                                               
                                                                                                               
                                                                                                        else
                                                                                                                      DISTANCE_TENTHS <= 9;
                                                                 
                                                                                                      end if;                                         
                                         
          
                                         
                                                
                                           
                                           
                                  elsif (snap > (ref+390)) then
                                       DISTANCE_ONES <=  8;
                                       DISTANCE_TENS <=  0;     
                                       
                                       
                  
                                                                                                       if(snap > ref+810) then 
                                                                                                             DISTANCE_TENTHS <= 0;
                                                                                                             
                                                                                                      elsif(snap > ref+760) then 
                                                                                                             DISTANCE_TENTHS <= 1;
                                                               
                                                                                                      elsif(snap > ref+710) then 
                                                                                                             DISTANCE_TENTHS <= 2;
                                                                                                             
                                                                                                             
                                                                                                      elsif(snap > ref+660) then 
                                                                                                                    DISTANCE_TENTHS <= 3;
                                                               
                                                                                                     elsif(snap > ref+610) then 
                                                                                                             DISTANCE_TENTHS <= 4;
                                                               
                                                                                                      elsif(snap > ref+560) then 
                                                                                                             DISTANCE_TENTHS <= 5;
                                                                                                             
                                                                                                             
                                                                                                      elsif(snap > ref+520) then 
                                                                                                                    DISTANCE_TENTHS <= 6;
                                                               
                                                               
                                                                                                      elsif(snap > ref+ 470) then 
                                                                                                             DISTANCE_TENTHS <= 7;
                                                               
                                                                                                      elsif(snap > ref+430) then 
                                                                                                             DISTANCE_TENTHS <= 8;
                                                                                                             
                                                                                                             
                                                                                                      else
                                                                                                                    DISTANCE_TENTHS <= 9;
                                                               
                                                                                                    end if;                                   
                                       

                                       
                                       
                                
                                     elsif (snap > (ref)) then
                                           DISTANCE_ONES <=  9;
                                           DISTANCE_TENS <=  0; 
                                           
                                           
                
                                                                                                           if(snap > ref+350) then 
                                                                                                                 DISTANCE_TENTHS <= 0;
                                                                                                                 
                                                                                                          elsif(snap > ref+310) then 
                                                                                                                 DISTANCE_TENTHS <= 1;
                                                                   
                                                                                                          elsif(snap > ref+270) then 
                                                                                                                 DISTANCE_TENTHS <= 2;
                                                                                                                 
                                                                                                                 
                                                                                                          elsif(snap > ref+240) then 
                                                                                                                        DISTANCE_TENTHS <= 3;
                                                                   
                                                                                                         elsif(snap > ref+200) then 
                                                                                                                 DISTANCE_TENTHS <= 4;
                                                                   
                                                                                                          elsif(snap > ref+170) then 
                                                                                                                 DISTANCE_TENTHS <= 5;
                                                                                                                 
                                                                                                                 
                                                                                                          elsif(snap > ref+140) then 
                                                                                                                        DISTANCE_TENTHS <= 6;
                                                                   
                                                                   
                                                                                                          elsif(snap > ref+ 110) then 
                                                                                                                 DISTANCE_TENTHS <= 7;
                                                                   
                                                                                                          elsif(snap > ref+80) then 
                                                                                                                 DISTANCE_TENTHS <= 8;
                                                                                                                 
                                                                                                                 
                                                                                                          else
                                                                                                                        DISTANCE_TENTHS <= 9;
                                                                   
                                                                                                        end if;                                          
                                           
                                           
                                           
                                           
                                           
                                           
                                           
                                           
                                                                                         
  
                                 elsif (snap > (ref-220)) then
                                             DISTANCE_ONES <=  0;
                                             DISTANCE_TENS <=  1;
                                             
                
                                                                                                                                        if(snap > ref+20) then 
                                                                                                                                              DISTANCE_TENTHS <= 0;
                                                                                                                                              
                                                                                                                                       elsif(snap > ref-10) then 
                                                                                                                                              DISTANCE_TENTHS <= 1;
                                                                                                
                                                                                                                                       elsif(snap > ref-40) then 
                                                                                                                                              DISTANCE_TENTHS <= 2;
                                                                                                                                              
                                                                                                                                              
                                                                                                                                       elsif(snap > ref-60) then 
                                                                                                                                                     DISTANCE_TENTHS <= 3;
                                                                                                
                                                                                                                                      elsif(snap > ref-80) then 
                                                                                                                                              DISTANCE_TENTHS <= 4;
                                                                                                
                                                                                                                                       elsif(snap > ref-110) then 
                                                                                                                                              DISTANCE_TENTHS <= 5;
                                                                                                                                              
                                                                                                                                              
                                                                                                                                       elsif(snap > ref-130) then 
                                                                                                                                                     DISTANCE_TENTHS <= 6;
                                                                                                
                                                                                                
                                                                                                                                       elsif(snap > ref-160) then 
                                                                                                                                              DISTANCE_TENTHS <= 7;
                                                                                                
                                                                                                                                       elsif(snap > ref-180) then 
                                                                                                                                              DISTANCE_TENTHS <= 8;
                                                                                                                                              
                                                                                                                                              
                                                                                                                                       else
                                                                                                                                                     DISTANCE_TENTHS <= 9;
                                                                                                
                                                                                                                                     end if;                                          
                                                                        
                                                                                                                     
                                             
                                             
                                             
                                             
                                             
                                elsif (snap > (ref-410)) then
                                       DISTANCE_ONES <=  1;
                                  DISTANCE_TENS <=  1;    
                                  
                                  
                                  
                                                  
                                                                                                                             if(snap > ref-200) then 
                                                                                                                                   DISTANCE_TENTHS <= 0;
                                                                                                                                   
                                                                                                                            elsif(snap > ref-220) then 
                                                                                                                                   DISTANCE_TENTHS <= 1;
                                                                                     
                                                                                                                            elsif(snap > ref-240) then 
                                                                                                                                   DISTANCE_TENTHS <= 2;
                                                                                                                                   
                                                                                                                                   
                                                                                                                            elsif(snap > ref-260) then 
                                                                                                                                          DISTANCE_TENTHS <= 3;
                                                                                     
                                                                                                                           elsif(snap > ref-280) then 
                                                                                                                                   DISTANCE_TENTHS <= 4;
                                                                                     
                                                                                                                            elsif(snap > ref-300) then 
                                                                                                                                   DISTANCE_TENTHS <= 5;
                                                                                                                                   
                                                                                                                                   
                                                                                                                            elsif(snap > ref-320) then 
                                                                                                                                          DISTANCE_TENTHS <= 6;
                                                                                     
                                                                                     
                                                                                                                            elsif(snap > ref-340) then 
                                                                                                                                   DISTANCE_TENTHS <= 7;
                                                                                     
                                                                                                                            elsif(snap > ref-360) then 
                                                                                                                                   DISTANCE_TENTHS <= 8;
                                                                                                                                   
                                                                                                                                   
                                                                                                                            else
                                                                                                                                          DISTANCE_TENTHS <= 9;
                                                                                     
                                                                                                                          end if;                                          
                                                             
                                                             
                                  
                                  
                                  
                                  
                                  
   
                               elsif (snap > (ref-700) ) then
                                         DISTANCE_ONES <=  2;
                                  DISTANCE_TENS <=  1; 
                                  
                                                                                    
                                                                                                             if(snap > ref-430) then 
                                                                                                                   DISTANCE_TENTHS <= 0;
                                                                                                                   
                                                                                                            elsif(snap > ref-500) then 
                                                                                                                   DISTANCE_TENTHS <= 1;
                                                                     
                                                                                                            elsif(snap > ref-530) then 
                                                                                                                   DISTANCE_TENTHS <= 2;
                                                                                                                   
                                                                                                                   
                                                                                                            elsif(snap > ref-550) then 
                                                                                                                          DISTANCE_TENTHS <= 3;
                                                                     
                                                                                                           elsif(snap > ref-570) then 
                                                                                                                   DISTANCE_TENTHS <= 4;
                                                                     
                                                                                                            elsif(snap > ref-590) then 
                                                                                                                   DISTANCE_TENTHS <= 5;
                                                                                                                   
                                                                                                                   
                                                                                                            elsif(snap > ref-610) then 
                                                                                                                          DISTANCE_TENTHS <= 6;
                                                                     
                                                                     
                                                                                                            elsif(snap > ref-630) then 
                                                                                                                   DISTANCE_TENTHS <= 7;
                                                                     
                                                                                                            elsif(snap > ref-650) then 
                                                                                                                   DISTANCE_TENTHS <= 8;
                                                                                                                   
                                                                                                                   
                                                                                                            else
                                                                                                                          DISTANCE_TENTHS <= 9;
                                                                     
                                                                                                          end if;     
                                  
                                  
                                   
                                            
                               elsif (snap > (ref-870)) then
                                     DISTANCE_ONES <=  3;
                                      DISTANCE_TENS <=  1; 
                                      
                                                  
                                                                                                                 if(snap > ref-710) then 
                                                                                                                       DISTANCE_TENTHS <= 0;
                                                                                                                       
                                                                                                                elsif(snap > ref-730) then 
                                                                                                                       DISTANCE_TENTHS <= 1;
                                                                         
                                                                                                                elsif(snap > ref-750) then 
                                                                                                                       DISTANCE_TENTHS <= 2;
                                                                                                                       
                                                                                                                       
                                                                                                                elsif(snap > ref-770) then 
                                                                                                                              DISTANCE_TENTHS <= 3;
                                                                         
                                                                                                               elsif(snap > ref-790) then 
                                                                                                                       DISTANCE_TENTHS <= 4;
                                                                         
                                                                                                                elsif(snap > ref-810) then 
                                                                                                                       DISTANCE_TENTHS <= 5;
                                                                                                                       
                                                                                                                       
                                                                                                                elsif(snap > ref-830) then 
                                                                                                                              DISTANCE_TENTHS <= 6;
                                                                         
                                                                         
                                                                                                                elsif(snap > ref-850) then 
                                                                                                                       DISTANCE_TENTHS <= 7;
                                                                         
                                                                                                                elsif(snap > ref-860) then 
                                                                                                                       DISTANCE_TENTHS <= 8;
                                                                                                                       
                                                                                                                       
                                                                                                                else
                                                                                                                              DISTANCE_TENTHS <= 9;
                                                                         
                                                                                                              end if;                                           
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                               elsif (snap > (ref-1020)) then
                                             DISTANCE_ONES <=  4;
                                             DISTANCE_TENS <=  1;           
                                             
                                             
                                                  
                                                                                                                        if(snap > ref-880) then 
                                                                                                                              DISTANCE_TENTHS <= 0;
                                                                                                                              
                                                                                                                       elsif(snap > ref-900) then 
                                                                                                                              DISTANCE_TENTHS <= 1;
                                                                                
                                                                                                                       elsif(snap > ref-920) then 
                                                                                                                              DISTANCE_TENTHS <= 2;
                                                                                                                              
                                                                                                                              
                                                                                                                       elsif(snap > ref-930) then 
                                                                                                                                     DISTANCE_TENTHS <= 3;
                                                                                
                                                                                                                      elsif(snap > ref-950) then 
                                                                                                                              DISTANCE_TENTHS <= 4;
                                                                                
                                                                                                                       elsif(snap > ref-960) then 
                                                                                                                              DISTANCE_TENTHS <= 5;
                                                                                                                              
                                                                                                                              
                                                                                                                       elsif(snap > ref-980) then 
                                                                                                                                     DISTANCE_TENTHS <= 6;
                                                                                
                                                                                
                                                                                                                       elsif(snap > ref-1000) then 
                                                                                                                              DISTANCE_TENTHS <= 7;
                                                                                
                                                                                                                       elsif(snap > ref-1010) then 
                                                                                                                              DISTANCE_TENTHS <= 8;
                                                                                                                              
                                                                                                                              
                                                                                                                       else
                                                                                                                                     DISTANCE_TENTHS <= 9;
                                                                                
                                                                                                                     end if;                                                  
                                             
                                             
                                             
                                                                         
                                      
                                      
                                elsif (snap > (ref-1190) ) then
                                                    DISTANCE_ONES <=  5;
                                                    DISTANCE_TENS <=  1;                 
                                                    
                                                    
                                                      
                                                                                                                               if(snap > ref-1040) then 
                                                                                                                                     DISTANCE_TENTHS <= 0;
                                                                                                                                     
                                                                                                                              elsif(snap > ref-1060) then 
                                                                                                                                     DISTANCE_TENTHS <= 1;
                                                                                       
                                                                                                                              elsif(snap > ref-1070) then 
                                                                                                                                     DISTANCE_TENTHS <= 2;
                                                                                                                                     
                                                                                                                                     
                                                                                                                              elsif(snap > ref-1090) then 
                                                                                                                                            DISTANCE_TENTHS <= 3;
                                                                                       
                                                                                                                             elsif(snap > ref-1100) then 
                                                                                                                                     DISTANCE_TENTHS <= 4;
                                                                                       
                                                                                                                              elsif(snap > ref-1120) then 
                                                                                                                                     DISTANCE_TENTHS <= 5;
                                                                                                                                     
                                                                                                                                     
                                                                                                                              elsif(snap > ref-1130) then 
                                                                                                                                            DISTANCE_TENTHS <= 6;
                                                                                       
                                                                                       
                                                                                                                              elsif(snap > ref-1150) then 
                                                                                                                                     DISTANCE_TENTHS <= 7;
                                                                                       
                                                                                                                              elsif(snap > ref-1160) then 
                                                                                                                                     DISTANCE_TENTHS <= 8;
                                                                                                                                     
                                                                                                                                     
                                                                                                                              else
                                                                                                                                            DISTANCE_TENTHS <= 9;
                                                                                       
                                                                                                                            end if;                                                    
                                                    
                                                                         
                                      
                              
                                      
                               elsif (snap > (ref-1340)) then
                                                           DISTANCE_ONES <=  6;
                                                           DISTANCE_TENS <=  1;        
                                                           
                                                    
                                                                                                                                      if(snap > ref-1205) then 
                                                                                                                                            DISTANCE_TENTHS <= 0;
                                                                                                                                            
                                                                                                                                     elsif(snap > ref-1220) then 
                                                                                                                                            DISTANCE_TENTHS <= 1;
                                                                                              
                                                                                                                                     elsif(snap > ref-1235) then 
                                                                                                                                            DISTANCE_TENTHS <= 2;
                                                                                                                                            
                                                                                                                                            
                                                                                                                                     elsif(snap > ref-1250) then 
                                                                                                                                                   DISTANCE_TENTHS <= 3;
                                                                                              
                                                                                                                                    elsif(snap > ref-1265) then 
                                                                                                                                            DISTANCE_TENTHS <= 4;
                                                                                              
                                                                                                                                     elsif(snap > ref-1280) then 
                                                                                                                                            DISTANCE_TENTHS <= 5;
                                                                                                                                            
                                                                                                                                            
                                                                                                                                     elsif(snap > ref-1295) then 
                                                                                                                                                   DISTANCE_TENTHS <= 6;
                                                                                              
                                                                                              
                                                                                                                                     elsif(snap > ref-1310) then 
                                                                                                                                            DISTANCE_TENTHS <= 7;
                                                                                              
                                                                                                                                     elsif(snap > ref-1325) then 
                                                                                                                                            DISTANCE_TENTHS <= 8;
                                                                                                                                            
                                                                                                                                            
                                                                                                                                     else
                                                                                                                                                   DISTANCE_TENTHS <= 9;
                                                                                              
                                                                                                                                   end if;                                                              
                                                           
                                                           
                                                                                          
                                      
                                      
 
                                elsif (snap > (ref-1410)) then
                                                                  DISTANCE_ONES <=  7;
                                                                  DISTANCE_TENS <=  1;  
                                                                  
                                                                  
                                                   
                                                                                                                                             if(snap > ref-1348) then 
                                                                                                                                                   DISTANCE_TENTHS <= 0;
                                                                                                                                                   
                                                                                                                                            elsif(snap > ref-1356) then 
                                                                                                                                                   DISTANCE_TENTHS <= 1;
                                                                                                     
                                                                                                                                            elsif(snap > ref-1363) then 
                                                                                                                                                   DISTANCE_TENTHS <= 2;
                                                                                                                                                   
                                                                                                                                                   
                                                                                                                                            elsif(snap > ref-1371) then 
                                                                                                                                                          DISTANCE_TENTHS <= 3;
                                                                                                     
                                                                                                                                           elsif(snap > ref-1379) then 
                                                                                                                                                   DISTANCE_TENTHS <= 4;
                                                                                                     
                                                                                                                                            elsif(snap > ref-1387) then 
                                                                                                                                                   DISTANCE_TENTHS <= 5;
                                                                                                                                                   
                                                                                                                                                   
                                                                                                                                            elsif(snap > ref-1395) then 
                                                                                                                                                          DISTANCE_TENTHS <= 6;
                                                                                                     
                                                                                                     
                                                                                                                                            elsif(snap > ref-1402) then 
                                                                                                                                                   DISTANCE_TENTHS <= 7;
                                                                                                     
                                                                                                                                            elsif(snap > ref-1405) then 
                                                                                                                                                   DISTANCE_TENTHS <= 8;
                                                                                                                                                   
                                                                                                                                                   
                                                                                                                                            else
                                                                                                                                                          DISTANCE_TENTHS <= 9;
                                                                                                     
                                                                                                                                          end if;                                                                      
                                                                  
                                                                  
                                                                  
                                      
                                      
                                      
                                      
                                 elsif (snap > (ref-1520)) then
                                                                         DISTANCE_ONES <=  8;
                                                                         DISTANCE_TENS <=  1;                   
                                                                         
                                                                         
                                                    
                                                                                                                                                    if(snap > ref-1421) then 
                                                                                                                                                          DISTANCE_TENTHS <= 0;
                                                                                                                                                          
                                                                                                                                                   elsif(snap > ref-1432) then 
                                                                                                                                                          DISTANCE_TENTHS <= 1;
                                                                                                            
                                                                                                                                                   elsif(snap > ref-1443) then 
                                                                                                                                                          DISTANCE_TENTHS <= 2;
                                                                                                                                                          
                                                                                                                                                          
                                                                                                                                                   elsif(snap > ref-1454) then 
                                                                                                                                                                 DISTANCE_TENTHS <= 3;
                                                                                                            
                                                                                                                                                  elsif(snap > ref-1465) then 
                                                                                                                                                          DISTANCE_TENTHS <= 4;
                                                                                                            
                                                                                                                                                   elsif(snap > ref-1476) then 
                                                                                                                                                          DISTANCE_TENTHS <= 5;
                                                                                                                                                          
                                                                                                                                                          
                                                                                                                                                   elsif(snap > ref-1487) then 
                                                                                                                                                                 DISTANCE_TENTHS <= 6;
                                                                                                            
                                                                                                            
                                                                                                                                                   elsif(snap > ref-1498) then 
                                                                                                                                                          DISTANCE_TENTHS <= 7;
                                                                                                            
                                                                                                                                                   elsif(snap > ref-1509) then 
                                                                                                                                                          DISTANCE_TENTHS <= 8;
                                                                                                                                                          
                                                                                                                                                          
                                                                                                                                                   else
                                                                                                                                                                 DISTANCE_TENTHS <= 9;
                                                                                                            
                                                                                                                                                 end if;                                                                          
                                                                         
                                                                         
                                                                         
                                                                         
                                                                                           
                                      
                                      
                                elsif (snap > (ref-1640)) then
                            DISTANCE_ONES <=  9;
                             DISTANCE_TENS <= 1;  
                             
                                                  
                                                                                                        if(snap > ref-1532) then 
                                                                                                              DISTANCE_TENTHS <= 0;
                                                                                                              
                                                                                                       elsif(snap > ref-1544) then 
                                                                                                              DISTANCE_TENTHS <= 1;
                                                                
                                                                                                       elsif(snap > ref-1556) then 
                                                                                                              DISTANCE_TENTHS <= 2;
                                                                                                              
                                                                                                              
                                                                                                       elsif(snap > ref-1568) then 
                                                                                                                     DISTANCE_TENTHS <= 3;
                                                                
                                                                                                      elsif(snap > ref-1580) then 
                                                                                                              DISTANCE_TENTHS <= 4;
                                                                
                                                                                                       elsif(snap > ref-1592) then 
                                                                                                              DISTANCE_TENTHS <= 5;
                                                                                                              
                                                                                                              
                                                                                                       elsif(snap > ref-1604) then 
                                                                                                                     DISTANCE_TENTHS <= 6;
                                                                
                                                                
                                                                                                       elsif(snap > ref-1616) then 
                                                                                                              DISTANCE_TENTHS <= 7;
                                                                
                                                                                                       elsif(snap > ref-1628) then 
                                                                                                              DISTANCE_TENTHS <= 8;
                                                                                                              
                                                                                                              
                                                                                                       else
                                                                                                                     DISTANCE_TENTHS <= 9;
                                                                
                                                                                                     end if;                                  
                                                                                
                                                                                
                                                                                
                                 elsif (snap > (ref-1720) ) then
                         DISTANCE_ONES <=  0;
                          DISTANCE_TENS <=  2;  
                          
                          
                                                  
                                                                                                     if(snap > ref-1648) then 
                                                                                                           DISTANCE_TENTHS <= 0;
                                                                                                           
                                                                                                    elsif(snap > ref-1656) then 
                                                                                                           DISTANCE_TENTHS <= 1;
                                                             
                                                                                                    elsif(snap > ref-1664) then 
                                                                                                           DISTANCE_TENTHS <= 2;
                                                                                                           
                                                                                                           
                                                                                                    elsif(snap > ref-1672) then 
                                                                                                                  DISTANCE_TENTHS <= 3;
                                                             
                                                                                                   elsif(snap > ref-1680) then 
                                                                                                           DISTANCE_TENTHS <= 4;
                                                             
                                                                                                 elsif(snap > ref-1688) then 
                                                                                                          DISTANCE_TENTHS <= 5;
                                                                                                           
                                                                                                           
                                                                                                    elsif(snap > ref-1696) then 
                                                                                                                  DISTANCE_TENTHS <= 6;
                                                             
                                                             
                                                                                                    elsif(snap > ref-1704) then 
                                                                                                           DISTANCE_TENTHS <= 7;
                                                             
                                                                                                    elsif(snap > ref-1712) then 
                                                                                                           DISTANCE_TENTHS <= 8;
                                                                                                           
                                                                                                           
                                                                                                    else
                                                                                                                  DISTANCE_TENTHS <= 9;
                                                             
                                                                                                  end if;     
                          
                          
                                                                                                                              
                             elsif (snap > (ref-1810) ) then
                      DISTANCE_ONES <=  1;
                       DISTANCE_TENS <=  2;  
                       
                                                  
                                                                                                  if(snap > ref-1729) then 
                                                                                                        DISTANCE_TENTHS <= 0;
                                                                                                        
                                                                                                 elsif(snap > ref-1738) then 
                                                                                                        DISTANCE_TENTHS <= 1;
                                                          
                                                                                                 elsif(snap > ref-1747) then 
                                                                                                        DISTANCE_TENTHS <= 2;
                                                                                                        
                                                                                                        
                                                                                                 elsif(snap > ref-1756) then 
                                                                                                               DISTANCE_TENTHS <= 3;
                                                          
                                                                                                elsif(snap > ref-1765) then 
                                                                                                        DISTANCE_TENTHS <= 4;
                                                          
                                                                                                 elsif(snap > ref-1774) then 
                                                                                                        DISTANCE_TENTHS <= 5;
                                                                                                        
                                                                                                        
                                                                                                 elsif(snap > ref-1783) then 
                                                                                                               DISTANCE_TENTHS <= 6;
                                                          
                                                          
                                                                                                 elsif(snap > ref-1792) then 
                                                                                                       DISTANCE_TENTHS <= 7;
                                                          
                                                                                                 elsif(snap > ref-1801) then 
                                                                                                        DISTANCE_TENTHS <= 8;
                                                                                                        
                                                                                                        
                                                                                                 else
                                                                                                               DISTANCE_TENTHS <= 9;
                                                          
                                                                                               end if;                        
                                                                                                
                                                                                
                                elsif (snap > (ref-1870) ) then
                   DISTANCE_ONES <=  2;
                    DISTANCE_TENS <=  2;  
                    
                                                  
                                                                                               if(snap > ref-1816) then 
                                                                                                     DISTANCE_TENTHS <= 0;
                                                                                                     
                                                                                              elsif(snap > ref-1822) then 
                                                                                                     DISTANCE_TENTHS <= 1;
                                                       
                                                                                             elsif(snap > ref-1828) then 
                                                                                                     DISTANCE_TENTHS <= 2;
                                                                                                     
                                                                                                     
                                                                                              elsif(snap > ref-1834) then 
                                                                                                            DISTANCE_TENTHS <= 3;
                                                       
                                                                                            elsif(snap > ref-1840) then 
                                                                                                     DISTANCE_TENTHS <= 4;
                                                       
                                                                                              elsif(snap > ref-1846) then 
                                                                                                     DISTANCE_TENTHS <= 5;
                                                                                                     
                                                                                                     
                                                                                              elsif(snap > ref-1852) then 
                                                                                                            DISTANCE_TENTHS <= 6;
                                                       
                                                       
                                                                                             elsif(snap > ref-1858) then 
                                                                                                    DISTANCE_TENTHS <= 7;
                                                       
                                                                                              elsif(snap > ref-1864) then 
                                                                                                     DISTANCE_TENTHS <= 8;
                                                                                                     
                                                                                                     
                                                                                              else
                                                                                                            DISTANCE_TENTHS <= 9;
                                                       
                                                                                            end if;                
                    
                    
                    
                                                                                                                             
                                                                                
                                 elsif (snap > (ref-1930) ) then
                DISTANCE_ONES <=  3;
                 DISTANCE_TENS <=  2;  
                 
                 
                                                  
                                                                                            if(snap > ref-1876) then 
                                                                                                  DISTANCE_TENTHS <= 0;
                                                                                                  
                                                                                           elsif(snap > ref-1882) then 
                                                                                                  DISTANCE_TENTHS <= 1;
                                                    
                                                                                           elsif(snap > ref-1888) then 
                                                                                                  DISTANCE_TENTHS <= 2;
                                                                                                  
                                                                                                  
                                                                                           elsif(snap > ref-1894) then 
                                                                                                         DISTANCE_TENTHS <= 3;
                                                    
                                                                                          elsif(snap > ref-1900) then 
                                                                                                  DISTANCE_TENTHS <= 4;
                                                    
                                                                                           elsif(snap > ref-1906) then 
                                                                                                  DISTANCE_TENTHS <= 5;
                                                                                                  
                                                                                                  
                                                                                           elsif(snap > ref-1912) then 
                                                                                                         DISTANCE_TENTHS <= 6;
                                                    
                                                    
                                                                                           elsif(snap > ref-1918) then 
                                                                                                  DISTANCE_TENTHS <= 7;
                                                    
                                                                                           elsif(snap > ref-1924) then 
                                                                                                  DISTANCE_TENTHS <= 8;
                                                                                                  
                                                                                                  
                                                                                           else
                                                                                                         DISTANCE_TENTHS <= 9;
                                                    
                                                                                         end if;                      
                 
                 
                 
                 
                 
                                                                                                                       
                                                                                
                                 elsif (snap > (ref-2050) ) then
             DISTANCE_ONES <=  4;
              DISTANCE_TENS <=  2;  
              
              
              
                                                  
                                                                                         if(snap > ref-1942) then 
                                                                                               DISTANCE_TENTHS <= 0;
                                                                                               
                                                                                        elsif(snap > ref-1954) then 
                                                                                               DISTANCE_TENTHS <= 1;
                                                 
                                                                                        elsif(snap > ref-1966) then 
                                                                                               DISTANCE_TENTHS <= 2;
                                                                                               
                                                                                               
                                                                                        elsif(snap > ref-1978) then 
                                                                                                      DISTANCE_TENTHS <= 3;
                                                 
                                                                                       elsif(snap > ref-1990) then 
                                                                                               DISTANCE_TENTHS <= 4;
                                                 
                                                                                        elsif(snap > ref-2002) then 
                                                                                               DISTANCE_TENTHS <= 5;
                                                                                               
                                                                                               
                                                                                        elsif(snap > ref-2014) then 
                                                                                                      DISTANCE_TENTHS <= 6;
                                                 
                                                 
                                                                                        elsif(snap > ref-2026) then 
                                                                                               DISTANCE_TENTHS <= 7;
                                                 
                                                                                        elsif(snap > ref-2038) then 
                                                                                               DISTANCE_TENTHS <= 8;
                                                                                               
                                                                                               
                                                                                        else
                                                                                                      DISTANCE_TENTHS <= 9;
                                                 
                                                                                      end if;                   
              
              
              
              
              
              
              
                                                                                                                      
                                                                                
                                elsif (snap > (ref-2110)) then
          DISTANCE_ONES <=  5;
           DISTANCE_TENS <=  2;  
                                      
                                      
                                      
                                                  
                                                                                      if(snap > ref-2056) then 
                                                                                            DISTANCE_TENTHS <= 0;
                                                                                            
                                                                                     elsif(snap > ref-2062) then 
                                                                                            DISTANCE_TENTHS <= 1;
                                              
                                                                                     elsif(snap > ref-2068) then 
                                                                                            DISTANCE_TENTHS <= 2;
                                                                                            
                                                                                            
                                                                                     elsif(snap > ref-2074) then 
                                                                                                   DISTANCE_TENTHS <= 3;
                                              
                                                                                    elsif(snap > ref-2080) then 
                                                                                            DISTANCE_TENTHS <= 4;
                                              
                                                                                     elsif(snap > ref-2086) then 
                                                                                            DISTANCE_TENTHS <= 5;
                                                                                            
                                                                                            
                                                                                     elsif(snap > ref-2092) then 
                                                                                                   DISTANCE_TENTHS <= 6;
                                              
                                              
                                                                                     elsif(snap > ref-2098) then 
                                                                                            DISTANCE_TENTHS <= 7;
                                              
                                                                                     elsif(snap > ref-2104) then 
                                                                                            DISTANCE_TENTHS <= 8;
                                                                                            
                                                                                            
                                                                                     else
                                                                                                   DISTANCE_TENTHS <= 9;
                                              
                                                                                   end if;                                           
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                      
                                                                                 
                                                                                                                    
                                elsif (snap > (ref-2170) ) then
       DISTANCE_ONES <=  6;
        DISTANCE_TENS <=  2;  
                                          
                                          
                                                  
                                                                                   if(snap > ref-2116) then 
                                                                                         DISTANCE_TENTHS <= 0;
                                                                                         
                                                                                  elsif(snap > ref-2122) then 
                                                                                         DISTANCE_TENTHS <= 1;
                                           
                                                                                  elsif(snap > ref-2128) then 
                                                                                         DISTANCE_TENTHS <= 2;
                                                                                         
                                                                                         
                                                                                  elsif(snap > ref-2134) then 
                                                                                                DISTANCE_TENTHS <= 3;
                                           
                                                                                 elsif(snap > ref-2140) then 
                                                                                         DISTANCE_TENTHS <= 4;
                                           
                                                                                  elsif(snap > ref-2146) then 
                                                                                         DISTANCE_TENTHS <= 5;
                                                                                         
                                                                                         
                                                                                  elsif(snap > ref-2152) then 
                                                                                                DISTANCE_TENTHS <= 6;
                                           
                                           
                                                                                  elsif(snap > ref-2158) then 
                                                                                         DISTANCE_TENTHS <= 7;
                                           
                                                                                  elsif(snap > ref-2164) then 
                                                                                         DISTANCE_TENTHS <= 8;
                                                                                         
                                                                                         
                                                                                  else
                                                                                                DISTANCE_TENTHS <= 9;
                                           
                                                                                end if;                                               
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                          
                                                                       
  
  
                                  elsif (snap > (ref-2230) ) then
    DISTANCE_ONES <=  7;
     DISTANCE_TENS <=  2;  
     
     
     
     
     
     
                                                  
                                                                                if(snap > ref-2176) then 
                                                                                      DISTANCE_TENTHS <= 0;
                                                                                      
                                                                               elsif(snap > ref-2182) then 
                                                                                      DISTANCE_TENTHS <= 1;
                                        
                                                                               elsif(snap > ref-2188) then 
                                                                                      DISTANCE_TENTHS <= 2;
                                                                                      
                                                                                      
                                                                               elsif(snap > ref-2194) then 
                                                                                             DISTANCE_TENTHS <= 3;
                                        
                                                                              elsif(snap > ref-2200) then 
                                                                                      DISTANCE_TENTHS <= 4;
                                        
                                                                               elsif(snap > ref-2206) then 
                                                                                      DISTANCE_TENTHS <= 5;
                                                                                      
                                                                                      
                                                                               elsif(snap > ref-2212) then 
                                                                                             DISTANCE_TENTHS <= 6;
                                        
                                        
                                                                               elsif(snap > ref-2218) then 
                                                                                      DISTANCE_TENTHS <= 7;
                                        
                                                                               elsif(snap > ref-2224) then 
                                                                                      DISTANCE_TENTHS <= 8;
                                                                                      
                                                                                      
                                                                               else
                                                                                             DISTANCE_TENTHS <= 9;
                                        
                                                                             end if;          
     
     
     
     
     
     
     
     
     
     
     
     
     
                              
  
                                elsif (snap > (ref-2300) ) then
 DISTANCE_ONES <=  8;
  DISTANCE_TENS <=  2;  
  
  
                                                  
                                                                             if(snap > ref-2237) then 
                                                                                   DISTANCE_TENTHS <= 0;
                                                                                   
                                                                            elsif(snap > ref-2244) then 
                                                                                   DISTANCE_TENTHS <= 1;
                                     
                                                                            elsif(snap > ref-2251) then 
                                                                                   DISTANCE_TENTHS <= 2;
                                                                                   
                                                                                   
                                                                            elsif(snap > ref-2258) then 
                                                                                          DISTANCE_TENTHS <= 3;
                                     
                                                                           elsif(snap > ref-2265) then 
                                                                                   DISTANCE_TENTHS <= 4;
                                     
                                                                            elsif(snap > ref-2272) then 
                                                                                   DISTANCE_TENTHS <= 5;
                                                                                   
                                                                                   
                                                                            elsif(snap > ref-2279) then 
                                                                                          DISTANCE_TENTHS <= 6;
                                     
                                     
                                                                            elsif(snap > ref-2286) then 
                                                                                   DISTANCE_TENTHS <= 7;
                                     
                                                                            elsif(snap > ref-2293) then 
                                                                                   DISTANCE_TENTHS <= 8;
                                                                                   
                                                                                   
                                                                            else
                                                                                          DISTANCE_TENTHS <= 9;
                                     
                                                                          end if;       
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
                                  elsif (snap > (ref-2360) ) then
DISTANCE_ONES <=  9;
DISTANCE_TENS <=  2;  


                                                  
                                                                                                                             if(snap > ref-2306) then 
                                                                                                                                   DISTANCE_TENTHS <= 0;
                                                                                                                                   
                                                                                                                            elsif(snap > ref-2312) then 
                                                                                                                                   DISTANCE_TENTHS <= 1;
                                                                                     
                                                                                                                            elsif(snap > ref-2318) then 
                                                                                                                                   DISTANCE_TENTHS <= 2;
                                                                                                                                   
                                                                                                                                   
                                                                                                                            elsif(snap > ref-2324) then 
                                                                                                                                          DISTANCE_TENTHS <= 3;
                                                                                     
                                                                                                                           elsif(snap > ref-2330) then 
                                                                                                                                   DISTANCE_TENTHS <= 4;
                                                                                     
                                                                                                                            elsif(snap > ref-2336) then 
                                                                                                                                   DISTANCE_TENTHS <= 5;
                                                                                                                                   
                                                                                                                                   
                                                                                                                            elsif(snap > ref-2342) then 
                                                                                                                                          DISTANCE_TENTHS <= 6;
                                                                                     
                                                                                     
                                                                                                                            elsif(snap > ref-2348) then 
                                                                                                                                   DISTANCE_TENTHS <= 7;
                                                                                     
                                                                                                                            elsif(snap > ref-2354) then 
                                                                                                                                   DISTANCE_TENTHS <= 8;
                                                                                                                                   
                                                                                                                                   
                                                                                                                            else
                                                                                                                                          DISTANCE_TENTHS <= 9;
                                                                                     
                                                                                                                          end if;     












                           
  
  
                                else
DISTANCE_ONES <=  0;
DISTANCE_TENS <=  3;  
DISTANCE_TENTHS <= 0;
                        
                        
                        
                        
                        
                        
                        


  
  end if;
  
  
   else 
  
  
                                     
                                    
                                 DISTANCE_ONES <=  (snap - (snap/1000)*1000)/100;
                                 DISTANCE_TENS <=  snap/1000;
                                 DISTANCE_TENTHS <= (snap - (snap/1000)*1000 - ((snap - (snap/1000)*1000)/100)*100) ;
                          
                         end if;
 -- end if;                                    


end process;

	       
        
                               

end behavioural;
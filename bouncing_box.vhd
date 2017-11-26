library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bouncing_box is
    Port ( 	clk : in  STD_LOGIC;
			reset : in  STD_LOGIC;
			scan_line_x: in STD_LOGIC_VECTOR(10 downto 0);
			scan_line_y: in STD_LOGIC_VECTOR(10 downto 0);
            
            ones: in integer;
            tens: in integer;
            tenths: in integer;
            
			kHz: in STD_LOGIC;
			red: out STD_LOGIC_VECTOR(3 downto 0);
			blue: out STD_LOGIC_VECTOR(3 downto 0);
			
			green: out std_logic_vector(3 downto 0)
		  );
end bouncing_box;

architecture Behavioral of bouncing_box is

type matrix is array(0 to 7, 0 to 3) of std_logic;

signal redraw: std_logic_vector(5 downto 0):=(others=>'0');
constant box_loc_x_min: std_logic_vector(9 downto 0) := "0000000000";
constant box_loc_y_min: std_logic_vector(9 downto 0) := "0000000000";
signal box_loc_x_max: std_logic_vector(9 downto 0); -- Not constants because these dependant on box_width 
signal box_loc_y_max: std_logic_vector(9 downto 0);
signal pixel_color: std_logic_vector(11 downto 0);
signal box_loc_x, box_loc_y: std_logic_vector(9 downto 0);
signal box_move_dir_x, box_move_dir_y: std_logic;


signal forty: std_logic_vector ( 10 downto 0):= "00000101000"; -- 40 
signal eighty: std_logic_vector ( 10 downto 0):= "00001010000"; 
signal one_twenty : std_logic_vector ( 10 downto 0):= "00001111000";
signal one_sixty: std_logic_vector ( 10 downto 0):= "00010100000";
signal two_hundred: std_logic_vector ( 10 downto 0):= "00011001000";
signal two_forty: std_logic_vector ( 10 downto 0):= "00011110000";
signal two_eighty: std_logic_vector ( 10 downto 0):= "00100011000";
signal one_forty: std_logic_vector ( 10 downto 0):= "00010001100";
signal three_twenty: std_logic_vector ( 10 downto 0):= "00101000000";

signal offset_1:  std_logic_vector ( 10 downto 0):= "00010110100"; 
signal offset_2:  std_logic_vector ( 10 downto 0):= "00110101000"; 
signal y_offset:  std_logic_vector ( 10 downto 0):= "00001010000"; 


signal i_tens, i_ones, i_tenths: matrix; 


signal width: std_logic_vector(8 downto 0) := "000101000";  --40
signal box_color:  STD_LOGIC_VECTOR(11 downto 0) := "000000000000";


 signal zero: matrix:= ( 
                                                        ('1', '1', '1', '1'),
                                                        ('1', '0', '0', '1'),
                                                        ('1', '0', '0', '1'),
                                                        ('1', '0', '0', '1'),
                                                        ('1', '0', '0', '1'),
                                                        ('1', '0', '0', '1'),
                                                        ('1', '0', '0', '1'),
                                                        ('1', '1', '1', '1')
                        );
                                                                       
        


signal one: matrix:= 		  ( 
							    ('0', '0', '0', '1'),
							    ('0', '0', '0', '1'),
							    ('0', '0', '0', '1'),
							    ('0', '0', '0', '1'),
							    ('0', '0', '0', '1'),
							    ('0', '0', '0', '1'),
							    ('0', '0', '0', '1'),
							    ('0', '0', '0', '1')
                        );
                        
                        
 signal two: matrix:= ( 
                                                        ('1', '1', '1', '1'),
                                                        ('0', '0', '0', '1'),
                                                        ('0', '0', '0', '1'),
                                                        ('0', '0', '0', '1'),
                                                        ('1', '1', '1', '1'),
                                                        ('1', '0', '0', '0'),
                                                        ('1', '0', '0', '0'),
                                                        ('1', '1', '1', '1')
                        );
                                                                       
 signal three: matrix:= ( 
                                                                               ('1', '1', '1', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '1', '1', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('1', '1', '1', '1')
                                               );
                                                                                              
                                                       
signal four: matrix:= 		                                            ( 
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '1', '1', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1')
                                                                       );                       

signal five: matrix:= 		                                            ( 
                                                                               ('1', '1', '1', '1'),
                                                                               ('1', '0', '0', '0'),
                                                                               ('1', '0', '0', '0'),
                                                                               ('1', '0', '0', '0'),
                                                                               ('1', '1', '1', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('1', '1', '1', '1')
                                                                       );                           
                        
                        

signal six: matrix:= 		                                            ( 
                                                                               ('1', '1', '1', '1'),
                                                                               ('1', '0', '0', '0'),
                                                                               ('1', '0', '0', '0'),
                                                                               ('1', '0', '0', '0'),
                                                                               ('1', '1', '1', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '1', '1', '1')
                                                                       );                           
                        


 signal seven: matrix:= ( 
                                                                               ('1', '1', '1', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1')
                                               );





signal eight: matrix:= 		                                            ( 
                                                                               ('1', '1', '1', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '1', '1', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '1', '1', '1')
                                                                       );                           
                        

signal nine: matrix:= 		                                            ( 
                                                                               ('1', '1', '1', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '0', '0', '1'),
                                                                               ('1', '1', '1', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1'),
                                                                               ('0', '0', '0', '1')
                                                                       );                           
                        
signal ex: matrix:= 		                                            ( 
                                                                                                                                                      ('1', '0', '0', '1'),
                                                                                                                                                      ('1', '0', '0', '1'),
                                                                                                                                                      ('0', '1', '1', '0'),
                                                                                                                                                      ('0', '1', '1', '0'),
                                                                                                                                                      ('0', '1', '1', '0'),
                                                                                                                                                      ('0', '1', '1', '0'),
                                                                                                                                                      ('1', '0', '0', '1'),
                                                                                                                                                      ('1', '0', '0', '1')
                                                                                                                                              );                           
                                                                                               

                        
                        
begin



--i_tens <= zero;
--i_ones <= four;
--i_tenths <= nine;


process(clk) 
begin


   -- row 1


      if (i_tens(0,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < "00000000000"+width+y_offset)) ) then
      
                  
					                               pixel_color <= box_color;	
					                               
				

								
      
     elsif (i_tens(0,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < "00000000000"+width+y_offset))) then
                    
                                              pixel_color <= box_color;    



    elsif (i_tens(0,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < "00000000000"+width+y_offset))) then

					                               pixel_color <= box_color;
					                               
			
			
					 

      
   elsif (i_tens(0,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < "00000000000"+width+y_offset))) then
                    
                                                                      pixel_color <= box_color;  
 





-- row 2
                
   elsif (i_tens(1,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < "00000101000"+width+y_offset)) ) then
                                                                           
                                                             pixel_color <= box_color;    
                                                                 
   elsif (i_tens(1,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                                    
                                                            pixel_color <= box_color;    
                                                                                                          
     elsif (i_tens(1,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                
                                                          pixel_color <= box_color;
                                                                                
                                                                
                                                                      
     elsif (i_tens(1,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                                    
                                                        pixel_color <= box_color;  
                                                                                                                      
   -- level 3
   
    elsif (i_tens(2,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < "00001010000"+width+y_offset)) ) then
                                                                        
                                                                                    
                                                               pixel_color <= box_color;    
                                                                                                                     
                                                                        
     elsif (i_tens(2,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                                      
                                                              pixel_color <= box_color;    
                                                                                            
                                           
                                                                  
       elsif (i_tens(2,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                  
                                                            pixel_color <= box_color;
                                                                                                                     
          
       elsif (i_tens(2,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                                      
                                                          pixel_color <= box_color;  
                                                          
        -- level 4
        
        
            elsif (i_tens(3,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < "00001111000"+width+y_offset)) ) then
                                                                            
                                                                                        
                                                                   pixel_color <= box_color;    
                                                                                                                         
                                                                            
         elsif (i_tens(3,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                                          
                                                                  pixel_color <= box_color;    
                                                                                                
                                               
                                                                      
           elsif (i_tens(3,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                      
                                                                pixel_color <= box_color;
                                                                                                                         
              
           elsif (i_tens(3,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                                          
                                                              pixel_color <= box_color;  
        
        
        
        
        --- level 5
        
        elsif (i_tens(4,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < one_sixty+width+y_offset)) ) then
                                                                        
                                                                                    
                                                               pixel_color <= box_color;    
                                                                                                                     
                                                                        
     elsif (i_tens(4,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                                      
                                                              pixel_color <= box_color;    
                                                                                            
                                           
                                                                  
       elsif (i_tens(4,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                  
                                                            pixel_color <= box_color;
                                                                                                                     
          
       elsif (i_tens(4,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                                      
                                                          pixel_color <= box_color;  
        
        
        -- level 6
        
      elsif (i_tens(5,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < two_hundred+width+y_offset)) ) then
                                                                        
                                                                                    
                                                               pixel_color <= box_color;    
                                                                                                                     
                                                                        
     elsif (i_tens(5,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                                      
                                                              pixel_color <= box_color;    
                                                                                            
                                           
                                                                  
       elsif (i_tens(5,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                  
                                                            pixel_color <= box_color;
                                                                                                                     
          
       elsif (i_tens(5,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                                      
                                                          pixel_color <= box_color;  
        
        
        -- level 7
        
                
      elsif (i_tens(6,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < two_forty+width+y_offset)) ) then
                                                                        
                                                                                    
                                                               pixel_color <= box_color;    
                                                                                                                     
                                                                        
     elsif (i_tens(6,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < two_forty+width+y_offset))) then
                                                                                      
                                                              pixel_color <= box_color;    
                                                                                            
                                           
                                                                  
       elsif (i_tens(6,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < two_forty+width+y_offset))) then
                                                                  
                                                            pixel_color <= box_color;
                                                                                                                     
          
       elsif (i_tens(6,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < two_forty+width+y_offset))) then
                                                                                      
                                                          pixel_color <= box_color;  
        
        
        -- level 8
   
                   
elsif (i_tens(7,0) = '1' and ((scan_line_x >= "00000000100") and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00000000000"+width) and (scan_line_y < two_eighty+width+y_offset)) ) then
                                                                
                                                                            
                                                       pixel_color <= box_color;    
                                                                                                             
                                                                
elsif (i_tens(7,1) = '1' and ((scan_line_x >= "00000101000") and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00000101000"+width) and (scan_line_y < two_eighty+width+y_offset))) then
                                                                              
                                                      pixel_color <= box_color;    
                                                                                    
                                   
                                                          
elsif (i_tens(7,2) = '1' and ((scan_line_x >= "00001010000") and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00001010000"+width) and (scan_line_y < two_eighty+width+y_offset))) then
                                                          
                                                    pixel_color <= box_color;                                            
  
elsif (i_tens(7,3) = '1' and ((scan_line_x >= "00001111000") and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00001111000"+width) and (scan_line_y < two_eighty+width+y_offset))) then
                                                                              
                                                  pixel_color <= box_color;  
   
   
   --- second number -ones position 
   
   
-- row 1
   
   
         elsif (i_ones(0,0) = '1' and ((scan_line_x >= ("00000000000"+offset_1)) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < "00000000000"+width+y_offset)) ) then
         
                     
                                                      pixel_color <= box_color;    
                                                      
                   
   
                                   
         
        elsif (i_ones(0,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < "00000000000"+width+y_offset))) then
                       
                                                 pixel_color <= box_color;    
                             
            
                       
                       
   
        
   
       elsif (i_ones(0,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < "00000000000"+width+y_offset))) then
   
                                                      pixel_color <= box_color;
                                                      
               
               
                        
   
         
      elsif (i_ones(0,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < "00000000000"+width+y_offset))) then
                       
                                                                         pixel_color <= box_color;  
    
   
   
   
   
   
   -- row 2
                   
      elsif (i_ones(1,0) = '1' and ((scan_line_x >= "00000000000"+offset_1) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < "00000101000"+width+y_offset)) ) then
                                                                              
                                                                pixel_color <= box_color;    
                                                                    
      elsif (i_ones(1,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                                       
                                                               pixel_color <= box_color;    
                                                                                                             
        elsif (i_ones(1,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                   
                                                             pixel_color <= box_color;
                                                                                   
                                                                   
                                                                         
        elsif (i_ones(1,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                                       
                                                           pixel_color <= box_color;  
                                                                                                                         
      -- level 3
      
       elsif (i_ones(2,0) = '1' and ((scan_line_x >= "00000000000"+offset_1) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < "00001010000"+width+y_offset)) ) then
                                                                           
                                                                                       
                                                                  pixel_color <= box_color;    
                                                                                                                        
                                                                           
        elsif (i_ones(2,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                                         
                                                                 pixel_color <= box_color;    
                                                                                               
                                              
                                                                     
          elsif (i_ones(2,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                     
                                                               pixel_color <= box_color;
                                                                                                                        
             
          elsif (i_ones(2,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                                         
                                                             pixel_color <= box_color;  
                                                             
           -- level 4
           
           
               elsif (i_ones(3,0) = '1' and ((scan_line_x >= "00000000000"+offset_1) and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < "00001111000"+width+y_offset)) ) then
                                                                               
                                                                                           
                                                                      pixel_color <= box_color;    
                                                                                                                            
                                                                               
            elsif (i_ones(3,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                                             
                                                                     pixel_color <= box_color;    
                                                                                                   
                                                  
                                                                         
              elsif (i_ones(3,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                         
                                                                   pixel_color <= box_color;
                                                                                                                            
                 
              elsif (i_ones(3,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                                             
                                                                 pixel_color <= box_color;  
           
           
           
           
           --- level 5
           
           elsif (i_ones(4,0) = '1' and ((scan_line_x >= "00000000000"+offset_1) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < one_sixty+width+y_offset)) ) then
                                                                           
                                                                                       
                                                                  pixel_color <= box_color;    
                                                                                                                        
                                                                           
        elsif (i_ones(4,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                                         
                                                                 pixel_color <= box_color;    
                                                                                               
                                              
                                                                     
          elsif (i_ones(4,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                     
                                                               pixel_color <= box_color;
                                                                                                                        
             
          elsif (i_ones(4,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                                         
                                                             pixel_color <= box_color;  
           
           
           -- level 6
           
         elsif (i_ones(5,0) = '1' and ((scan_line_x >= "00000000000"+offset_1) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < two_hundred+width+y_offset)) ) then
                                                                           
                                                                                       
                                                                  pixel_color <= box_color;    
                                                                                                                        
                                                                           
        elsif (i_ones(5,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                                         
                                                                 pixel_color <= box_color;    
                                                                                               
                                              
                                                                     
          elsif (i_ones(5,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                     
                                                               pixel_color <= box_color;
                                                                                                                        
             
          elsif (i_ones(5,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                                         
                                                             pixel_color <= box_color;  
           
           
           -- level 7
           
                   
         elsif (i_ones(6,0) = '1' and ((scan_line_x >= "00000000000"+offset_1) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < two_forty+width+y_offset)) ) then
                                                                           
                                                                                       
                                                                  pixel_color <= box_color;    
                                                                                                                        
                                                                           
        elsif (i_ones(6,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < two_forty+width+y_offset))) then
                                                                                         
                                                                 pixel_color <= box_color;    
                                                                                               
                                              
                                                                     
          elsif (i_ones(6,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < two_forty+width+y_offset))) then
                                                                     
                                                               pixel_color <= box_color;
                                                                                                                        
             
          elsif (i_ones(6,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < two_forty+width+y_offset))) then
                                                                                         
                                                             pixel_color <= box_color;  
           
           
           -- level 8
      
                      
   elsif (i_ones(7,0) = '1' and ((scan_line_x >= "00000000000"+offset_1) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00000000000"+width+offset_1) and (scan_line_y < two_eighty+width+y_offset)) ) then
                                                                   
                                                                               
                                                          pixel_color <= box_color;    
                                                                                                                
                                                                   
   elsif (i_ones(7,1) = '1' and ((scan_line_x >= "00000101000"+offset_1) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00000101000"+width+offset_1) and (scan_line_y < two_eighty+width+y_offset))) then
                                                                                 
                                                         pixel_color <= box_color;    
                                                                                       
                                      
                                                             
   elsif (i_ones(7,2) = '1' and ((scan_line_x >= "00001010000"+offset_1) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00001010000"+width+offset_1) and (scan_line_y < two_eighty+width+y_offset))) then
                                                             
                                                       pixel_color <= box_color;                                            
     
   elsif (i_ones(7,3) = '1' and ((scan_line_x >= "00001111000"+offset_1) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00001111000"+width+offset_1) and (scan_line_y < two_eighty+width+y_offset))) then
                                                                                 
                                                     pixel_color <= box_color;  
                                                     
                                                     
                                                     
   -- third number   
   
   
            elsif (i_tenths(0,0) = '1' and ((scan_line_x >= ("00000000000"+offset_2)) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < "00000000000"+width+y_offset)) ) then
            
                        
                                                         pixel_color <= box_color;    
                                                         
                      
      
                                      
            
           elsif (i_tenths(0,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < "00000000000"+width+y_offset))) then
                          
                                                    pixel_color <= box_color;    
                                
               
                          
                          
      
           
      
          elsif (i_tenths(0,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < "00000000000"+width+y_offset))) then
      
                                                         pixel_color <= box_color;
                                                         
                  
                  
                           
      
            
         elsif (i_tenths(0,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= "00000000000"+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < "00000000000"+width+y_offset))) then
                          
                                                                            pixel_color <= box_color;  
       
      
      
      
      
      
      -- row 2
                      
         elsif (i_tenths(1,0) = '1' and ((scan_line_x >= "00000000000"+offset_2) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < "00000101000"+width+y_offset)) ) then
                                                                                 
                                                                   pixel_color <= box_color;    
                                                                       
         elsif (i_tenths(1,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                                          
                                                                  pixel_color <= box_color;    
                                                                                                                
           elsif (i_tenths(1,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                      
                                                                pixel_color <= box_color;
                                                                                      
                                                                      
                                                                            
           elsif (i_tenths(1,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= "00000101000"+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < "00000101000"+width+y_offset))) then
                                                                                          
                                                              pixel_color <= box_color;  
                                                                                                                            
         -- level 3
         
          elsif (i_tenths(2,0) = '1' and ((scan_line_x >= "00000000000"+offset_2) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < "00001010000"+width+y_offset)) ) then
                                                                              
                                                                                          
                                                                     pixel_color <= box_color;    
                                                                                                                           
                                                                              
           elsif (i_tenths(2,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                                            
                                                                    pixel_color <= box_color;    
                                                                                                  
                                                 
                                                                        
             elsif (i_tenths(2,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                        
                                                                  pixel_color <= box_color;
                                                                                                                           
                
             elsif (i_tenths(2,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < "00001010000"+width+y_offset))) then
                                                                                            
                                                                pixel_color <= box_color;  
                                                                
              -- level 4
              
              
                  elsif (i_tenths(3,0) = '1' and ((scan_line_x >= "00000000000"+offset_2) and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < "00001111000"+width+y_offset)) ) then
                                                                                  
                                                                                              
                                                                         pixel_color <= box_color;    
                                                                                                                               
                                                                                  
               elsif (i_tenths(3,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                                                
                                                                        pixel_color <= box_color;    
                                                                                                      
                                                     
                                                                            
                 elsif (i_tenths(3,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= "00001010000"+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                            
                                                                      pixel_color <= box_color;
                                                                                                                               
                    
                 elsif (i_tenths(3,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= "00001111000"+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < "00001111000"+width+y_offset))) then
                                                                                                
                                                                    pixel_color <= box_color;  
              
              
              
              
              --- level 5
              
              elsif (i_tenths(4,0) = '1' and ((scan_line_x >= "00000000000"+offset_2) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < one_sixty+width+y_offset)) ) then
                                                                              
                                                                                          
                                                                     pixel_color <= box_color;    
                                                                                                                           
                                                                              
           elsif (i_tenths(4,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                                            
                                                                    pixel_color <= box_color;    
                                                                                                  
                                                 
                                                                        
             elsif (i_tenths(4,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                        
                                                                  pixel_color <= box_color;
                                                                                                                           
                
             elsif (i_tenths(4,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= one_sixty+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < one_sixty+width+y_offset))) then
                                                                                            
                                                                pixel_color <= box_color;  
              
              
              -- level 6
              
            elsif (i_tenths(5,0) = '1' and ((scan_line_x >= "00000000000"+offset_2) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < two_hundred+width+y_offset)) ) then
                                                                              
                                                                                          
                                                                     pixel_color <= box_color;    
                                                                                                                           
                                                                              
           elsif (i_tenths(5,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                                            
                                                                    pixel_color <= box_color;    
                                                                                                  
                                                 
                                                                        
             elsif (i_tenths(5,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                        
                                                                  pixel_color <= box_color;
                                                                                                                           
                
             elsif (i_tenths(5,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= two_hundred+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < two_hundred+width+y_offset))) then
                                                                                            
                                                                pixel_color <= box_color;  
              
              
              -- level 7
              
                      
            elsif (i_tenths(6,0) = '1' and ((scan_line_x >= "00000000000"+offset_2) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < two_forty+width+y_offset)) ) then
                                                                              
                                                                                          
                                                                     pixel_color <= box_color;    
                                                                                                                           
                                                                              
           elsif (i_tenths(6,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < two_forty+width+y_offset))) then
                                                                                            
                                                                    pixel_color <= box_color;    
                                                                                                  
                                                 
                                                                        
             elsif (i_tenths(6,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < two_forty+width+y_offset))) then
                                                                        
                                                                  pixel_color <= box_color;
                                                                                                                           
                
             elsif (i_tenths(6,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= two_forty+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < two_forty+width+y_offset))) then
                                                                                            
                                                                pixel_color <= box_color;  
              
              
              -- level 8
         
                         
      elsif (i_tenths(7,0) = '1' and ((scan_line_x >= "00000000000"+offset_2) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00000000000"+width+offset_2) and (scan_line_y < two_eighty+width+y_offset)) ) then
                                                                      
                                                                                  
                                                             pixel_color <= box_color;    
                                                                                                                   
                                                                      
      elsif (i_tenths(7,1) = '1' and ((scan_line_x >= "00000101000"+offset_2) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00000101000"+width+offset_2) and (scan_line_y < two_eighty+width+y_offset))) then
                                                                                    
                                                            pixel_color <= box_color;    
                                                                                          
                                         
                                                                
      elsif (i_tenths(7,2) = '1' and ((scan_line_x >= "00001010000"+offset_2) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00001010000"+width+offset_2) and (scan_line_y < two_eighty+width+y_offset))) then
                                                                
                                                          pixel_color <= box_color;                                            
        
      elsif (i_tenths(7,3) = '1' and ((scan_line_x >= "00001111000"+offset_2) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < "00001111000"+width+offset_2) and (scan_line_y < two_eighty+width+y_offset))) then
                                                                                    
                                                        pixel_color <= box_color;     
   
   
   
 --  decimal
   
  
      elsif (((scan_line_x >= three_twenty + forty) and (scan_line_y >= two_eighty+y_offset) and (scan_line_x < three_twenty+forty+width) and (scan_line_y < two_eighty + width+y_offset)) ) then
                                                                                                                            
                                                                                                                                        
                                                                                                                   pixel_color <= box_color;  
  
  
  
   else 
             pixel_color <= "111111111111";                            
          
     end if;
     
        


end process;

					





pixel: process(scan_line_x, scan_line_y)
begin

	if(tens = 0)then
            i_tens <= zero;
        elsif(tens = 1)then
            i_tens <= one;
        elsif(tens = 2)then
            i_tens <= two;
        elsif(tens = 3)then
            i_tens <= three;
        elsif(tens = 4)then
            i_tens <= four;
        elsif(tens = 5)then
            i_tens <= five;
        elsif(tens = 6)then
            i_tens <= six;
        elsif(tens = 7)then
            i_tens <= seven;        
        elsif(tens = 8)then
            i_tens <= eight;
         elsif(tens = 9) then
             i_tens <= nine;
        else
            i_tens <= ex;
        end if;
        
        if(ones = 0)then
            i_ones <= zero;
        elsif(ones = 1)then
            i_ones <= one;
        elsif(ones = 2)then
            i_ones <= two;
        elsif(ones = 3)then
            i_ones <= three;
        elsif(ones = 4)then
            i_ones <= four;
        elsif(ones = 5)then
            i_ones <= five;
        elsif(ones = 6)then
            i_ones <= six;
        elsif(ones = 7)then
            i_ones <= seven;        
        elsif(ones = 8)then
            i_ones <= eight;
        elsif(ones = 9) then
            i_ones <= nine;
        else
            i_ones <= ex;    
        
        end if;
        
        if(tenths = 0)then
            i_tenths <= zero;
        elsif(tenths = 1)then
            i_tenths <= one;
        elsif(tenths = 2)then
            i_tenths <= two;
        elsif(tenths = 3)then
            i_tenths <= three;
        elsif(tenths = 4)then
            i_tenths <= four;
        elsif(tenths = 5)then
            i_tenths <= five;
        elsif(tenths = 6)then
            i_tenths <= six;
        elsif(tenths = 7)then
            i_tenths <= seven;        
        elsif(tenths = 8)then
            i_tenths <= eight;
        elsif(tenths = 9) then
            i_tenths <= nine;
        else 
             i_tenths <= ex;
        end if;
	

end process;



								
								
red   <= pixel_color(11 downto 8);
green <= pixel_color(7 downto 4);
blue  <= pixel_color(3 downto 0);

box_loc_x_max <= "1010000000" - width - 1;

box_loc_y_max <= "0111100000" - width - 1;

end Behavioral;


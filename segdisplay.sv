`timescale 1ns / 1ps


module segdisplay(

  input wire segclk,	
  input reg [4:0] score,	
  input wire reset,		
  input wire start,	
  output reg [6:0] seg,	
  output reg [3:0] an		
);
  logic [6:0] feyk;
  logic [6:0] feyk1;
  // constants for displaying letters on display
  parameter zero = 7'b1000000;
  parameter one = 7'b1111001;
  parameter two = 7'b0100100;
  parameter three= 7'b0110000;
  parameter four = 7'b0011001;
  parameter five = 7'b0010010;
  parameter six = 7'b0000010;
  parameter seven= 7'b1111000;
  parameter eight =7'b0000000;
  parameter nine=7'b0010000;

  // Finite State Machine (FSM) states

  parameter midright = 2'b10;
  parameter right = 2'b11;

  // state register
  reg [1:0] state;


  always @(posedge segclk or posedge reset )
    begin
//        if (start == 1)
//        begin
      // reset condition
      if (reset == 1)
        begin
          seg <= one;
          an <= 4'b1111;
          state <= midright;
        end
      // display the character for the current position
      // and then move to the next state
      else
        begin 
          if(score==16)begin
            feyk=one;
            feyk1=six;
          end


          if(score==15)
            begin 
              feyk=one;
              feyk1=five;
            end
          if(score==14)
            begin 
              feyk=one;
              feyk1=four;
            end

          if(score==13)
            begin 
              feyk=one;
              feyk1=three;
            end


          if(score==12)
            begin 
              feyk=one;
              feyk1=two;
            end  
          if(score==11)
            begin 
              feyk=one;
              feyk1=one;
            end


          if(score==10)
            begin 
              feyk=one;
              feyk1=zero;
            end     


          if(score==9)
            begin 
              feyk=zero;
              feyk1=nine;
            end

          if(score==8)
            begin 
              feyk=zero;
              feyk1=eight;
            end
          if(score==7)
            begin 
              feyk=zero;
              feyk1=seven;
            end

          if(score==6)
            begin 
              feyk=zero;
              feyk1=six;
            end    

          if(score==5)
            begin 
              feyk=zero;
              feyk1=five;
            end 

          if(score==4)
            begin 
              feyk=zero;
              feyk1=four;
            end 
            
          if(score==3)
            begin 
              feyk=zero;
              feyk1=three;
            end 
            
          if(score==2)
            begin 
              feyk=zero;
              feyk1=two;
            end 
            
          if(score==1)
            begin 
              feyk=zero;
              feyk1=one;
            end 
            
          if(score==0)
            begin 
              feyk=zero;
              feyk1=zero;
            end 

          case(state)
            midright:
              begin
                seg <= feyk;
                an <= 4'b1101;
                state <= right;
              end
            right:
              begin
                seg <= feyk1;
                an <= 4'b1110;
                state <= midright;
              end
          endcase
        end
        //end
    end

endmodule
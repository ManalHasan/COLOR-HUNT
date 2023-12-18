`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2016 06:10:45 PM
// Design Name: 
// Module Name: clockdiv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module clockdivider(
  input wire clk,		
  input wire reset,		
  output wire vgaClock,		
  output wire segclk,
  output wire logicClock	

);

  
  reg [24:0] q;


  always @(posedge clk or posedge reset)
    begin
    
      if (reset == 1)
        q <= 0;
     
      else
        q <= q + 1;
    end

 
  assign segclk = q[17];
  assign logicClock = q[22];
  assign vgaClock = q[1];


endmodule

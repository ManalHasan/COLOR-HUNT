`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2016 11:44:31 PM
// Design Name: 
// Module Name: vgaDisplay
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

module vgaDisplay(
  input wire vgaClock,			
  input reg [9:0] horizontalPos,
  input reg[9:0] verticalPos,
  input wire reset,	
  input wire start,		
  input reg [7:0][9:0][2:0] arr ,
  input reg [7:0][9:0][2:0] t1 ,
  input reg [4:0] score,
  output wire hsync,		
  output wire vsync,	
  output reg [3:0] red,	
  output reg [3:0] green, 
  output reg [3:0] blue	
  //output wire [4:0] score

);

  // video structure constants
  parameter hpixels = 800;// horizontal pixels per line
  parameter vlines = 521; // vertical lines per frame
  parameter hpulse = 96; 	// hsync pulse length
  parameter vpulse = 2; 	// vsync pulse length
  parameter hbp = 144; 	// end of horizontal back porch
  parameter hfp = 784; 	// beginning of horizontal front porch
  parameter vbp = 31; 		// end of vertical back porch
  parameter vfp = 511; 	// beginning of vertical front porch
 

  reg [9:0] hc;
  reg [9:0] vc;
reg [7:0] titleOutput;
  //reg [4:0] score1;
TitleScreen ts(
  .clk(logicClock),
  .titleOutput(titleOutput)
);
  always @(posedge vgaClock or posedge reset )
     begin
     
      if (reset == 1)
        begin
          hc <= 0;
          vc <= 0;
        end
      else

        begin
          
          if (hc < hpixels - 1)
            hc <= hc + 1;
          else
           
            begin
              hc <= 0;
              if (vc < vlines - 1)
                vc <= vc + 1;
              else
                vc <= 0;
            end

        end
    
end

  assign hsync = (hc < hpulse) ? 0:1;
  assign vsync = (vc < vpulse) ? 0:1;
///////
//always @(posedge start)
//begin 
//red <= 4'b0000;
//    green <= 4'b1111;
//    blue <= 4'b0000;
//end 
///////
  always @(*)
    begin
    if (start==0)
    begin
        red = 3'b000;
        green = 3'b000;
        blue = 2'b00;
       
         if ((hc > 700)|| (hc < 40) || (vc > 440) || (vc <40))
            begin
            red <= 3'b000;    
            green <= 3'b000;    
            blue <= 2'b00;    
            end
    
    
       else if (
          //H
          ( hc>=119+70 && hc<=139+70 && vc>=250 && vc<=350 )||
           ( hc>=190+70 && hc<=210+70 && vc>=250 && vc<=350 )||
           ( hc>=139+70 && hc<=190+70 && vc>=290 && vc<=310 )||
           //U
           ( hc>=219+70 && hc<=239+70 && vc>=250 && vc<=350 ) ||
            ( hc>=290+70 && hc<=310+70 && vc>=250 && vc<=350 ) ||
            ( hc>=239+70 && hc<=290+70 && vc>=330 && vc<=350 )||
            //N
            ( hc>=319+70 && hc<=339+70 && vc>=250 && vc<=350 )||
            ( hc>=339+70 && hc<=410+70 && vc>=255 && vc<=275 )||
            ( hc>=390+70 && hc<=410+70 && vc>=275 && vc<=350 )||
            
            //t
          ( hc>=419+70 && hc<=510+70 && vc>=250 && vc<=270 ) ||
          ( hc>=454+70 && hc<=474+70 && vc>=270 && vc<=350 )

            
       )
         begin
        //light blue for hunt
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
       
        else if (
           //l
            ( hc>=319+70 && hc<=339+70 && vc>=130 && vc<=210 )||
            ( hc>=319+70 && hc<=410+70 && vc>=210 && vc<=230 ))
            begin 
        red <= 4'b1111; //pink colour for l.    
        green <= 4'b0111;    
        blue <= 4'b1111; 
       end
       
       else if (   //r
        ( hc>=519+70 && hc<=539+70 && vc>=130 && vc<=370 )||
        ( hc>=539+70 && hc<=610+70 && vc>=135 && vc<=155 )||
        ( hc>=590+70 && hc<=610+70 && vc>=155 && vc<=165 )||
        ( hc>=519+70 && hc<=539+70 && vc>=375 && vc<=395 )||
        //C
           ( hc>=119+70 && hc<=210+70 && vc>=130 && vc<=150 ) ||
            ( hc>=119+70 && hc<=139+70 && vc>=130 && vc<=230 )||
           ( hc>=119+70 && hc<=210+70 && vc>=210 && vc<=230 )||
           ( hc>=190+70 && hc<=210+70 && vc>=150 && vc<=155 )||
           ( hc>=190+70 && hc<=210+70 && vc>=205 && vc<=210 ))
           
           begin 
        red <= 4'b1111; //red colour for c and r of color.    
        green <= 4'b0000;    
        blue <= 4'b0000; 
       end
       
       else if (
        // first  O of color
            ( hc>=219+70 && hc<=310+70 && vc>=130 && vc<=150 )||
            ( hc>=219+70 && hc<=239+70 && vc>=130 && vc<=230 )||
            ( hc>=290+70 && hc<=310+70 && vc>=130 && vc<=230 )||
           ( hc>=219+70 && hc<=310+70 && vc>=210 && vc<=230 )||
           
       
       //0 second
            ( hc>=419+70 && hc<=510+70 && vc>=130 && vc<=150 )||
            ( hc>=419+70 && hc<=439+70 && vc>=130 && vc<=230 )||
            ( hc>=490+70 && hc<=510+70 && vc>=130 && vc<=230 )||
           ( hc>=419+70 && hc<=510+70 && vc>=210 && vc<=230 ))
          begin 
        red <= 4'b0000; //green  colour for o and o of color.    
        green <= 4'b1111;    
        blue <= 4'b0000; 
       end
               
         
       
     
       
       else
        begin
            red <= 3'b000; 
            blue <= 2'b00; 
            green <= 3'b00; 
        end  
  end
  
     ///////
  else begin
      if(hc>horizontalPos+2&&hc<28+horizontalPos&&vc>verticalPos+2&&vc<verticalPos+28) begin 
        red = 4'b0000;
        green = 4'b1111;
        blue = 4'b0000;
      end



      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+50&&vc<vbp+80&&arr[0][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+50&&vc<vbp+80&&arr[0][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+50&&vc<vbp+80&&arr[0][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+50&&vc<vbp+80&&arr[0][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+50&&vc<vbp+80&&arr[0][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+50&&vc<vbp+80&&arr[1][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+50&&vc<vbp+80&&arr[1][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+50&&vc<vbp+80&&arr[1][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+50&&vc<vbp+80&&arr[1][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+50&&vc<vbp+80&&arr[1][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+50&&vc<vbp+80&&arr[2][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+50&&vc<vbp+80&&arr[2][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+50&&vc<vbp+80&&arr[2][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+50&&vc<vbp+80&&arr[2][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+50&&vc<vbp+80&&arr[2][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+50&&vc<vbp+80&&arr[3][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+50&&vc<vbp+80&&arr[3][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+50&&vc<vbp+80&&arr[3][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+50&&vc<vbp+80&&arr[3][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+50&&vc<vbp+80&&arr[3][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+50&&vc<vbp+80&&arr[4][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+50&&vc<vbp+80&&arr[4][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+50&&vc<vbp+80&&arr[4][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+50&&vc<vbp+80&&arr[4][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+50&&vc<vbp+80&&arr[4][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+50&&vc<vbp+80&&arr[5][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+50&&vc<vbp+80&&arr[5][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+50&&vc<vbp+80&&arr[5][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+50&&vc<vbp+80&&arr[5][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+50&&vc<vbp+80&&arr[5][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+50&&vc<vbp+80&&arr[6][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+50&&vc<vbp+80&&arr[6][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+50&&vc<vbp+80&&arr[6][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+50&&vc<vbp+80&&arr[6][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+50&&vc<vbp+80&&arr[6][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+50&&vc<vbp+80&&arr[7][0]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+50&&vc<vbp+80&&arr[7][0]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+50&&vc<vbp+80&&arr[7][0]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+50&&vc<vbp+80&&arr[7][0]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+50&&vc<vbp+80&&arr[7][0]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+80&&vc<vbp+110&&arr[0][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+80&&vc<vbp+110&&arr[0][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+80&&vc<vbp+110&&arr[0][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+80&&vc<vbp+110&&arr[0][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+80&&vc<vbp+110&&arr[0][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+80&&vc<vbp+110&&arr[1][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+80&&vc<vbp+110&&arr[1][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+80&&vc<vbp+110&&arr[1][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+80&&vc<vbp+110&&arr[1][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+80&&vc<vbp+110&&arr[1][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+80&&vc<vbp+110&&arr[2][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+80&&vc<vbp+110&&arr[2][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+80&&vc<vbp+110&&arr[2][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+80&&vc<vbp+110&&arr[2][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+80&&vc<vbp+110&&arr[2][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+80&&vc<vbp+110&&arr[3][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+80&&vc<vbp+110&&arr[3][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+80&&vc<vbp+110&&arr[3][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+80&&vc<vbp+110&&arr[3][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+80&&vc<vbp+110&&arr[3][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+80&&vc<vbp+110&&arr[4][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+80&&vc<vbp+110&&arr[4][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+80&&vc<vbp+110&&arr[4][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+80&&vc<vbp+110&&arr[4][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+80&&vc<vbp+110&&arr[4][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+80&&vc<vbp+110&&arr[5][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+80&&vc<vbp+110&&arr[5][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+80&&vc<vbp+110&&arr[5][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+80&&vc<vbp+110&&arr[5][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+80&&vc<vbp+110&&arr[5][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+80&&vc<vbp+110&&arr[6][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+80&&vc<vbp+110&&arr[6][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+80&&vc<vbp+110&&arr[6][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+80&&vc<vbp+110&&arr[6][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+80&&vc<vbp+110&&arr[6][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+80&&vc<vbp+110&&arr[7][1]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+80&&vc<vbp+110&&arr[7][1]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+80&&vc<vbp+110&&arr[7][1]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+80&&vc<vbp+110&&arr[7][1]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+80&&vc<vbp+110&&arr[7][1]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+110&&vc<vbp+140&&arr[0][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+110&&vc<vbp+140&&arr[0][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+110&&vc<vbp+140&&arr[0][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+110&&vc<vbp+140&&arr[0][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+110&&vc<vbp+140&&arr[0][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+110&&vc<vbp+140&&arr[1][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+110&&vc<vbp+140&&arr[1][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+110&&vc<vbp+140&&arr[1][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+110&&vc<vbp+140&&arr[1][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+110&&vc<vbp+140&&arr[1][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+110&&vc<vbp+140&&arr[2][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+110&&vc<vbp+140&&arr[2][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+110&&vc<vbp+140&&arr[2][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+110&&vc<vbp+140&&arr[2][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+110&&vc<vbp+140&&arr[2][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+110&&vc<vbp+140&&arr[3][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+110&&vc<vbp+140&&arr[3][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+110&&vc<vbp+140&&arr[3][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+110&&vc<vbp+140&&arr[3][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+110&&vc<vbp+140&&arr[3][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+110&&vc<vbp+140&&arr[4][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+110&&vc<vbp+140&&arr[4][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+110&&vc<vbp+140&&arr[4][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+110&&vc<vbp+140&&arr[4][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+110&&vc<vbp+140&&arr[4][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+110&&vc<vbp+140&&arr[5][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+110&&vc<vbp+140&&arr[5][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+110&&vc<vbp+140&&arr[5][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+110&&vc<vbp+140&&arr[5][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+110&&vc<vbp+140&&arr[5][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+110&&vc<vbp+140&&arr[6][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+110&&vc<vbp+140&&arr[6][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+110&&vc<vbp+140&&arr[6][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+110&&vc<vbp+140&&arr[6][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+110&&vc<vbp+140&&arr[6][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+110&&vc<vbp+140&&arr[7][2]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+110&&vc<vbp+140&&arr[7][2]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+110&&vc<vbp+140&&arr[7][2]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+110&&vc<vbp+140&&arr[7][2]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+110&&vc<vbp+140&&arr[7][2]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+140&&vc<vbp+170&&arr[0][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+140&&vc<vbp+170&&arr[0][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+140&&vc<vbp+170&&arr[0][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+140&&vc<vbp+170&&arr[0][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+140&&vc<vbp+170&&arr[0][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+140&&vc<vbp+170&&arr[1][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+140&&vc<vbp+170&&arr[1][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+140&&vc<vbp+170&&arr[1][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+140&&vc<vbp+170&&arr[1][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+140&&vc<vbp+170&&arr[1][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+140&&vc<vbp+170&&arr[2][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+140&&vc<vbp+170&&arr[2][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+140&&vc<vbp+170&&arr[2][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+140&&vc<vbp+170&&arr[2][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+140&&vc<vbp+170&&arr[2][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+140&&vc<vbp+170&&arr[3][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+140&&vc<vbp+170&&arr[3][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+140&&vc<vbp+170&&arr[3][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+140&&vc<vbp+170&&arr[3][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+140&&vc<vbp+170&&arr[3][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+140&&vc<vbp+170&&arr[4][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+140&&vc<vbp+170&&arr[4][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+140&&vc<vbp+170&&arr[4][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+140&&vc<vbp+170&&arr[4][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+140&&vc<vbp+170&&arr[4][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+140&&vc<vbp+170&&arr[5][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+140&&vc<vbp+170&&arr[5][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+140&&vc<vbp+170&&arr[5][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+140&&vc<vbp+170&&arr[5][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+140&&vc<vbp+170&&arr[5][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+140&&vc<vbp+170&&arr[6][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+140&&vc<vbp+170&&arr[6][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+140&&vc<vbp+170&&arr[6][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+140&&vc<vbp+170&&arr[6][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+140&&vc<vbp+170&&arr[6][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+140&&vc<vbp+170&&arr[7][3]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+140&&vc<vbp+170&&arr[7][3]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+140&&vc<vbp+170&&arr[7][3]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+140&&vc<vbp+170&&arr[7][3]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+140&&vc<vbp+170&&arr[7][3]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+170&&vc<vbp+200&&arr[0][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+170&&vc<vbp+200&&arr[0][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+170&&vc<vbp+200&&arr[0][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+170&&vc<vbp+200&&arr[0][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+170&&vc<vbp+200&&arr[0][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+170&&vc<vbp+200&&arr[1][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+170&&vc<vbp+200&&arr[1][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+170&&vc<vbp+200&&arr[1][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+170&&vc<vbp+200&&arr[1][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+170&&vc<vbp+200&&arr[1][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+170&&vc<vbp+200&&arr[2][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+170&&vc<vbp+200&&arr[2][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+170&&vc<vbp+200&&arr[2][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+170&&vc<vbp+200&&arr[2][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+170&&vc<vbp+200&&arr[2][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+170&&vc<vbp+200&&arr[3][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+170&&vc<vbp+200&&arr[3][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+170&&vc<vbp+200&&arr[3][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+170&&vc<vbp+200&&arr[3][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+170&&vc<vbp+200&&arr[3][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+170&&vc<vbp+200&&arr[4][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+170&&vc<vbp+200&&arr[4][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+170&&vc<vbp+200&&arr[4][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+170&&vc<vbp+200&&arr[4][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+170&&vc<vbp+200&&arr[4][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+170&&vc<vbp+200&&arr[5][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+170&&vc<vbp+200&&arr[5][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+170&&vc<vbp+200&&arr[5][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+170&&vc<vbp+200&&arr[5][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+170&&vc<vbp+200&&arr[5][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+170&&vc<vbp+200&&arr[6][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+170&&vc<vbp+200&&arr[6][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+170&&vc<vbp+200&&arr[6][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+170&&vc<vbp+200&&arr[6][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+170&&vc<vbp+200&&arr[6][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+170&&vc<vbp+200&&arr[7][4]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+170&&vc<vbp+200&&arr[7][4]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+170&&vc<vbp+200&&arr[7][4]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+170&&vc<vbp+200&&arr[7][4]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+170&&vc<vbp+200&&arr[7][4]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+200&&vc<vbp+230&&arr[0][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+200&&vc<vbp+230&&arr[0][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+200&&vc<vbp+230&&arr[0][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+200&&vc<vbp+230&&arr[0][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+200&&vc<vbp+230&&arr[0][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+200&&vc<vbp+230&&arr[1][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+200&&vc<vbp+230&&arr[1][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+200&&vc<vbp+230&&arr[1][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+200&&vc<vbp+230&&arr[1][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+200&&vc<vbp+230&&arr[1][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+200&&vc<vbp+230&&arr[2][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+200&&vc<vbp+230&&arr[2][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+200&&vc<vbp+230&&arr[2][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+200&&vc<vbp+230&&arr[2][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+200&&vc<vbp+230&&arr[2][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+200&&vc<vbp+230&&arr[3][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+200&&vc<vbp+230&&arr[3][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+200&&vc<vbp+230&&arr[3][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+200&&vc<vbp+230&&arr[3][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+200&&vc<vbp+230&&arr[3][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+200&&vc<vbp+230&&arr[4][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+200&&vc<vbp+230&&arr[4][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+200&&vc<vbp+230&&arr[4][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+200&&vc<vbp+230&&arr[4][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+200&&vc<vbp+230&&arr[4][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+200&&vc<vbp+230&&arr[5][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+200&&vc<vbp+230&&arr[5][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+200&&vc<vbp+230&&arr[5][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+200&&vc<vbp+230&&arr[5][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+200&&vc<vbp+230&&arr[5][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+200&&vc<vbp+230&&arr[6][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+200&&vc<vbp+230&&arr[6][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+200&&vc<vbp+230&&arr[6][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+200&&vc<vbp+230&&arr[6][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+200&&vc<vbp+230&&arr[6][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+200&&vc<vbp+230&&arr[7][5]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+200&&vc<vbp+230&&arr[7][5]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+200&&vc<vbp+230&&arr[7][5]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+200&&vc<vbp+230&&arr[7][5]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+200&&vc<vbp+230&&arr[7][5]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+230&&vc<vbp+260&&arr[0][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+230&&vc<vbp+260&&arr[0][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+230&&vc<vbp+260&&arr[0][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+230&&vc<vbp+260&&arr[0][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+230&&vc<vbp+260&&arr[0][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+230&&vc<vbp+260&&arr[1][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+230&&vc<vbp+260&&arr[1][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+230&&vc<vbp+260&&arr[1][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+230&&vc<vbp+260&&arr[1][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+230&&vc<vbp+260&&arr[1][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+230&&vc<vbp+260&&arr[2][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+230&&vc<vbp+260&&arr[2][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+230&&vc<vbp+260&&arr[2][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+230&&vc<vbp+260&&arr[2][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+230&&vc<vbp+260&&arr[2][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+230&&vc<vbp+260&&arr[3][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+230&&vc<vbp+260&&arr[3][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+230&&vc<vbp+260&&arr[3][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+230&&vc<vbp+260&&arr[3][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+230&&vc<vbp+260&&arr[3][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+230&&vc<vbp+260&&arr[4][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+230&&vc<vbp+260&&arr[4][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+230&&vc<vbp+260&&arr[4][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+230&&vc<vbp+260&&arr[4][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+230&&vc<vbp+260&&arr[4][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+230&&vc<vbp+260&&arr[5][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+230&&vc<vbp+260&&arr[5][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+230&&vc<vbp+260&&arr[5][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+230&&vc<vbp+260&&arr[5][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+230&&vc<vbp+260&&arr[5][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+230&&vc<vbp+260&&arr[6][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+230&&vc<vbp+260&&arr[6][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+230&&vc<vbp+260&&arr[6][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+230&&vc<vbp+260&&arr[6][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+230&&vc<vbp+260&&arr[6][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+230&&vc<vbp+260&&arr[7][6]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+230&&vc<vbp+260&&arr[7][6]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+230&&vc<vbp+260&&arr[7][6]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+230&&vc<vbp+260&&arr[7][6]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+230&&vc<vbp+260&&arr[7][6]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+260&&vc<vbp+290&&arr[0][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+260&&vc<vbp+290&&arr[0][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+260&&vc<vbp+290&&arr[0][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+260&&vc<vbp+290&&arr[0][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+260&&vc<vbp+290&&arr[0][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+260&&vc<vbp+290&&arr[1][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+260&&vc<vbp+290&&arr[1][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+260&&vc<vbp+290&&arr[1][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+260&&vc<vbp+290&&arr[1][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+260&&vc<vbp+290&&arr[1][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+260&&vc<vbp+290&&arr[2][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+260&&vc<vbp+290&&arr[2][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+260&&vc<vbp+290&&arr[2][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+260&&vc<vbp+290&&arr[2][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+260&&vc<vbp+290&&arr[2][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+260&&vc<vbp+290&&arr[3][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+260&&vc<vbp+290&&arr[3][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+260&&vc<vbp+290&&arr[3][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+260&&vc<vbp+290&&arr[3][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+260&&vc<vbp+290&&arr[3][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+260&&vc<vbp+290&&arr[4][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+260&&vc<vbp+290&&arr[4][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+260&&vc<vbp+290&&arr[4][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+260&&vc<vbp+290&&arr[4][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+260&&vc<vbp+290&&arr[4][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+260&&vc<vbp+290&&arr[5][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+260&&vc<vbp+290&&arr[5][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+260&&vc<vbp+290&&arr[5][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+260&&vc<vbp+290&&arr[5][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+260&&vc<vbp+290&&arr[5][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+260&&vc<vbp+290&&arr[6][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+260&&vc<vbp+290&&arr[6][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+260&&vc<vbp+290&&arr[6][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+260&&vc<vbp+290&&arr[6][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+260&&vc<vbp+290&&arr[6][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+260&&vc<vbp+290&&arr[7][7]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+260&&vc<vbp+290&&arr[7][7]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+260&&vc<vbp+290&&arr[7][7]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+260&&vc<vbp+290&&arr[7][7]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+260&&vc<vbp+290&&arr[7][7]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+290&&vc<vbp+320&&arr[0][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+290&&vc<vbp+320&&arr[0][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+290&&vc<vbp+320&&arr[0][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+290&&vc<vbp+320&&arr[0][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+290&&vc<vbp+320&&arr[0][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+290&&vc<vbp+320&&arr[1][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+290&&vc<vbp+320&&arr[1][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+290&&vc<vbp+320&&arr[1][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+290&&vc<vbp+320&&arr[1][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+290&&vc<vbp+320&&arr[1][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+290&&vc<vbp+320&&arr[2][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+290&&vc<vbp+320&&arr[2][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+290&&vc<vbp+320&&arr[2][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+290&&vc<vbp+320&&arr[2][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+290&&vc<vbp+320&&arr[2][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+290&&vc<vbp+320&&arr[3][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+290&&vc<vbp+320&&arr[3][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+290&&vc<vbp+320&&arr[3][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+290&&vc<vbp+320&&arr[3][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+290&&vc<vbp+320&&arr[3][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+290&&vc<vbp+320&&arr[4][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+290&&vc<vbp+320&&arr[4][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+290&&vc<vbp+320&&arr[4][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+290&&vc<vbp+320&&arr[4][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+290&&vc<vbp+320&&arr[4][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+290&&vc<vbp+320&&arr[5][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+290&&vc<vbp+320&&arr[5][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+290&&vc<vbp+320&&arr[5][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+290&&vc<vbp+320&&arr[5][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+290&&vc<vbp+320&&arr[5][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+290&&vc<vbp+320&&arr[6][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+290&&vc<vbp+320&&arr[6][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+290&&vc<vbp+320&&arr[6][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+290&&vc<vbp+320&&arr[6][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+290&&vc<vbp+320&&arr[6][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+290&&vc<vbp+320&&arr[7][8]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+290&&vc<vbp+320&&arr[7][8]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+290&&vc<vbp+320&&arr[7][8]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+290&&vc<vbp+320&&arr[7][8]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+290&&vc<vbp+320&&arr[7][8]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+320&&vc<vbp+350&&arr[0][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+320&&vc<vbp+350&&arr[0][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+320&&vc<vbp+350&&arr[0][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+320&&vc<vbp+350&&arr[0][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+240&& hc <hbp+270&&vc>vbp+320&&vc<vbp+350&&arr[0][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+320&&vc<vbp+350&&arr[1][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+320&&vc<vbp+350&&arr[1][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+320&&vc<vbp+350&&arr[1][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+320&&vc<vbp+350&&arr[1][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+270&& hc <hbp+300&&vc>vbp+320&&vc<vbp+350&&arr[1][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+320&&vc<vbp+350&&arr[2][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+320&&vc<vbp+350&&arr[2][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+320&&vc<vbp+350&&arr[2][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+320&&vc<vbp+350&&arr[2][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+300&& hc <hbp+330&&vc>vbp+320&&vc<vbp+350&&arr[2][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+320&&vc<vbp+350&&arr[3][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+320&&vc<vbp+350&&arr[3][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+320&&vc<vbp+350&&arr[3][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+320&&vc<vbp+350&&arr[3][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+330&& hc <hbp+360&&vc>vbp+320&&vc<vbp+350&&arr[3][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+320&&vc<vbp+350&&arr[4][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+320&&vc<vbp+350&&arr[4][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+320&&vc<vbp+350&&arr[4][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+320&&vc<vbp+350&&arr[4][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+360&& hc <hbp+390&&vc>vbp+320&&vc<vbp+350&&arr[4][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+320&&vc<vbp+350&&arr[5][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+320&&vc<vbp+350&&arr[5][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+320&&vc<vbp+350&&arr[5][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+320&&vc<vbp+350&&arr[5][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+390&& hc <hbp+420&&vc>vbp+320&&vc<vbp+350&&arr[5][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+320&&vc<vbp+350&&arr[6][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+320&&vc<vbp+350&&arr[6][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+320&&vc<vbp+350&&arr[6][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+320&&vc<vbp+350&&arr[6][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+420&& hc <hbp+450&&vc>vbp+320&&vc<vbp+350&&arr[6][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+320&&vc<vbp+350&&arr[7][9]==3'b000)
        begin
          red = 4'b1111;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+320&&vc<vbp+350&&arr[7][9]==3'b001)
        begin
          red = 4'b0000;
          green  = 4'b1111;
          blue=4'b1111;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+320&&vc<vbp+350&&arr[7][9]==3'b010)
        begin
          red = 4'b1001;
          green  = 4'b1001;
          blue=4'b1001;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+320&&vc<vbp+350&&arr[7][9]==3'b011)
        begin
          red = 4'b1111;
          green  = 4'b0000;
          blue=4'b0000;
        end
      else if (hc>hbp+450&& hc <hbp+480&&vc>vbp+320&&vc<vbp+350&&arr[7][9]==3'b100)
        begin
          red = 4'b1111;
          green  = 4'b0111;
          blue=4'b1111;
        end




      else begin 
        if (score==1 && hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)
            begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end 
        else if ((score==2) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end 
        else if ((score==3) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end 
        else if ((score==4) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end 
         else if ((score==5) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end 
         else if ((score==6) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end       
          else if ((score==7) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end      
            else if ((score==8) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end    
                else if ((score==9) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end
                else if ((score==10) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)||(hc>= 119+70 && hc<=129+70 && vc>=145&& vc<=155)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end
                else if ((score==11) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)||(hc>= 119+70 && hc<=129+70 && vc>=145&& vc<=155)||(hc>= 134+70 && hc<=144+70 &&  vc>=145&& vc<=155)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end

                else if ((score==12) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)||(hc>= 119+70 && hc<=129+70 && vc>=145&& vc<=155)||(hc>= 134+70 && hc<=144+70 &&  vc>=145&& vc<=155)||(hc>= 149+70 && hc<=159+70 && vc>=145 && vc<=155)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end
                else if ((score==13) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)||(hc>= 119+70 && hc<=129+70 && vc>=145&& vc<=155)||(hc>= 134+70 && hc<=144+70 &&  vc>=145&& vc<=155)||(hc>= 149+70 && hc<=159+70 && vc>=145 && vc<=155)||(hc>= 164+70 && hc<=174+70 &&  vc>=145 && vc<=155)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end
                else if ((score==14) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)||(hc>= 119+70 && hc<=129+70 && vc>=145&& vc<=155)||(hc>= 134+70 && hc<=144+70 &&  vc>=145&& vc<=155)||(hc>= 149+70 && hc<=159+70 && vc>=145 && vc<=155)||(hc>= 164+70 && hc<=174+70 &&  vc>=145 && vc<=155)||(hc>= 179+70 && hc<=189+70 && vc>=145&& vc<=155)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end
                else if ((score==15) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)||(hc>= 119+70 && hc<=129+70 && vc>=145&& vc<=155)||(hc>= 134+70 && hc<=144+70 &&  vc>=145&& vc<=155)||(hc>= 149+70 && hc<=159+70 && vc>=145 && vc<=155)||(hc>= 164+70 && hc<=174+70 &&  vc>=145 && vc<=155)||(hc>= 179+70 && hc<=189+70 && vc>=145&& vc<=155)||(hc>= 194+70 && hc<=204+70 && vc>=145&& vc<=155)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end
               else if ((score==16) && ((hc>= 119+70 && hc<=129+70 && vc>=130&& vc<=140)||(hc>= 134+70 && hc<=144+70 && vc>=130&& vc<=140)||(hc>= 149+70 && hc<=159+70 && vc>=130&& vc<=140)||(hc>= 164+70 && hc<=174+70 && vc>=130&& vc<=140)||(hc>= 179+70 && hc<=189+70 && vc>=130&& vc<=140)||(hc>= 194+70 && hc<=204+70 && vc>=130&& vc<=140)||(hc>= 209+70 && hc<=219+70 && vc>=130&& vc<=140)||(hc>= 224+70 && hc<=234+70 && vc>=130&& vc<=140)||(hc>= 239+70 && hc<=249+70 && vc>=130&& vc<=140)||(hc>= 119+70 && hc<=129+70 && vc>=145&& vc<=155)||(hc>= 134+70 && hc<=144+70 &&  vc>=145&& vc<=155)||(hc>= 149+70 && hc<=159+70 && vc>=145 && vc<=155)||(hc>= 164+70 && hc<=174+70 &&  vc>=145 && vc<=155)||(hc>= 179+70 && hc<=189+70 && vc>=145&& vc<=155)||(hc>= 194+70 && hc<=204+70 && vc>=145&& vc<=155)||(hc>= 209+70 && hc<=219+70 && vc>=145&& vc<=155)))
        begin
                    red = 4'b0000;
                  green  = 4'b1111;
                  blue=4'b1111;
                end



        else begin        
        red = 3'b000;
        green = 3'b000;
        blue = 2'b00;
        end

      end
end

      // we're outside active horizontal range so display black
//      red = 4'b1001;
//      green  = 4'b1001;
//      blue=4'b1001;


//      // we're outside active vertical range so display black
//      red = 4'b1001;
//          green  = 4'b1001;
//          blue=4'b1001;

    end
//assign score = score1;
endmodule
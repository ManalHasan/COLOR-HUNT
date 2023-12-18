`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/19/2016 06:10:14 PM
// Design Name: 
// Module Name: NERP_demo_top
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

module diamondExplorer(
  input wire clk,			
  input wire reset,	
  input wire start,		
  input wire right,
  input wire left,
  input wire down,
  input wire up,
  input vauxp6,               //p6, n6, p7, n7 are analog inputs for player 1
  input vauxn6,
  input vauxp7,
  input vauxn7,
  input vauxp15,                      //while these are for player 2
  input vauxn15,
  input vauxp14,
  input vauxn14,
  output wire [6:0] seg,	
  output wire [3:0] an,	
  output wire dp,			
  output wire [3:0] red,	
  output wire [3:0] green,
  output wire [3:0] blue,	
  output wire hsync,		
  output wire vsync			
);

 
  wire segclk;
  wire logicClock;
  reg [7:0][9:0][2:0]arr ;
  reg [7:0][9:0][2:0]t1 ;
  reg [9:0] x;
  reg [9:0] y;
  reg [4:0] score;
  reg [7:0] titleOutput;

  
  wire vgaClock;

 
  assign dp = 1;

wire enable;  
wire ready;
wire [15:0] data;  
reg [6:0] Address_in;  //stuff from the joystick code
reg moveright = 0;
reg moveleft = 0;
reg movedown = 0;
reg moveup = 0;

  xadc_wiz_0  XLXI_7 (.daddr_in(Address_in),
   .dclk_in(clk),
   .den_in(enable),
   .di_in(),
   .dwe_in(),
   .busy_out(),                    
   .vauxp6(vauxp6),
   .vauxn6(vauxn6),
   .vauxp7(vauxp7),
   .vauxn7(vauxn7),
   .vauxp14(vauxp14),
   .vauxn14(vauxn14),
   .vauxp15(vauxp15),
   .vauxn15(vauxn15),
   .vn_in(),
   .vp_in(),
   .alarm_out(),
   .do_out(data),
   //.reset_in(),
   .eoc_out(enable),
   .channel_out(),
   .drdy_out(ready));
   
   
 reg flip = 1'b0;                  //a curious flip... what is this? (i changed from negedge to posedge... let's see if that messes up smthn
always @(posedge vsync) begin
    flip = flip + 1;
    case (flip)                         //this part handles joystick input
    0: begin
            Address_in = 8'h16;         //move player 1 left or right
            case (data[15:12])
                    12 : begin
                  movedown<=1;
                  end         
                    12 : begin
                  movedown<=1;
                  end    
                  0 : begin
                        moveup<=1;
                  end
                default : begin
                moveup<=0;
                movedown<=0;
                end
            endcase
      end
      1: begin                                  //this one's for player 1 up and down
      Address_in = 8'h1e;
      case (data[15:12])
          12 : begin
                moveright<=1;
               end
              12 : begin
            moveright<=1;
            end
            0 : begin
                  moveleft = 1; //1
            end
            default : begin
            moveright=0;
            moveleft<=0;
            end
      endcase
      end
endcase
end

  
  clockdivider divider(
    .clk(clk),
    .reset(reset),
    .vgaClock(vgaClock),
    .segclk(segclk),
    .logicClock(logicClock)


  );


  // 7-segment display controller
  segdisplay segmentation(

    .segclk(segclk),
    .score(score),
    .reset(reset),
    .seg(seg),
    .an(an)
  );

  gameLogic mechanic(
    .logicClock(logicClock),
    .reset(reset),
    .start(start),
    .right(moveright),
    .left(moveleft),
    .up(moveup), 
    .down(movedown), 
    .horizontalPos(x),
    .verticalPos(y),
    .arr(arr),
    .t1(t1),
    .score(score),
    .titleOutput(titleOutput)
  ); 


  // VGA controller
vgaDisplay display(

    .vgaClock(vgaClock),
    .horizontalPos(x),
    .verticalPos(y),
    .reset(reset),
    .start(start),
    .arr(arr),
    .t1(t1),
    .score(score),
    .hsync(hsync),
    .vsync(vsync),
    .red(red),
    .green(green),
    .blue(blue)

  );


endmodule
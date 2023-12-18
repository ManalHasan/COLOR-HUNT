`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/25/2016 11:43:29 PM
// Design Name: 
// Module Name: gameLogic
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

module gameLogic(
  input wire logicClock,
  input wire reset,
  input wire start,
  input wire right,
  input wire left,
  input wire up,
  input wire down,
  output wire [9:0] horizontalPos,
  output wire [9:0] verticalPos,
  output wire [7:0][9:0][2:0] arr, 
  output wire [7:0][9:0][2:0] t1,
  output wire [4:0] score,
  output wire [7:0] titleOutput
);
  logic r, l ,u,d,dontstop;
  reg [4:0] score1;
  reg [9:0] x;
  reg [9:0] y;
  reg[3:0] fx;
  reg[3:0] fy;
  reg[7:0][9:0][2:0] arr2;
  reg[7:0][9:0][2:0] t;
  reg[7:0][9:0][2:0] title;
  //reg [7:0] tOutput;
  logic d1,d2,d3,d4,d5,d6,d7,d8;
  logic rr,ll,dd,uu;
  reg btn_r,btn_l,btn_u,btn_d;
  logic level1;
  logic level2;
  logic level3;
  logic win;
  logic lose;
  //assign titleOutput=tOutput;
  TitleScreen ts(
  .clk(logicClock),
  .titleOutput(titleOutput)
);
  always@(right,left,up,down,btn_r,btn_l,btn_u,btn_d)
    begin
      rr=right&~btn_r;
      ll=left&~btn_l;
      uu=up&~btn_u;
      dd=down&~btn_d;

    end

  always @(posedge logicClock or posedge reset or posedge start)
    begin
      btn_r<=right;btn_l<=left;btn_u<=up;btn_d<=down;
      // reset condition

      if (start==0) begin
      //ts.clk <= logicClock;
      //ts.titleOutput <= titleOutput;
//t[0][0] = 3'b111;
//t[1][0] = 3'b111;
//t[2][0] = 3'b111;
//t[3][0] = 3'b111;
//t[4][0] = 3'b111;
//t[5][0] = 3'b111;
//t[6][0] = 3'b111;
//t[7][0] = 3'b111;
//t[0][1] = 3'b111;
//t[1][1] = 3'b111;
//t[2][1] = 3'b111;
//t[3][1] = 3'b000;
//t[4][1] = 3'b000;
//t[5][1] = 3'b000;
//t[6][1] = 3'b000;
//t[7][1] = 3'b000;
//t[0][2] = 3'b000;
//t[1][2] = 3'b000;
//t[2][2] = 3'b000;
//t[3][2] = 3'b000;
//t[4][2] = 3'b000;
//t[5][2] = 3'b000;
//t[6][2] = 3'b000;
//t[7][2] = 3'b000;
//t[0][3] = 3'b000;
//t[1][3] = 3'b000;
//t[2][3] = 3'b000;
//t[3][3] = 3'b000;
//t[4][3] = 3'b000;
//t[5][3] = 3'b000;
//t[6][3] = 3'b000;
//t[7][3] = 3'b000;
//t[0][4] = 3'b000;
//t[1][4] = 3'b000;
//t[2][4] = 3'b000;
//t[3][4] = 3'b000;
//t[4][4] = 3'b000;
//t[5][4] = 3'b000;
//t[6][4] = 3'b000;
//t[7][4] = 3'b000;
//t[0][5] = 3'b000;
//t[1][5] = 3'b000;
//t[2][5] = 3'b000;
//t[3][5] = 3'b000;
//t[4][5] = 3'b000;
//t[5][5] = 3'b000;
//t[6][5] = 3'b000;
//t[7][5] = 3'b000;
//t[0][6] = 3'b000;
//t[1][6] = 3'b000;
//t[2][6] = 3'b000;
//t[3][6] = 3'b000;
//t[4][6] = 3'b000;
//t[5][6] = 3'b000;
//t[6][6] = 3'b000;
//t[7][6] = 3'b000;
//t[0][7] = 3'b000;
//t[1][7] = 3'b001;
//t[2][7] = 3'b000;
//t[3][7] = 3'b111;
//t[4][7] = 3'b111;
//t[5][7] = 3'b111;
//t[6][7] = 3'b111;
//t[7][7] = 3'b111;
//t[0][8] = 3'b111;
//t[1][8] = 3'b111;
//t[2][8] = 3'b111;
//t[3][8] = 3'b111;
//t[4][8] = 3'b111;
//t[5][8] = 3'b111;
//t[6][8] = 3'b111;
//t[7][8] = 3'b111;
//t[0][9] = 3'b111;
//t[1][9] = 3'b111;
//t[2][9] = 3'b111;
//t[3][9] = 3'b111;
//t[4][9] = 3'b111;
//t[5][9] = 3'b111;
//t[6][9] = 3'b111;
//t[7][9] = 3'b111;


      end 
      else begin
      if (reset == 1)
        begin
          lose=1'b0;
          level1=1'b0;
          level2=1'b0;
          score1<= 2;
          win=1'b0;
          level3=1'b0;
          d1=0;
          d2=0;
          d3=0;
          d4=0;
          d5=0;
          d6=0;
          d7=0;
          d8=0;
          dontstop=1'b1;
          arr2[0][0]=3'b000;
          arr2[1][0]=3'b000;
          arr2[2][0]=3'b000;
          arr2[3][0]=3'b000;
          arr2[4][0]=3'b000;
          arr2[5][0]=3'b000;
          arr2[6][0]=3'b000;
          arr2[7][0]=3'b000;
          arr2[0][1]=3'b000;
          arr2[1][1]=3'b000;
          arr2[2][1]=3'b000;
          arr2[3][1]=3'b000;
          arr2[4][1]=3'b000;
          arr2[5][1]=3'b000;
          arr2[6][1]=3'b000;
          arr2[7][1]=3'b000;
          arr2[0][2]=3'b000;
          arr2[1][2]=3'b000;
          arr2[2][2]=3'b000;
          arr2[3][2]=3'b000;
          arr2[4][2]=3'b000;
          arr2[5][2]=3'b000;
          arr2[6][2]=3'b000;
          arr2[7][2]=3'b000;
          arr2[0][3]=3'b000;
          arr2[1][3]=3'b000;
          arr2[2][3]=3'b000;
          arr2[3][3]=3'b000;
          arr2[4][3]=3'b000;
          arr2[5][3]=3'b000;
          arr2[6][3]=3'b000;
          arr2[7][3]=3'b000;
          arr2[0][4]=3'b010;
          arr2[1][4]=3'b001;
          arr2[2][4]=3'b000;
          arr2[3][4]=3'b000;
          arr2[4][4]=3'b100;
          arr2[5][4]=3'b000;
          arr2[6][4]=3'b000;
          arr2[7][4]=3'b000;
          arr2[0][5]=3'b000;
          arr2[1][5]=3'b000;
          arr2[2][5]=3'b000;
          arr2[3][5]=3'b000;
          arr2[4][5]=3'b011;
          arr2[5][5]=3'b000;
          arr2[6][5]=3'b000;
          arr2[7][5]=3'b000;
          arr2[0][6]=3'b000;
          arr2[1][6]=3'b000;
          arr2[2][6]=3'b000;
          arr2[3][6]=3'b000;
          arr2[4][6]=3'b000;
          arr2[5][6]=3'b000;
          arr2[6][6]=3'b000;
          arr2[7][6]=3'b000;
          arr2[0][7]=3'b000;
          arr2[1][7]=3'b001;
          arr2[2][7]=3'b000;
          arr2[3][7]=3'b000;
          arr2[4][7]=3'b000;
          arr2[5][7]=3'b000;
          arr2[6][7]=3'b000;
          arr2[7][7]=3'b000;
          arr2[0][8]=3'b000;
          arr2[1][8]=3'b000;
          arr2[2][8]=3'b000;
          arr2[3][8]=3'b000;
          arr2[4][8]=3'b000;
          arr2[5][8]=3'b000;
          arr2[6][8]=3'b000;
          arr2[7][8]=3'b000;
          arr2[0][9]=3'b000;
          arr2[1][9]=3'b000;
          arr2[2][9]=3'b000;
          arr2[3][9]=3'b000;
          arr2[4][9]=3'b000;
          arr2[5][9]=3'b000;
          arr2[6][9]=3'b000;
          arr2[7][9]=3'b000;
          x <= 384+120;
          y <= 81+60;
          r=0;l=0;u=0;d=0;
          fx<=4;
          fy<=2;

        end
      else if(lose==1'b1) begin
        x<=0;
        y<=0;
        arr2[0][0]=3'b000;
        arr2[1][0]=3'b000;
        arr2[2][0]=3'b000;
        arr2[3][0]=3'b000;
        arr2[4][0]=3'b000;
        arr2[5][0]=3'b000;
        arr2[6][0]=3'b000;
        arr2[7][0]=3'b000;
        arr2[0][1]=3'b000;
        arr2[1][1]=3'b000;
        arr2[2][1]=3'b000;
        arr2[3][1]=3'b000;
        arr2[4][1]=3'b000;
        arr2[5][1]=3'b000;
        arr2[6][1]=3'b000;
        arr2[7][1]=3'b000;
        arr2[0][2]=3'b000;
        arr2[1][2]=3'b011;
        arr2[2][2]=3'b011;
        arr2[3][2]=3'b000;
        arr2[4][2]=3'b000;
        arr2[5][2]=3'b011;
        arr2[6][2]=3'b011;
        arr2[7][2]=3'b000;
        arr2[0][3]=3'b000;
        arr2[1][3]=3'b011;
        arr2[2][3]=3'b011;
        arr2[3][3]=3'b000;
        arr2[4][3]=3'b000;
        arr2[5][3]=3'b011;
        arr2[6][3]=3'b011;
        arr2[7][3]=3'b000;
        arr2[0][4]=3'b000;
        arr2[1][4]=3'b000;
        arr2[2][4]=3'b000;
        arr2[3][4]=3'b000;
        arr2[4][4]=3'b000;
        arr2[5][4]=3'b000;
        arr2[6][4]=3'b000;
        arr2[7][4]=3'b000;
        arr2[0][5]=3'b000;
        arr2[1][5]=3'b000;
        arr2[2][5]=3'b000;
        arr2[3][5]=3'b000;
        arr2[4][5]=3'b000;
        arr2[5][5]=3'b000;
        arr2[6][5]=3'b000;
        arr2[7][5]=3'b000;
        arr2[0][6]=3'b000;
        arr2[1][6]=3'b000;
        arr2[2][6]=3'b000;
        arr2[3][6]=3'b011;
        arr2[4][6]=3'b011;
        arr2[5][6]=3'b000;
        arr2[6][6]=3'b000;
        arr2[7][6]=3'b000;
        arr2[0][7]=3'b000;
        arr2[1][7]=3'b000;
        arr2[2][7]=3'b011;
        arr2[3][7]=3'b000;
        arr2[4][7]=3'b000;
        arr2[5][7]=3'b011;
        arr2[6][7]=3'b000;
        arr2[7][7]=3'b000;
        arr2[0][8]=3'b000;
        arr2[1][8]=3'b011;
        arr2[2][8]=3'b000;
        arr2[3][8]=3'b000;
        arr2[4][8]=3'b000;
        arr2[5][8]=3'b000;
        arr2[6][8]=3'b011;
        arr2[7][8]=3'b000;
        arr2[0][9]=3'b000;
        arr2[1][9]=3'b000;
        arr2[2][9]=3'b000;
        arr2[3][9]=3'b000;
        arr2[4][9]=3'b000;
        arr2[5][9]=3'b000;
        arr2[6][9]=3'b000;
        arr2[7][9]=3'b000;



      end
      else if(win==1'b1)begin 
        x<=0;
        y<=0;
        arr2[0][0]=3'b000;
        arr2[1][0]=3'b000;
        arr2[2][0]=3'b000;
        arr2[3][0]=3'b000;
        arr2[4][0]=3'b000;
        arr2[5][0]=3'b000;
        arr2[6][0]=3'b000;
        arr2[7][0]=3'b000;
        arr2[0][1]=3'b000;
        arr2[1][1]=3'b000;
        arr2[2][1]=3'b000;
        arr2[3][1]=3'b000;
        arr2[4][1]=3'b000;
        arr2[5][1]=3'b000;
        arr2[6][1]=3'b000;
        arr2[7][1]=3'b000;
        arr2[0][2]=3'b000;
        arr2[1][2]=3'b001;
        arr2[2][2]=3'b001;
        arr2[3][2]=3'b000;
        arr2[4][2]=3'b000;
        arr2[5][2]=3'b001;
        arr2[6][2]=3'b001;
        arr2[7][2]=3'b000;
        arr2[0][3]=3'b000;
        arr2[1][3]=3'b001;
        arr2[2][3]=3'b001;
        arr2[3][3]=3'b000;
        arr2[4][3]=3'b000;
        arr2[5][3]=3'b001;
        arr2[6][3]=3'b001;
        arr2[7][3]=3'b000;
        arr2[0][4]=3'b000;
        arr2[1][4]=3'b000;
        arr2[2][4]=3'b000;
        arr2[3][4]=3'b000;
        arr2[4][4]=3'b000;
        arr2[5][4]=3'b000;
        arr2[6][4]=3'b000;
        arr2[7][4]=3'b000;
        arr2[0][5]=3'b000;
        arr2[1][5]=3'b000;
        arr2[2][5]=3'b000;
        arr2[3][5]=3'b000;
        arr2[4][5]=3'b000;
        arr2[5][5]=3'b000;
        arr2[6][5]=3'b000;
        arr2[7][5]=3'b000;
        arr2[0][6]=3'b000;
        arr2[1][6]=3'b001;
        arr2[2][6]=3'b000;
        arr2[3][6]=3'b000;
        arr2[4][6]=3'b000;
        arr2[5][6]=3'b000;
        arr2[6][6]=3'b001;
        arr2[7][6]=3'b000;
        arr2[0][7]=3'b000;
        arr2[1][7]=3'b000;
        arr2[2][7]=3'b001;
        arr2[3][7]=3'b000;
        arr2[4][7]=3'b000;
        arr2[5][7]=3'b001;
        arr2[6][7]=3'b000;
        arr2[7][7]=3'b000;
        arr2[0][8]=3'b000;
        arr2[1][8]=3'b000;
        arr2[2][8]=3'b000;
        arr2[3][8]=3'b001;
        arr2[4][8]=3'b001;
        arr2[5][8]=3'b000;
        arr2[6][8]=3'b000;
        arr2[7][8]=3'b000;
        arr2[0][9]=3'b000;
        arr2[1][9]=3'b000;
        arr2[2][9]=3'b000;
        arr2[3][9]=3'b000;
        arr2[4][9]=3'b000;
        arr2[5][9]=3'b000;
        arr2[6][9]=3'b000;
        arr2[7][9]=3'b000;


      end
      else if(level1==1'b1&&level2==1'b0&&win==1'b0)begin 
        score1<= 3;
        d1=0;
        d2=0;
        d3=0;
        d4=0;
        d5=0;
        d6=0;
        d7=0;
        d8=0;
        dontstop=1'b1;
        arr2[0][0]=3'b000;
        arr2[1][0]=3'b000;
        arr2[2][0]=3'b000;
        arr2[3][0]=3'b000;
        arr2[4][0]=3'b000;
        arr2[5][0]=3'b000;
        arr2[6][0]=3'b000;
        arr2[7][0]=3'b000;
        arr2[0][1]=3'b000;
        arr2[1][1]=3'b000;
        arr2[2][1]=3'b000;
        arr2[3][1]=3'b000;
        arr2[4][1]=3'b000;
        arr2[5][1]=3'b000;
        arr2[6][1]=3'b000;
        arr2[7][1]=3'b000;
        arr2[0][2]=3'b010;
        arr2[1][2]=3'b000;
        arr2[2][2]=3'b000;
        arr2[3][2]=3'b000;
        arr2[4][2]=3'b000;
        arr2[5][2]=3'b000;
        arr2[6][2]=3'b000;
        arr2[7][2]=3'b000;
        arr2[0][3]=3'b000;
        arr2[1][3]=3'b000;
        arr2[2][3]=3'b000;
        arr2[3][3]=3'b000;
        arr2[4][3]=3'b000;
        arr2[5][3]=3'b000;
        arr2[6][3]=3'b000;
        arr2[7][3]=3'b000;
        arr2[0][4]=3'b011;
        arr2[1][4]=3'b001;
        arr2[2][4]=3'b100;
        arr2[3][4]=3'b000;
        arr2[4][4]=3'b010;
        arr2[5][4]=3'b010;
        arr2[6][4]=3'b000;
        arr2[7][4]=3'b000;
        arr2[0][5]=3'b000;
        arr2[1][5]=3'b000;
        arr2[2][5]=3'b000;
        arr2[3][5]=3'b000;
        arr2[4][5]=3'b000;
        arr2[5][5]=3'b000;
        arr2[6][5]=3'b000;
        arr2[7][5]=3'b000;
        arr2[0][6]=3'b001;
        arr2[1][6]=3'b000;
        arr2[2][6]=3'b000;
        arr2[3][6]=3'b000;
        arr2[4][6]=3'b000;
        arr2[5][6]=3'b000;
        arr2[6][6]=3'b011;
        arr2[7][6]=3'b000;
        arr2[0][7]=3'b000;
        arr2[1][7]=3'b000;
        arr2[2][7]=3'b000;
        arr2[3][7]=3'b000;
        arr2[4][7]=3'b000;
        arr2[5][7]=3'b001;
        arr2[6][7]=3'b000;
        arr2[7][7]=3'b000;
        arr2[0][8]=3'b000;
        arr2[1][8]=3'b010;
        arr2[2][8]=3'b000;
        arr2[3][8]=3'b000;
        arr2[4][8]=3'b100;
        arr2[5][8]=3'b000;
        arr2[6][8]=3'b100;
        arr2[7][8]=3'b000;
        arr2[0][9]=3'b000;
        arr2[1][9]=3'b000;
        arr2[2][9]=3'b000;
        arr2[3][9]=3'b000;
        arr2[4][9]=3'b000;
        arr2[5][9]=3'b000;
        arr2[6][9]=3'b000;
        arr2[7][9]=3'b000;
        x <= 384+120;
        y <= 81+240;
        r=0;l=0;u=0;d=0;
        fx<=4;
        fy<=8;
        level1=1'b0;
        level2=1'b1;
      end
      
      else if(level1==1'b1&&level2==1'b1&&win==1'b0)begin 
        score1<= 16;
        d1=0;
        d2=0;
        d3=0;
        d4=0;
        d5=0;
        d6=0;
        d7=0;
        d8=0;
        dontstop=1'b1;
        arr2[0][0]=3'b000;
        arr2[1][0]=3'b011;
        arr2[2][0]=3'b100;
        arr2[3][0]=3'b100;
        arr2[4][0]=3'b010;
        arr2[5][0]=3'b001;
        arr2[6][0]=3'b010;
        arr2[7][0]=3'b001;
        arr2[0][1]=3'b100;
        arr2[1][1]=3'b000;
        arr2[2][1]=3'b010;
        arr2[3][1]=3'b010;
        arr2[4][1]=3'b011;
        arr2[5][1]=3'b100;
        arr2[6][1]=3'b001;
        arr2[7][1]=3'b001;
        arr2[0][2]=3'b100;
        arr2[1][2]=3'b100;
        arr2[2][2]=3'b011;
        arr2[3][2]=3'b000;
        arr2[4][2]=3'b100;
        arr2[5][2]=3'b001;
        arr2[6][2]=3'b011;
        arr2[7][2]=3'b010;
        arr2[0][3]=3'b001;
        arr2[1][3]=3'b001;
        arr2[2][3]=3'b010;
        arr2[3][3]=3'b000;
        arr2[4][3]=3'b000;
        arr2[5][3]=3'b000;
        arr2[6][3]=3'b100;
        arr2[7][3]=3'b100;
        arr2[0][4]=3'b011;
        arr2[1][4]=3'b001;
        arr2[2][4]=3'b001;
        arr2[3][4]=3'b011;
        arr2[4][4]=3'b000;
        arr2[5][4]=3'b100;
        arr2[6][4]=3'b010;
        arr2[7][4]=3'b011;
        arr2[0][5]=3'b100;
        arr2[1][5]=3'b010;
        arr2[2][5]=3'b000;
        arr2[3][5]=3'b011;
        arr2[4][5]=3'b010;
        arr2[5][5]=3'b011;
        arr2[6][5]=3'b011;
        arr2[7][5]=3'b000;
        arr2[0][6]=3'b001;
        arr2[1][6]=3'b000;
        arr2[2][6]=3'b100;
        arr2[3][6]=3'b011;
        arr2[4][6]=3'b000;
        arr2[5][6]=3'b010;
        arr2[6][6]=3'b100;
        arr2[7][6]=3'b010;
        arr2[0][7]=3'b010;
        arr2[1][7]=3'b000;
        arr2[2][7]=3'b100;
        arr2[3][7]=3'b010;
        arr2[4][7]=3'b011;
        arr2[5][7]=3'b001;
        arr2[6][7]=3'b000;
        arr2[7][7]=3'b010;
        arr2[0][8]=3'b001;
        arr2[1][8]=3'b001;
        arr2[2][8]=3'b011;
        arr2[3][8]=3'b001;
        arr2[4][8]=3'b011;
        arr2[5][8]=3'b001;
        arr2[6][8]=3'b100;
        arr2[7][8]=3'b000;
        arr2[0][9]=3'b001;
        arr2[1][9]=3'b010;
        arr2[2][9]=3'b100;
        arr2[3][9]=3'b000;
        arr2[4][9]=3'b000;
        arr2[5][9]=3'b000;
        arr2[6][9]=3'b010;
        arr2[7][9]=3'b100;
        x <= 384;
        y <= 81;
        r=0;l=0;u=0;d=0;
        fx<=0;
        fy<=0;
        level1=1'b0;
        level2=1'b0;
        level3=1'b1;
      end
      
      else 
        begin
          if(score==0&&r==1'b0&&l==1'b0&&u==1'b0&&d==1'b0)begin
            level1=1'b1;
            if(level3)
              win=1'b1;
          end
          if(arr2[fx][fy]==3'b001 )begin//elmas
            arr2[fx][fy]=3'b000;
            score1<=score1-1;
          end
          if(arr2[fx][fy]==3'b011)begin//bomb
            r=0;l=0;u=0;d=0;
            dontstop=1'b0;
            lose=1'b1;

          end
          if(arr2[fx][fy]==3'b100)begin//checkpoint
            r=0;l=0;u=0;d=0;
          end
          if(arr2[fx+1][fy-1]==3'b010&&d1||arr2[fx+1][fy+1]==3'b010&&d2||arr2[fx-1][fy+1]==3'b010&&d3||arr2[fx-1][fy-1]==3'b010&&d4||arr2[fx+1][fy]==3'b010&&d5||arr2[fx-1][fy]==3'b010&&d6||arr2[fx][fy-1]==3'b010&&d7||arr2[fx][fy+1]==3'b010&&d8)begin//checkpoint
            r=0;l=0;u=0;d=0;
          end
          if(rr&&ll==1'b0&&dd==1'b0&&uu==1'b0&&arr2[fx+1][fy]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            r=1;l=0;u=0;d=0;end
          if(rr==1'b0&&ll&&dd==1'b0&&uu==1'b0&&arr2[fx-1][fy]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            l=1; r=0; u=0;d=0;end
          if(rr==1'b0&&ll==1'b0&&dd==1'b0&&uu&&arr2[fx][fy-1]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            r=0;l=0;u=1;d=0;end
          if(rr==1'b0&&ll==1'b0&&dd&&uu==1'b0&&arr2[fx][fy+1]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            r=0;l=0;u=0;d=1;end

          if(rr==1'b0&&ll&&dd&&uu==1'b0&&arr2[fx-1][fy+1]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            r=0;l=1;u=0;d=1;end
          if(rr&&ll==1'b0&&dd&&uu==1'b0&&arr2[fx+1][fy+1]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            r=1;l=0;u=0;d=1;end  
          if(rr==1'b0&&ll&&dd==1'b0&&uu&&arr2[fx-1][fy-1]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            r=0;l=1;u=1;d=0;end
          if(rr&&ll==1'b0&&dd==1'b0&&uu&&arr2[fx+1][fy-1]!=3'b010&&r==1'b0&&l==1'b0&&d==1'b0&&u==1'b0)begin
            r=1;l=0;u=1;d=0;end              



          if(r&&u&&(fy==0||fx==7))begin 
            r=0;l=0;u=0;d=0;

          end
          if(r&&d&&(fy==9||fx==7))begin 
            r=0;l=0;u=0;d=0;

          end

          if(l&&d&&(fy==9||fx==0))begin 
            r=0;l=0;u=0;d=0;
          end

          if(l&&u&&(fy==0||fx==0))begin 
            r=0;l=0;u=0;d=0;
          end     
          if(r&&fx==7)begin 
            r=0;l=0;u=0;d=0;

          end 
          if(l&&(fx==0))begin 
            r=0;l=0;u=0;d=0;
          end     


          if(u&&(fy==0))begin 
            r=0;l=0;u=0;d=0;
          end
          if(d&&(fy==9))begin 
            r=0;l=0;u=0;d=0;

          end                                     



          if( r && u &&l==1'b0&&d==1'b0&&dontstop)
            begin
              d1=1;
              d2=0;
              d3=0;
              d4=0;
              d5=0;
              d6=0;
              d7=0;
              d8=0;


              x <= x + 30;
              y <= y - 30;
              fx<=fx+1;
              fy<=fy-1;



            end
          if( r && d &&l==1'b0&&u==1'b0&&dontstop )
            begin
              d1=0;
              d2=1;
              d3=0;
              d4=0;
              d5=0;
              d6=0;
              d7=0;
              d8=0;


              x <= x + 30;
              y <= y + 30;
              fx<=fx+1;
              fy<=fy+1;



            end   
          if( l && d &&r==1'b0&&u==1'b0&&dontstop  )
            begin
              d1=0;
              d2=0;
              d3=1;
              d4=0;
              d5=0;
              d6=0;
              d7=0;
              d8=0;


              fx<=fx-1;
              fy<=fy+1;
              x <= x - 30;
              y <= y + 30;



            end
          if( l && u &&r==1'b0&&d==1'b0&&dontstop  )
            begin

              d1=0;
              d2=0;
              d3=0;
              d4=1;
              d5=0;
              d6=0;
              d7=0;
              d8=0;

              x <= x - 30;
              fx<=fx-1;
              fy<=fy-1;
              y <= y - 30;



            end


          if ( r&&l==1'b0&&d==1'b0&&u==1'b0&&dontstop ) begin

            d1=0;
            d2=0;
            d3=0;
            d4=0;
            d5=1;
            d6=0;
            d7=0;
            d8=0;
            x <= x + 30;
            fx<=fx+1;
            fy<=fy;



          end
          if ( l&&u==1'b0&&d==1'b0 &&r==1'b0&&dontstop )begin

            d1=0;
            d2=0;
            d3=0;
            d4=0;
            d5=0;
            d6=1;
            d7=0;
            d8=0;
            x <= x - 30;
            fx<=fx-1;
            fy<=fy;


          end
          if( u&&r==1'b0&&d==1'b0&&l==1'b0&&dontstop )begin

            d1=0;
            d2=0;
            d3=0;
            d4=0;
            d5=0;
            d6=0;
            d7=1;
            d8=0;
            fy<=fy-1;
            y <= y - 30;



          end
          if ( d&&r==1'b0&&u==1'b0 &&l==1'b0 &&dontstop )begin

            d1=0;
            d2=0;
            d3=0;
            d4=0;
            d5=0;
            d6=0;
            d7=0;
            d8=1;
            y <= y + 30;
            fy<=fy+1;



          end
          end
        end
    end
  assign t1=t;
  assign arr=arr2;
  assign horizontalPos = x;
  assign verticalPos = y;
  assign score = score1;

endmodule
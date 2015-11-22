`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:27:52 10/29/2015 
// Design Name: 
// Module Name:    tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tb;
   reg reset;                  
   reg pause;
   reg clk;
   reg sel;
   reg adj;
   wire [7:0]min;
   wire [3:0]sec;
   initial
     begin
     clk = 0;
     pause=0;
     sel=1;
     adj=0;
	  reset=0;
     end 
 always #1 clk=~clk;

stopwatch uut_ (/*AUTOINST*/
                // Outputs
                .Clock(clk), // input
                .Sel(sel),
                .Adj(adj),
                .Reset(reset),
                .Pause(pause),
                .seg(min[7:0]),
                .an(sec[3:0])
                );
endmodule

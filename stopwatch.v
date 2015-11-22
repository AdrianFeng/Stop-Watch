`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:00 10/29/2015 
// Design Name: 
// Module Name:    stopwatch 
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
module stopwatch(
    Clock, // input
	Sel,
    Adj,
    Reset,
    Pause,
    seg,
    an
    );
input Clock;
input Sel; //out put 5 bit 
input Adj; //check the fifbit;
input Reset;
input Pause;
output [7:0]seg;
output [3:0]an;
reg [5:0] minute;
reg [5:0] second; 
reg [31:0] counter; 
reg [10:0] times;
reg [3:0] counterforrst;
reg [1:0] counterforpause;
reg [7:0] Seg;
reg [3:0] Ans;
reg [3:0] num;
wire rst;
wire pause;
wire adj;
wire sel;
reg [1:0]arst_ff;
reg [31:0]pause_ff;
reg pause1;
reg flag;
assign myreset=arst_ff[0];
assign mypause=pause_ff[0];
assign pause=Pause;
assign rst=Reset;
assign adj=Adj;
assign sel=Sel;
initial begin 
    minute=6'b000000;
    second=6'b000000;
    counter=32'b0000_0000_0000_0000_0000_0000_0000_0000;
    times=11'b000_0000_0000;
    counterforrst=4'b0000;
    counterforpause=5'b00000;
    pause1=1;
    flag=0;
end

always @(posedge Clock)begin
    counterforrst=counterforrst+1;
    if(counterforrst==4'b0000)
    begin 
        if(rst)
            arst_ff<=2'b11;
        else
            arst_ff<={1'b0, arst_ff[1]};
    end
end
always @(posedge Clock)begin
        if(pause)
            pause_ff<=32'b1111_1111_1111_1111_1111_1111_1111_1111;
        else
            pause_ff<={1'b0, pause_ff[31:1]};
    end
    
always @ (posedge Clock) begin
  
    if(mypause&&!flag) begin
            flag=1;
            pause1=~pause1;
    end
    else if(!mypause) begin
        flag=0;
    end 
    if(myreset) //reset
    begin 
    minute=6'b000000;
    second=6'b000000;
    counter=0;
    end 
    if(adj==0)
    begin
    times=times+1;
    counter=counter+1;
    end
    else 
    begin 
    times=times+1;
    counter=counter+2;
    end
    if(counter>=100000000) //change to littleclock
    begin 
    counter=0;
        if(pause1) // no pause
         begin //2
            if(sel==0) //increase minutes
            begin  //3
                minute=minute+1;
                if(minute==60)
                minute=0;
            end //3
            else  //increase seconds
            begin //4
                second=second+1;
                if(second==60)
                begin 
                    minute=minute+1;
                    second=0;
                if(minute==60)
                    minute=0;
                end
            end//4
        end //2    
    end  
    if(times==11'b110_0000_0000)
    begin
        Ans=4'b0111;
        num=minute/10;
        if(num==0)
        Seg=8'b00000011;
        else if(num==1)
        Seg=8'b10011111;
        else if (num==2)
        Seg=8'b00100101;
        else if (num==3)
        Seg=8'b00001101;
        else if (num==4)
        Seg=8'b10011001;
        else if (num==5)
        Seg=8'b01001001;
		  $display("For min2 Seg is %b num is %d, Ans is %b",Seg,num,Ans);
    end 
    else if (times==11'b100_0000_0000)
    begin
        Ans=4'b1011;
        num=minute%10;
        if(num==0)
        Seg=8'b00000011;
        else if(num==1)
        Seg=8'b10011111;
        else if (num==2)
        Seg=8'b00100101;
        else if (num==3)
        Seg=8'b00001101;
        else if (num==4)
        Seg=8'b10011001;
        else if (num==5)
        Seg=8'b01001001;
        else if(num==6)
        Seg=8'b01000001;
        else if(num==7)
        Seg=8'b00011111;
        else if(num==8)
        Seg=8'b00000001;
        else if(num==9)
        Seg=8'b00001001;
		  $display("For min1 Seg is %b num is %d, Ans is %b",Seg,num,Ans);
    end 
    else if (times==11'b010_0000_0000)
    begin 
        Ans=4'b1101;
        num=second/10;
        if(num==0)
        Seg=8'b00000011;
        else if(num==1)
        Seg=8'b10011111;
        else if (num==2)
        Seg=8'b00100101;
        else if (num==3)
        Seg=8'b00001101;
        else if (num==4)
        Seg=8'b10011001;
        else if (num==5)
        Seg=8'b01001001;
		  $display("For Sec2 Seg is %b num is %d, Ans is %b",Seg,num,Ans);
    end 
    else if (times==11'b000_0000_0000)
    begin
        Ans=4'b1110;
        num=second%10;
        if(num==0)
        Seg=8'b00000011;
        else if(num==1)
        Seg=8'b10011111;
        else if (num==2)
        Seg=8'b00100101;
        else if (num==3)
        Seg=8'b00001101;
        else if (num==4)
        Seg=8'b10011001;
        else if (num==5)
        Seg=8'b01001001;
        else if(num==6)
        Seg=8'b01000001;
        else if(num==7)
        Seg=8'b00011111;
        else if(num==8)
        Seg=8'b00000001;
        else if(num==9)
        Seg=8'b00001001;
		  $display("For Sec1 Seg is %b num is %d, Ans is %b",Seg,num,Ans);
    end    
end 

 assign an[3:0]=Ans[3:0];
 assign seg[7:0]=Seg[7:0];
 endmodule

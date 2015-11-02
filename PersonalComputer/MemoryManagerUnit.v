`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:18 05/13/2015 
// Design Name: 
// Module Name:    MemoryManagerUnit 
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
module MemoryManagerUnit(
input clk,	//very slow clock
input clk_50M,
input[14:0] MemAddr,
input MemWrite,
input SaveHalf,
input LoadHalf,
input[31:0] MemWriteData,
input rst_n,
input MemRead,
output[31:0] readData,
output reg MemOK,

output hsync, //行同步信号
output vsync, //场同步信号
output vga_r,
output vga_g,
output vga_b
    );
	 /*
reg clk;
reg clk_50M;
initial begin 
	clk = 0;
	clk_50M = 0;
end
always#10 begin
	clk_50M = ~clk_50M;
end
always#10 begin
	clk = ~clk;
end
*/
parameter width = 40;
parameter height = 25;
parameter screenBase = 14'h3000;

reg[14:0] addr;
reg we;
reg sh;
reg lh;
reg[31:0] writeData;
reg[1:0] state;
initial begin
	addr <= 0;
	we <= 0;
	sh <= 0;
	lh <= 0;
	writeData <= 0;
	state <= 0;
end

always@(posedge clk) begin
	if(state == 0) begin
		if(MemRead | MemWrite) begin
			state <= 1;
			addr <= MemAddr;
			we <= MemWrite;
			sh <= SaveHalf;
			lh <= LoadHalf;
			writeData <= MemWriteData;
		end
		else begin
			state <= 0;
		end
	end
	else if(state == 1) begin
		state <= 2;
		MemOK <= 1;
	end
	else if(state == 2) begin
		state <= 0;
		MemOK <= 0;
	end
end

wire[14:0] ZBadr;
wire[15:0] outB;
Memory Mem (
    .clk(clk_50M), 
    .adrA(addr), 
    .adrB(ZBadr), 
    .we( we ), 
    .data(writeData), 
    .sh(sh), 
	 .lh(lh),
    .outA(readData), 
    .outB(outB)
    );

reg[15:0] ZBcode;
wire [9:0] xpos,ypos;
wire valid;
vga_dis vga (
    .clk(clk_50M), //input
    .rst_n(rst_n), 
    .ZBcode(ZBcode), 
	 .valid(valid), //output
    .xpos(xpos[9:0]), 
    .ypos(ypos[9:0]), 
    .hsync(hsync), 
    .vsync(vsync), 
    .vga_r(vga_r), 
    .vga_g(vga_g), 
    .vga_b(vga_b)
    );
	 
wire[14:0] offset;
assign ZBadr = screenBase+offset;
wire[14:0] lineBase;
assign lineBase = ypos[9:4]*width;
assign offset =(xpos[9:4]== width-1)?(
						(ypos[3:0]==4'hf)?(
							(ypos[9:4]==height-1)? 10'd0 : (lineBase + xpos[9:4] +1)
						) : lineBase
					) : (lineBase + xpos[9:4] + 1);

always @(posedge clk_50M) begin
    if(xpos[3:0] == 4'he && valid) begin
        ZBcode <= outB;
    end
end
endmodule

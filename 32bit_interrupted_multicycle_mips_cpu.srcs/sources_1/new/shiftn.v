`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.07.2019 07:17:59
// Design Name: 
// Module Name: shiftn
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


module shiftn(Din, replace, Dout);

parameter n = 32;
parameter shift = 2;

input [n-1:0] Din;
input [shift-1:0] replace;
output [n-1:0] Dout;
assign Dout = {Din[n-1-shift:0], replace};

endmodule

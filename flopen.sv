`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Javier Cienfuegos Jr.
// 
// Create Date: 11/03/2019 12:31:10 PM
// Design Name: flopen
// Module Name: flopen
// Project Name: N-bit Enable Register
// Target Devices: 
// Tool Versions: 
// Description: An N-bit Flip-flop register with enable input
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flopen # (parameter N = 16) (
    input clk,
    input en,
    input [0:0] d,
    output reg [0:0] q
    );
    
    always @(posedge clk)
        if (en) q <= d;
endmodule

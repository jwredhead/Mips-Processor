`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Javier Cienfuegos Jr.
// 
// Create Date: 11/03/2019 12:31:10 PM
// Design Name: flop
// Module Name: flop
// Project Name: N-bit Register
// Target Devices: 
// Tool Versions: 
// Description: N-bit Flip-flop register
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flop # (parameter N = 16) (
    input clk,
    input [N-1:0] d,
    output reg [N-1:0] q
    );
    
    always @(posedge clk)
        q <= d;
endmodule

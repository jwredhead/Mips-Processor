`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Javier Cienfuegos Jr.
// 
// Create Date: 11/03/2019 12:31:10 PM
// Design Name: flopenr
// Module Name: flopenr
// Project Name: flopenr
// Target Devices: 
// Tool Versions: 
// Description: N-bit Flip-flop register with enable and reset inputs
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flopenr # (parameter N = 16)(
    input clk, reset, en,
    input [N-1: 0] d,
    output reg [N-1: 0] q
    );
    always @(posedge clk)
        if (reset) q <= 0;
        else if (en) q <= d;
endmodule

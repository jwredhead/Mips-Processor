`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Javier Cienfuegos Jr.
// 
// Create Date: 11/03/2019 12:31:10 PM
// Design Name: mux4
// Module Name: mux4
// Project Name: mux4
// Target Devices: 
// Tool Versions: 
// Description: 4-way MUX for N-bit data
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux4 # (parameter N = 16)(
    input [N-1: 0] d0, d1, d2, d3,
    input [1: 0] s,
    output reg [N-1: 0] y
    );
    always @(*)
        case(s)
            2'b00: y <= d0;
            2'b01: y <= d1;
            2'b10: y <= d2;
            2'b11: y <= d3;
        endcase
endmodule

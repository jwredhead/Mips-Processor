`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/03/2019 12:31:10 PM
// Design Name: 
// Module Name: mux2
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


module mux2 # (parameter N = 16)(
    input [N-1: 0] d0, d1,
    input s,
    output reg [N-1: 0] y
    );
    always @(*)
        case(s)
            1'b0: y <= d0;
            1'b1: y <= d1;
        endcase
endmodule

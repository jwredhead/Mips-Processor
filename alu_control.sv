/******************************************************************************** 
  File:           alu_control.sv
  Description:   	This module implements the alu control module for the MIPS Processor.
												
						Inputs:
						funct - Bits [5:0] of Encoded Instruction
						aluop - Control Signal from MIPS Control module
						
						Outputs:
						alucontrol - Control Signal to MIPS ALU module

						The mapping for alucontrol signal is the following:
						0: Addition
						1: Subtraction
						2: Bitwise And
						3: Bitwise Or
						4: Bitwise Nor
						5: Set Less Than
						6: Shift Left Logical
						7: Shift Right Logical
						
					When invalid funct or aluop is recieved, alucontrol defaults to 
					the And operation, alucontrol = 0
						
  Date:           October 2019
  Author:         Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // Timescale for Test Bench, ignored during synthesis
module alu_control (funct, aluop, alucontrol);

	// Inputs
	input logic [5:0] funct;
	input logic [2:0] aluop;
	
	// Outputs
	output logic [3:0] alucontrol;
	
	always_comb
		case (aluop)
			3'b000:	alucontrol = 4'b0000;
			3'b001:	alucontrol = 4'b0001;
			3'b010:	case(funct)
							6'b000000: alucontrol = 4'b0110;
							6'b000010: alucontrol = 4'b0111;
							6'b100000: alucontrol = 4'b0000;
							6'b100001: alucontrol = 4'b0000;
							6'b100010: alucontrol = 4'b0001;
							6'b100011: alucontrol = 4'b0001;
							6'b100100: alucontrol = 4'b0010;
							6'b100101: alucontrol = 4'b0011;
							6'b100111: alucontrol = 4'b0100;
							6'b101010: alucontrol = 4'b0101;
							6'b101011: alucontrol = 4'b0101;
							default: alucontrol = 4'b0000;
						endcase
			3'b011: 	alucontrol = 4'b1000;
			3'b100:	alucontrol = 4'b0000;
			3'b101:	alucontrol = 4'b0101;
			3'b110:	alucontrol = 4'b0010;
			3'b111:	alucontrol = 4'b0011;
		endcase
	
endmodule

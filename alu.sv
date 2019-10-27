/******************************************************************************** 
  File:           alu.sv
  Description:   	This module implements the ALU, Arithmetic Logic Unit for the MIPS Processor.
						The implemenation defaults to 2 32-bit operands, but using the
						parameter N to have 2 N-bit operands.
						
						Inputs:
						a - First Operand
						b - Second Operand
						aluControl - Operation Bit Vector
						
						Outputs:
						aluResult - Result from operation
						zero - Zero used for branch
						
						ALU is responsible for the following operations:
							ADD - Addition
							SUB - Subtraction
							AND - Bitwise And
							OR - Bitwise Or
							NOR - Bitwise Nor
							SLT - Set Less Than
							SLL - Shift Left Logical
							SRL - Shift Right Logical
						
  Date:           October 2019
  Author:         Javier Cienfuegos, jc0112@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // Timescale for Test Bench, ignored during synthesis

module alu
	#(parameter N = 32)
	(a, b, aluControl, aluResult, zero);
	
	// Signals for inputs
	input logic [N-1:0] a, b;
	input logic [2:0] aluControl;
	
	// Signals for outputs
	output logic [N-1:0] aluResult;
	output logic zero;
	
	assign zero = (aluResult == 0);
	
	always_comb
		case (aluControl)
			0: aluResult = a + b;
			1: aluResult = a - b;
			2: aluResult = a & b;
			3: aluResult = a | b;
			4: aluResult = ~(a | b);
			5: begin
			 if (a[N-1] && !b[N-1])
			     aluResult = 1;
			 else if (!a[N-1] && !b[N-1])
			     aluResult = a[N-2: 0] < b[N-2: 0];
			 else if (a[N-1] && b[N-1]) begin
			     aluResult = b[N-2:0] < a[N-2:0];
			 end else
			     aluResult = 0;
			end
		endcase
endmodule
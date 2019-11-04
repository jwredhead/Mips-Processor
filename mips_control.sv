/******************************************************************************** 
  File:           mips_control.sv
  Description:   	This module implements the mips control FSM for the MIPS Processor.
												
						Inputs:
						clk - Clock Input
						reset  - Reset
						op - Instruction bits [31:26]
												
						Outputs:
						memwrite - Control Signal to write to memory 
						memread - Control Signal to read from memory
						alusrca - Control Signal for ALUSRCA mux
						alusrcb - Control Signal for ALUSRCB mux
						pcen - Control Signal to allow update of PC register
						pcsource - Control Signal for PCSOURCE mux
						memtoreg - Control Signal for MEMDATAREG mux
						regdst - Control Signal for REGDEST mux
						iord - Control Signal for INSTR_DESTADDRESS mux
						regwrite - Control Signal for enabling writes to register file
						irwrite - Control Signal for enabling writes to Instruction register
						aluop - Control Signal for ALU Control module
						
						States:
						IF - Instruction Fetch
						ID - Instruction Decode
						MAC - Memory Address Computation for LW/SW
						MAR - Memory Access Read for LW
						MAW - Memory Access Write for SW
						WB - Write Back for LW
						EX - Execution for R Instruction
						RC - R Instruction Completion
						BC - Branch Completion
						JC - Jump Completion
						
						Instruction Decoding
						During instruction decoding stage this is how the op input signal is decoded:
						if op = 0, R-type instruction, follow EX -> RC -> IF path
						if op[5] = 1, SW/LW instruction follow the following paths:
							if op[3] = 1, SW instruction, follow MAC -> MAW -> IF path
							if op[3] = 0, LW instruction, follow MAC -> MAR -> WB -> IF path
						if op[2] = 1, Branch instruction, follow BC -> IF path
						if op[1] = 1, Branch instruction, follow JC -> IF path
						
						otherwise return to IF state as instruction is not implemented
						
  Date:           October 2019
  Author:         Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // Timescale for Test Bench, ignored during synthesis

module mips_control(clk, reset, op, memwrite, memread, alusrca, alusrcb, pcen, pcsource, memtoreg, regdst, iord, regwrite, irwrite, aluop);

	// Inputs
	input logic clk, reset;
	input logic [5:0] op;
	
	// Outputs
	output logic memwrite, memread, alusrca, pcen, memtoreg, regdst, iord, regwrite, irwrite;
	output logic [1:0] alusrcb, pcsource, aluop;
	
	typedef enum logic [3:0] {IF, ID, MAC, MAR, MAW, WB, EX, RC, BC, JC} statetype;
	
	statetype CS, NS;
	
	// State Flip-Flops
	always_ff @(posedge clk)
	begin: state_ffs
		if (reset) CS <= IF;
		else CS <= NS;
	end // state_ffs
	
	// State Table
	always_comb
	begin: state_table
		case (CS)
			IF: 	NS = ID;
			ID: 	casez (op)
						6'b000000: 	NS = EX;
						6'b1??00?: 	NS = MAC;
						6'b0??10?: 	NS = BC;
						6'b0??01?: 	NS = JC;
						default:		NS = IF;
					endcase
			MAC:	if (op[3]) NS = MAW;
					else NS = MAR;
			MAR:	NS = WB;
			MAW:	NS = IF;
			WB:	NS = IF;
			EX:	NS = RC;
			RC:	NS = IF;
			BC:	NS = IF;
			JC:	NS = IF;
		default: NS = IF;
		endcase
	end
		
	// Outputs
	assign memwrite = (CS == MAW);
	assign memread = 	(CS == IF) || (CS == MAR) || (CS == WB);
	assign pcen = 		(CS == IF) || (CS == BC) || (CS == JC);
	assign memtoreg = (CS == WB);
	assign regdst = 	(CS == RC);
	assign iord = 		(CS > MAC) && (CS < EX);
	assign regwrite =	(CS == RC) || (CS == WB);
	assign irwrite = 	(CS == IF);
	assign alusrca =	(CS > ID) && (CS < JC);
	assign alusrcb = 	((CS > WB) && (CS < JC)) ? 2'b00 :
							((CS > ID) && (CS < EX)) ? 2'b10 :
							(CS == ID) ? 2'b11:
							2'b01;	
	assign pcsource =	(CS == JC) ? 2'b10 :
							(CS == BC) ? 2'b01 :
							2'b00;
	assign aluop = 	((CS == EX) || (CS == RC)) ? 2'b10 :
							(CS == BC) ? 2'b01 :
							2'b00;
	endmodule
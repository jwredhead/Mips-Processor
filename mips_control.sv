/******************************************************************************** 
  File:           mips_control.sv
  Description:   	This module implements the mips control FSM for the MIPS Processor.
												
						Inputs:
						clk - Clock Input
						reset  - Write Enable
						op - Read Address 0
												
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

module mips_control(clk, reset, op, memwrite, memread, alusrca, alusrcb, pcwrite, pcwriteCond, pcsource, memtoreg, regdst, iord, regwrite, irwrite, aluop);

	// Inputs
	input logic clk, reset;
	input logic [5:0] op;
	
	// Outputs
	output logic memwrite, memread, alusrca, pcwrite, pcwriteCond, memtoreg, regdst, iord, regwrite, irwrite;
	output logic [1:0] alusrcb, pcsource;
	output logic [2:0] aluop;
	
	typedef enum logic [3:0] {IF, ID, EXI, RCI, MAC, MAR, MAW, WB, EX, RC, BC, BNC, JC} statetype;
	
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
						6'b1?????: 	NS = MAC;
						6'b000100: 	NS = BC;
						6'b000101:	NS = BNC;
						6'b00001?: 	NS = JC;
						6'b001???:	NS = EXI;
						default:		NS = IF;
					endcase
			MAC:	if (op[3]) NS = MAW;
					else NS = MAR;
			MAR:	NS = WB;
			MAW:	NS = IF;
			WB:	NS = IF;
			EX:	NS = RC;
			EXI:	NS = RCI;
			RC:	NS = IF;
			RCI:	NS = IF;
			BC:	NS = IF;
			BNC:	NS = IF;
			JC:	NS = IF;
		default: NS = IF;
		endcase
	end
	
	always_comb
	begin: aluop_table
		case (CS)
			IF:	aluop = 3'b000;
			ID:	aluop = 3'b000;
			MAC:	aluop = 3'b000;
			MAR:	aluop = 3'b000;
			MAW:	aluop = 3'b000;
			WB:	aluop = 3'b000;
			EX:	aluop = 3'b010;
			EXI:	case (op[2:0])
						3'b000:	aluop = 3'b100;
						3'b100:	aluop = 3'b110;
						3'b101:	aluop = 3'b111;
						3'b010:	aluop = 3'b101;
					default: aluop = 3'b000;
					endcase
			RC:	aluop = 3'b010;
			RCI:	case (op[2:0])
						3'b000:	aluop = 3'b100;
						3'b100:	aluop = 3'b110;
						3'b101:	aluop = 3'b111;
						3'b010:	aluop = 3'b101;
					default: aluop = 3'b000;
					endcase
			BC:	aluop = 3'b001;
			BNC:	aluop = 3'b011;
			JC:	aluop = 3'b000;
		default:	aluop = 3'b111;
		endcase
	end
		
	// Outputs
	assign memwrite = 	(CS == MAW);
	assign memread = 		(CS == IF) || (CS == MAR) || (CS == WB);
	assign pcwrite = 		(CS == IF) || (CS == JC);
	assign pcwriteCond=	(CS == BC) || (CS == BNC);
	assign memtoreg = 	(CS == WB);
	assign regdst = 		(CS == RC);
	assign iord = 			(CS > MAC) && (CS < EX);
	assign regwrite =		(CS == RC) || (CS == RCI) || (CS == WB);
	assign irwrite = 		(CS == IF);
	assign alusrca =		(CS > ID) && (CS < JC);
	assign alusrcb = 		((CS > WB) && (CS < JC)) ? 2'b00 :
								((CS > ID) && (CS < EX)) ? 2'b10 :
								(CS == ID) ? 2'b11:
								2'b01;	
	assign pcsource =		(CS == JC) ? 2'b10 :
								((CS == BC) || (CS == BNC)) ? 2'b01 :
								2'b00;
endmodule
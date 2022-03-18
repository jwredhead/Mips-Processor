/******************************************************************************** 
  File:           datapath.sv
  Description:   	This module implements the datapath module of the MIPS processor.
  
						Inputs:
						clk - Clock Signal
						reset - Reset Signal
						memdata - Data read from off processor memory
						alusrca - Control Signal for ALUSRCA mux
						alusrcb - Control Signal for ALUSRCB mux
						pcen - Control Signal to allow update of PC register
						pcsource - Control Signal for PCSOURCE mux
						memtoreg - Control Signal for MEMDATAREG mu
						regdst - Control Signal for REGDEST mux
						iord - Control Signal for INSTR_DESTADDRESS mux
						regwrite - Control Signal for enabling writes to register file
						irwrite - Control Signal for enabling writes to Instruction register
						alucontrol - Control Signal for MIPS ALU module
						
						Outputs:
						addr - Address for reading to or writing from off processor memory
						writedata - Data to be written to off processory memory
						op - Instruction bits [31:26]
						zero - Zero bit from ALU
						funct - Instruction bits [5:0]
                  
  Date:           October 2019
  Author:        	Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // Timescale for Test Bench, ignored during synthesis
module mips_datapath (clk, reset, memdata, alusrca, alusrcb, pcwrite, pcwriteCond, pcsource, memtoreg, regdst, iord, regwrite, irwrite, alucontrol,
								addr, writedata, op, zero, funct);
								
	// Inputs
	input logic clk, reset, alusrca, pcwrite, pcwriteCond, memtoreg, regdst, iord, regwrite, irwrite;
	input logic [1:0] alusrcb, pcsource;
	input logic [3:0] alucontrol;
	input logic [31:0] memdata;
	
	// Outputs
	output logic zero;
	output logic [5:0] op, funct;
	output logic [31:0] addr, writedata;
	
	// Internal Signals
	logic [31:0] pcIn, pcOut, instruct, memOut, aluInA, aluInB, aluOut, Ain, Aout, Bin, Bout, wrData, aluResult;
	logic [4:0] wrAddr, shamt;
	logic pc_enable, pcen;
	
	// PC Enable
	assign pcen = pcwriteCond & zero;
	assign pc_enable = pcwrite | pcen;
	
	// PC
	register #(32) PC(clk, reset, pc_enable, pcIn, pcOut);
	
	// Instruction Register
	register #(32) IR(clk, reset, irwrite, memdata, instruct); 
	
	// Memory Data Register
	register #(32) MDR(clk, reset, 1'b1, memdata, memOut);
	
	// A Register
	register #(32) A(clk, reset, 1'b1, Ain, Aout);
	
	// B Register
	register #(32) B(clk, reset, 1'b1, Bin, Bout);
	
	// Register File
	reg_file Registers(clk, regwrite, instruct[25:21], instruct[20:16], wrAddr, Ain, Bin, wrData);
	
	// Register Write Mux
	assign wrAddr = (regdst) ? instruct[15:11] : instruct[20:16];
	assign wrData = (memtoreg) ? memOut : aluOut;
	
	// Shamt
	assign shamt = instruct[10:6];
	
	// ALU Input Muxes
	assign aluInA = (alusrca) ? Aout : pcOut;
	assign aluInB = (alusrcb == 2'b00) ? Bout : 
							(alusrcb == 2'b10) ? {16'h0000,instruct[15:0]} :
							(alusrcb == 2'b11) ? {16'h0000,instruct[15:0]} : 32'd1;
	
	// ALU
	alu m_alu (aluInA, aluInB, alucontrol, shamt, aluResult, zero);
	
	// ALU Output Register
	register #(32) aluOutReg(clk, reset, 1'b1, aluResult, aluOut);
	
	// PC Source Mux
	assign pcIn = (pcsource == 2'b00) ? aluResult :
						(pcsource == 2'b01) ? aluOut :
						(pcsource == 2'b10) ? {6'd0,instruct[25:0]}: 32'd0;
	
	// Instruction Outputs
	assign op = instruct[31:26];
	assign funct = instruct[5:0];
	
	// Memory I/O
	assign addr = (iord) ? aluOut : pcOut;
	assign writedata = Bout;

endmodule

	
	
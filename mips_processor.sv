/******************************************************************************** 
  File:           mips_processor.sv
  Description:   	This module implements the top module of the MIPS processor
						
						Inputs:
						clk - Clock Signal
						reset - Reset Signal
						memdata - Data read from off processor memory
						
						Outputs:
						addr - Address for reading to or writing from off processor memory
						memread - Control Signal to read from off processor memory
						memwrite - Control Signal to write to off processor memory
						writedata - Data to be written to off processory memory
						

                  
  Date:           October 2019
  Author:        	Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
module mips_processor (clk, reset, memdata, addr, memread, memwrite, writedata);

	// Inputs
	input logic clk, reset;
	input logic [31:0] memdata;
	
	// Outputs
	output logic memread, memwrite;
	output logic [31:0] addr, writedata;
	
	// Internal Signals
	logic alusrca, pcen, memtoreg, regdst, iord, regwrite, irwrite, zero;
	logic [1:0] aluop, alusrcb, pcsource;
	logic [2:0] alucontrol;
	logic [5:0] op, funct;
	
	// MIPS Controller
	mips_control control(clk, reset, op, memwrite, memread, alusrca, alusrcb, pcen, pcsource, memtoreg, regdst, iord, regwrite, irwrite, aluop);
	
	// ALU Controller
	alu_control a_control(funct, aluop, alucontrol);
	
	// MIPS Datapath
	mips_datapath datapath(clk, reset, memdata, alusrca, alusrcb, pcen, pcsource, memtoreg, regdst, iord, regwrite, irwrite, alucontrol,
								addr, writedata, op, zero, funct);
								
endmodule
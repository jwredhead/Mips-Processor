/******************************************************************************** 
  File:           reg_file.sv
  Description:   	This module implements the register file for the MIPS Processor.
						The implemenation defaults to 32 32-bit registers, but using the
						parameters N and M can be set to 2^N M-bit registers.
						
						Inputs:
						clk - Clock Input
						we  - Write Enable
						rdAddr0 - Read Address 0
						rdAddr1 - Read Address 1
						wrAddr  - Write Address
						wrData  - Write Data
						
						Outputs:
						rdData0 - Read Data 0
						rdData1 - Read Data 1
						
						Writes are synchronous on the rising clock edge. If Write Enable 
						is high, the address specified by Write Address is written to the
						value specified in Write Data.
						
						Reads are assynchronous, and are always equal to the value specified
						by the value on the corresponding Read Address.
						
  Date:           October 2019
  Author:         Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // Timescale for Test Bench, ignored during synthesis

module reg_file
	#(parameter N=5, M=32)
	(clk, we, rdAddr0, rdAddr1, wrAddr, rdData0, rdData1, wrData);
	
	// Signals for inputs
	input logic clk, we;
	input logic[N-1:0] rdAddr0, rdAddr1, wrAddr;
	input logic[M-1:0] wrData;
	
	// Signals for outputs
	output logic [M-1:0] rdData0, rdData1;
	
	logic [M-1:0] mem[2**N-1:0];
	
	always @(posedge clk)
		if (we) mem[wrAddr] = wrData;
		
	assign rdData0 = mem[rdAddr0];
	assign rdData1 = mem[rdAddr1];
	
endmodule

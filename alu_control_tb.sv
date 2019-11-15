/******************************************************************************** 
  File:           mips_control_tb.sv
  Description:   	This module implements the test bench of the alu control FSM for the MIPS Processor.					
  Date:           October 2019
  Author:         Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // time scale
module alu_control_tb ();

	// Wires for inputs
	logic [5:0] funct;
	logic [2:0] aluop;
	
	// Wires for outputs
	logic [3:0] alucontrol;
	
	// Wires for expected outputs
	logic [3:0] alucontrol_exp;
	
	// Test Vector Wires
	logic[15:0] vectornum, errors;
	logic [12:0] testvectors[512:0];
	
	// Clock Signal
	logic clk;
	
	// DUT
	alu_control dut(funct, aluop, alucontrol);
	
	always
	begin
		clk = 0; #2; clk = 1; #2;
	end
	
	initial
	begin 
		$monitor ("time=%5d ns, funct=%b, aluop=%b, alucontrol=%b", $time, funct, aluop, alucontrol);
		$readmemb("alu_control.tv", testvectors);
		vectornum = 0; errors = 0;
	end
	
	always @(negedge clk)
	begin
		#1; {funct, aluop, alucontrol_exp} = testvectors[vectornum];
	end
	
	always @(posedge clk)
	begin
		#1;
		if (alucontrol != alucontrol_exp)
		begin
			$display ("Error: Inputs- funct=%b, aluop=%b", funct, aluop);
			$display ("Outputs- alucontrol=%b (%b expected)", alucontrol, alucontrol_exp);
			errors = errors + 1;
		end
		vectornum = vectornum + 1;
		if (testvectors[vectornum] == 'bx) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$finish;
		end
	end
endmodule
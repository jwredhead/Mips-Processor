/******************************************************************************** 
  File:           mips_control_tb.sv
  Description:   	This module implements the test bench of the  mips control FSM for the MIPS Processor.					
  Date:           October 2019
  Author:         Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // time scale
module mips_control_tb();
	
	// Wires for inputs
	logic clk, reset;
	logic [5:0]op;
	
	// Wires for outputs
	logic memwrite, memread, alusrca, pcen, memtoreg, regdst, iord, regwrite, irwrite;
	logic [1:0] alusrcb, pcsource, aluop;
	
	// Wires for expected outputs
	logic memwrite_exp, memread_exp, alusrca_exp, pcen_exp, memtoreg_exp, regdst_exp, iord_exp, regwrite_exp, irwrite_exp;
	logic [1:0] alusrcb_exp, pcsource_exp, aluop_exp;
	
	// Test Vector Wires
	logic[15:0] vectornum, errors;
	logic [21:0] testvectors[100:0];
	
	// DUT
	mips_control dut(clk, reset, op, memwrite, memread, alusrca, alusrcb, pcen, pcsource, memtoreg, regdst, iord, regwrite, irwrite, aluop);
	
	always
	begin
		clk = 0; #2; clk = 1; #2;
	end
	
	initial
	begin 
		$monitor ("time=%5d ns, clk=%b, reset=%b, op=%b, memwrite=%b, memread=%b, alusrca=%b, alusrcb=%b, pcen=%b, pcsource=%b, memtoreg=%b, regdst=%b, iord=%b, regwrite=%b, irwrite=%b, aluop=%b",
						$time, clk, reset, op, memwrite, memread, alusrca, alusrcb, pcen, pcsource, memtoreg, regdst, iord, regwrite, irwrite, aluop);
		$readmemb("mips_control.tv", testvectors);
		vectornum = 0; errors = 0;
	end
	
	always @(negedge clk)
	begin
		
		#1; {reset, op, memwrite_exp, memread_exp, alusrca_exp, alusrcb_exp, pcen_exp, pcsource_exp, memtoreg_exp, regdst_exp, iord_exp, regwrite_exp, irwrite_exp, aluop_exp} = testvectors[vectornum];
	end
	
	always @(posedge clk)
	begin
		#1;
		if (memwrite != memwrite_exp ||
			memread != memread_exp ||
			alusrca != alusrca_exp ||
			alusrcb != alusrcb_exp ||
			pcen != pcen_exp ||
			pcsource != pcsource_exp ||
			memtoreg != memtoreg_exp ||
			regdst != regdst_exp ||
			iord != iord_exp ||
			memwrite != memwrite_exp ||
			regwrite != regwrite_exp ||
			irwrite != irwrite_exp ||
			aluop != aluop_exp)
		begin
			$display ("Error: Inputs- reset=%b, op=%b", reset, op);
			$display ("Outputs- memwrite=%b (%b expected), memread=%b (%b expected), alusrca=%b (%b expected), alusrcb=%b (%b expected), pcen=%b (%b expected), pcsource=%b (%b expected), memtoreg=%b (%b expected), regdst=%b (%b expected), iord=%b (%b expected), regwrite=%b (%b expected), irwrite=%b (%b expected), aluop=%b (%b expected)",
							memwrite, memwrite_exp, memread, memread_exp, alusrca, alusrca_exp, alusrcb, alusrcb_exp, pcen, pcen_exp, pcsource, pcsource_exp, memtoreg, memtoreg_exp, regdst, regdst_exp, iord, iord_exp, regwrite, regwrite_exp, irwrite, irwrite_exp, aluop, aluop_exp);
			errors = errors + 1;
		end
		vectornum = vectornum + 1;
		if (testvectors[vectornum] == 'bx) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$finish;
		end
	end
endmodule
	
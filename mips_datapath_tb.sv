/******************************************************************************** 
  File:           mips_datapath_tb.sv
  Description:   	This module implements the test bench of the MIPS Datapath.					
  Date:           October 2019
  Author:         Javier Cienfuegos Jr., jc0112@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // time scale
module mips_datapath_tb();
	
	// Wires for inputs
	// Inputs
	logic clk, reset, alusrca, pcen, memtoreg, regdst, iord, regwrite, irwrite;
	logic [1:0] alusrcb, pcsource;
	logic [2:0] alucontrol;
	logic [31:0] memdata;
	
	// Outputs
	logic zero;
	logic [5:0] op, funct;
	logic [31:0] addr, writedata;
	
	// Wires for expected outputs
	logic zero_exp;
	logic [5:0] op_exp, funct_exp;
	logic [31:0] addr_exp, writedata_exp;
	
	// Test Vector Wires
	logic[15:0] vectornum, errors;
	logic [21:0] testvectors[100:0];
	
	// DUT
	mips_datapath dut(clk, reset, memdata, alusrca, alusrcb, pcen, pcsource, memtoreg, regdst, iord, regwrite, irwrite, alucontrol,
					addr, writedata, op, zero, funct);
	
	always
	begin
		clk = 0; #5; clk = 1; #5;
	end
	
	initial
	begin 
		$monitor ("time=%5d ns, clk=%b, reset=%b, alusrca=%b, pcen=%b, memtoreg=%b, regdst=%h, iord=%b, regwrite=%b, irwrite=%b, alusrcb=%h, pcsource=%h, alucontrol=%h, memdata=%h, zero=%b, op=%h, funct=%h, addr=%h, writedata=%h",
						$time, clk, reset, alusrca, pcen, memtoreg, regdst, iord, regwrite, irwrite, alusrcb, pcsource, alucontrol, memdata, zero, op, funct, addr, writedata);
		$readmemh("mips_datapath.tv", testvectors);
		vectornum = 0; errors = 0;
	end
	
	always @(negedge clk)
	begin
		
		#1; {reset, alusrca, alusrcb, pcen, pcsource, memtoreg, regdst, iord, regwrite, irwrite, alucontrol, zero_exp, op_exp, funct_exp, addr_exp, writedata_exp} = testvectors[vectornum];
	end

	always @(posedge clk)
	begin
		#1;
		if (zero != zero_exp ||
			op != op_exp ||
			funct != funct_exp ||
			addr != addr_exp ||
			writedata != writedata_exp)
		begin
			$display ("Error: Inputs- reset=%b,", reset,
					"alusrca=%b", alusrca,
					"pcen=%b", pcen,
					"memtoreg=%b", memtoreg,
					"regdst=%b", regdst,
					"iord=%b", iord,
					"regwrite=%b", regwrite,
					"irwrite=%b", irwrite,
					"alusrcb=%h", alusrcb,
					"pcsource=%h", pcsource,
					"alucontrol=%h", alucontrol,
					"memdata=%h", memdata
			);
			$display ("Outputs- addr=%h (%h expected)", addr, addr_exp,
					"zero=%b (%b expected)", zero, zero_exp,
					"op=%h (%h expected)", op, op_exp,
					"funct=%h (%h expected)", funct, funct_exp,
					"writedata=%h (%h expected)", writedata, writedata_exp
			);
			errors = errors + 1;
		end
		vectornum = vectornum + 1;
		if (testvectors[vectornum] == 'bx) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$finish;
		end
	end
endmodule
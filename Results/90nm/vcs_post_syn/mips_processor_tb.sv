/******************************************************************************** 
  File:           mips_processor_tb.sv
  Description:   	This module implements the test bench of top module of the MIPS Processor.					
  Date:           October 2019
  Author:         Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps // time scale
module mips_processor_tb();
	
	// Wires for inputs
	// Inputs
	logic clk, reset;
	logic [31:0] memdata;
	
	// Outputs
	logic memread, memwrite, regwrite;
	logic [31:0] addr, writedata, wrData, Ain, Bin, pcout;
	logic [4:0] wrAddr, rdAddr1, rdAddr2;
	
	// Wires for expected outputs
	logic memread_exp, memwrite_exp, regwrite_exp;
	logic [31:0] addr_exp, writedata_exp, wrData_exp, Ain_exp, Bin_exp, pcout_exp;
	logic [4:0] wrAddr_exp, rdAddr1_exp, rdAddr2_exp;
	
	logic [31:0] ext_mem[90:0];
	
	// Test Vector Wires
	logic [15:0] vectornum, errors;
	logic [191:0] datatestvectors[100:0];
	logic [18:0] ctrltestvectors[100:0];
	
	// DUT
	mips_processor dut(clk, reset, memdata, addr, memread, memwrite, writedata);
	
	assign pcout = dut.datapath.pcOut;
	assign wrData = dut.datapath.wrData;
	assign Ain = dut.datapath.Ain;
	assign Bin = dut.datapath.Bin;
	assign wrAddr = dut.datapath.wrAddr;
	assign rdAddr1 = dut.datapath.instruct[25:21];
	assign rdAddr2 = dut.datapath.instruct[20:16];
	assign regwrite = dut.regwrite;
	
	always
	begin
		clk = 0; #288; clk = 1; #288;
	end
	
	initial
	begin 
		$monitor ("time=%5d ns, clk=%b, reset=%b, memdata=%h, memread=%b, memwrite=%b, addr=%h, writedata=%h, pcout=%h, regwrite=%b, wrAddr=%b, rdAddr1=%b, rdAddr2=%b, wrData=%h, Ain=%h, Bin=%h",
						$time, clk, reset, memdata, memread, memwrite, addr, writedata, pcout, regwrite, wrAddr, rdAddr1, rdAddr2, wrData, Ain, Bin);
		$readmemh("mips_init_mem.mem", ext_mem);
		$readmemh("mips_processor_data.tv", datatestvectors);
		$readmemb("mips_processor_ctrl.tv", ctrltestvectors);
		vectornum = 0; errors = 0;
	end
	
	always @(negedge clk)
	begin 
		memdata = ext_mem[addr];
		{addr_exp, writedata_exp, pcout_exp, wrData_exp, Ain_exp, Bin_exp} = datatestvectors[vectornum];
		{reset, memread_exp, memwrite_exp, regwrite_exp, wrAddr_exp, rdAddr1_exp, rdAddr2_exp} = ctrltestvectors[vectornum];
		end
	
	always @(posedge clk)
	begin
		#144;
		if (addr != addr_exp ||
			memwrite != memwrite_exp ||
			memread != memread_exp ||
			writedata != writedata_exp ||
			pcout != pcout_exp ||
			regwrite != regwrite_exp ||
			wrAddr != wrAddr_exp ||
			rdAddr1 != rdAddr1_exp ||
			rdAddr2 != rdAddr2_exp ||
			wrData != wrData_exp ||
			Ain != Ain_exp ||
			Bin != Bin_exp)
		begin
			$display ("Error: Inputs- reset=%b, memdata= %h", reset, memdata);
			$display ("Outputs- addr=%h (%h expected), memwrite=%b (%b expected), memread=%b (%b expected), writedata=%h (%h expected), pcout=%h (%h expected) regwrite=%b (%b expected), wrAddr=%b (%b expected), rdAddr1=%b (%b expected), rdAddr2=%b ($b expected), wrData=%h (%h expected), Ain=%h (%h expected), Bin=%h (%h expected)",
							addr, addr_exp, memwrite, memwrite_exp, memread, memread_exp, writedata, writedata_exp, pcout, pcout_exp, regwrite, regwrite_exp, wrAddr, wrAddr_exp, rdAddr1, rdAddr1_exp, rdAddr2, rdAddr2_exp, wrData, wrData_exp, Ain, Ain_exp, Bin, Bin_exp);
			errors = errors + 1;
		end
		vectornum = vectornum + 1;
		if (vectornum > 92) begin
			$display("%d tests completed with %d errors", vectornum, errors);
			$finish;
		end
	end
endmodule
	

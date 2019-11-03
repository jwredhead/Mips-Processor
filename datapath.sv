module datapath #(parameter N=32, M=5) (
		input clk, reset,
		input [N-1:0] memdata,
		input alusra, memtoreg, iord, pcen, regwrite, regdst,
		input [1:0] pcsource, alusrcb,
		input irwrite,
		input [2:0] alucontrol,
		output zero,
		output[N-1:0] instr,
		output[N-1:0] adr, writedata,
		output [5:0] funct, op
	);
	
	localparam ZERO = 32'b0;
	localparam ONE = 32'b1;
	
	wire [M-1:0] ra1, ra2, wa;
	wire [N-1:0] pc, nextpc, md, rd1, rd2, wd, a, src1, src2, aluresult, aluout, constx4;
	
	// shift left constant field by 2
	assign constx4 = {instr[N-3:0], 2'b00};
	
	assign ra1 = instr[M + 20: 21];
	assign ra2 = instr[M + 15: 16];
	
	mux2	#(M) regmux(instr[M+15:16], instr[M+10:11], regdst, wa);
	
	// Load instruction into 
	flopen #(8) ir(clk, irwrite, memdata[N-1:0], instr[N-1:0]);
	
	// Inner datapath
	flopenr #(N) pcreg(clk, reset, pcen, nextpc, pc);
	flop #(N) mdr(clk, memdata, md);
	flop #(N) areg(clk, rd1, a);
	flop #(N) wrd(clk, rd2, writedata);
	flop #(N) res(clk, aluresult, aluout);
	mux2 #(N) adrmux(pc, aluout, iord, adr);
	mux2 #(N) src1mux(pc, a, alusra, src1);
	mux4 #(N) src2mux(writedata, ONE, instr[N-1:0], constx4, alusrcb, src2);
	mux4 #(N) pcmux(aluresult, aluout, constx4, ZERO, pcsource, nextpc);
	mux2 #(N) wdmux(aluout, md, memtoreg, wd);
	
	reg_file #(M, N) rf(clk, regwrite, ra1, ra2, wa, wd, rd1, rd2);
	alu #(N) alunit(src1, src2, alucontrol, aluresult, zero);
	
endmodule
/******************************************************************************** 
  File:           reg_file_tb.sv
  Description:   	This module implements the test bench for the reg_file module
  Date:           October 2019
  Author:         Justin Wilson, jkw0002@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps
module reg_file_TB();

	// Wires for inputs
	logic clk = 1'b0;
	logic we;
	logic[4:0] rdAddr0, rdAddr1, wrAddr;
	logic[31:0] wrData;
	
	// Wires for outputs
	logic [31:0] rdData0, rdData1;
	
	// Declare DUT
	reg_file dut(.clk(clk), .we(we), .rdAddr0(rdAddr0), .rdAddr1(rdAddr1), .wrAddr(wrAddr),
					.rdData0(rdData0), .rdData1(rdData1), .wrData(wrData));
	
	always #1 clk = ~clk; 
	
	always 
	begin
		$monitor("time=%5d ns, clk=%b, we=%b, rdAddr0=%b, rdAddr1=%b, wrAddr=%b, wrData=%d, rdData0=%d, rdData1=%d",
						$time, clk, we, rdAddr0, rdAddr1, wrAddr, wrData, rdData0, rdData1);
		rdAddr0 = 5'd0;
		rdAddr1 = 5'd0;
		we = 1'b1;
		wrAddr = 5'd0;
		wrData = 32'h00000001;
		#2;
		wrAddr = 5'd1;
		wrData = 32'h00000002;
		if (rdData0 != 32'd1 | rdData1 != 32'd1) 
		begin
			$display("ERROR- rdData0 and rdData1 not equal to expected");
			$finish;
		end
		#2;
		wrAddr = 5'd2;
		wrData = 32'h00000004;
		#2;
		wrAddr = 5'd3;
		wrData = 32'h00000008;
		#2;
		wrAddr = 5'd4;
		wrData = 32'h00000010;
		#2;
		wrAddr = 5'd5;
		wrData = 32'h00000020;
		#2;
		wrAddr = 5'd6;
		wrData = 32'h00000040;
		#2;
		wrAddr = 5'd7;
		wrData = 32'h00000080;
		#2;
		wrAddr = 5'd8;
		wrData = 32'h00000100;
		#2;
		wrAddr = 5'd9;
		wrData = 32'h00000200;
		#2;
		wrAddr = 5'd10;
		wrData = 32'h00000400;
		#2;
		wrAddr = 5'd11;
		wrData = 32'h00000800;
		#2;
		wrAddr = 5'd12;
		wrData = 32'h00001000;
		#2;
		wrAddr = 5'd13;
		wrData = 32'h00002000;
		#2;
		wrAddr = 5'd14;
		wrData = 32'h00004000;
		#2;
		wrAddr = 5'd15;
		wrData = 32'h00008000;
		#2;
		wrAddr = 5'd16;
		wrData = 32'h00010000;
		#2;
		wrAddr = 5'd17;
		wrData = 32'h00020000;
		#2;
		wrAddr = 5'd18;
		wrData = 32'h00040000;
		#2;
		wrAddr = 5'd19;
		wrData = 32'h00080000;
		#2;
		wrAddr = 5'd20;
		wrData = 32'h00100000;
		#2;
		wrAddr = 5'd21;
		wrData = 32'h00200000;
		#2;
		wrAddr = 5'd22;
		wrData = 32'h00400000;
		#2;
		wrAddr = 5'd23;
		wrData = 32'h00800000;
		#2;
		wrAddr = 5'd24;
		wrData = 32'h01000000;
		#2;
		wrAddr = 5'd25;
		wrData = 32'h02000000;
		#2;
		wrAddr = 5'd26;
		wrData = 32'h04000000;
		#2;
		wrAddr = 5'd27;
		wrData = 32'h08000000;
		#2;
		wrAddr = 5'd28;
		wrData = 32'h10000000;
		#2;
		wrAddr = 5'd29;
		wrData = 32'h20000000;
		#2;
		wrAddr = 5'd30;
		wrData = 32'h40000000;
		#2;
		wrAddr = 5'd31;
		wrData = 32'h80000000;
		#2;
		we = 1'b0;
		rdAddr0 = 5'd0;
		rdAddr1 = 5'd1;
		#2;
		if (rdData0 !=  32'h00000001| rdData1 != 32'h00000002) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00000001, 32'h00000002 );
			$finish;
		end
		rdAddr0 = 5'd2;
		rdAddr1 = 5'd3;
		#2;
		if (rdData0 !=  32'h00000004| rdData1 != 32'h00000008) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00000004, 32'h00000008 );
			$finish;
		end
		rdAddr0 = 5'd4;
		rdAddr1 = 5'd5;
		#2;
		if (rdData0 !=  32'h00000010| rdData1 != 32'h00000020) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00000010, 32'h00000020 );
			$finish;
		end
		rdAddr0 = 5'd6;
		rdAddr1 = 5'd7;
		#2;
		if (rdData0 !=  32'h00000040| rdData1 != 32'h00000080) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00000040, 32'h00000080 );
			$finish;
		end
		rdAddr0 = 5'd8;
		rdAddr1 = 5'd9;
		#2;
		if (rdData0 !=  32'h00000100| rdData1 != 32'h00000200) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00000100, 32'h00000200 );
			$finish;
		end
		rdAddr0 = 5'd10;
		rdAddr1 = 5'd11;
		#2;
		if (rdData0 !=  32'h00000400| rdData1 != 32'h00000800) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00000400, 32'h00000800 );
			$finish;
		end
		rdAddr0 = 5'd12;
		rdAddr1 = 5'd13;
		#2;
		if (rdData0 !=  32'h00001000| rdData1 != 32'h00002000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00001000, 32'h00002000 );
			$finish;
		end
		rdAddr0 = 5'd14;
		rdAddr1 = 5'd15;
		#2;
		if (rdData0 !=  32'h00004000| rdData1 != 32'h00008000)
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00004000, 32'h00008000 );
			$finish;
		end
		rdAddr0 = 5'd16;
		rdAddr1 = 5'd17;
		#2;
		if (rdData0 !=  32'h00010000| rdData1 != 32'h00020000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00010000, 32'h00020000 );
			$finish;
		end
		rdAddr0 = 5'd18;
		rdAddr1 = 5'd19;
		#2;
		if (rdData0 !=  32'h00040000| rdData1 != 32'h00080000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00040000, 32'h00080000 );
			$finish;
		end	
		rdAddr0 = 5'd20;
		rdAddr1 = 5'd21;
		#2;
		if (rdData0 !=  32'h00100000| rdData1 != 32'h00200000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00100000, 32'h00200000 );
			$finish;
		end
		rdAddr0 = 5'd22;
		rdAddr1 = 5'd23;
		#2;
		if (rdData0 !=  32'h00400000| rdData1 != 32'h00800000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h00400000, 32'h00800000 );
			$finish;
		end
		rdAddr0 = 5'd24;
		rdAddr1 = 5'd25;
		#2;
		if (rdData0 !=  32'h01000000| rdData1 != 32'h02000000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h01000000, 32'h02000000 );
			$finish;
		end
		rdAddr0 = 5'd26;
		rdAddr1 = 5'd27;
		#2;
		if (rdData0 !=  32'h04000000| rdData1 != 32'h08000000)
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h04000000, 32'h08000000 );
			$finish;
		end
		rdAddr0 = 5'd28;
		rdAddr1 = 5'd29;
		#2;
		if (rdData0 !=  32'h10000000| rdData1 != 32'h20000000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h10000000, 32'h20000000 );
			$finish;
		end
		rdAddr0 = 5'd30;
		rdAddr1 = 5'd31;
		#2;
		if (rdData0 !=  32'h40000000| rdData1 != 32'h80000000) 
		begin
			$display("ERROR 1: rdData0 =%d (%d exp), rdData1 =%d (%d exp)", rdData0, rdData1, 32'h40000000, 32'h80000000 );
			$finish;
		end;
		$display("All Tests Passed Successfully");
		$finish;
	end
		

endmodule	
	
	
			
				
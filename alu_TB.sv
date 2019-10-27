/******************************************************************************** 
  File:           alu_tb.sv
  Description:   	This module implements the test bench for the alu module
  Date:           October 2019
  Author:         Javier Cienfuegos, jc0112@uah.edu
				
*********************************************************************************/
`timescale 1ns/1ps
module alu_TB();

	// Wires for inputs
	logic [31:0] a, b;
	logic [2:0] aluControl;
	
	// Wires for outputs
	logic [31:0] aluResult;
	logic zero;
	
	// Declare DUT
	alu dut(.a(a), .b(b), .aluControl(aluControl), .aluResult(aluResult), .zero(zero));
	
	always 
	begin
		$monitor("time=%5d ns, a=%b, b=%b, aluControl=%b, aluResult=%b, zero=%d",
						$time, a, b, aluControl, aluResult, zero);
		
		// Addition
		aluControl = 0;
		a = 125;
		b = 360;
		#10;
		if (aluResult != 485 || zero != 0)
		begin
			$display("ERROR: %d + %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 485, 0);
			$finish;
		end
		
		a = -15984;
		b = 4891;
		#10;
		if (aluResult != -11093 || zero != 0)
		begin
			$display("ERROR: %d + %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, -11093 , 0);
			$finish;
		end
		
		a = 5698;
		b = -478812;
		#10;
		if (aluResult != -473114 || zero != 0)
		begin
			$display("ERROR: %d + %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, -473114 , 0);
			$finish;
		end
		
		a = -89;
		b = -781346;
		#10;
		if (aluResult != -781435 || zero != 0)
		begin
			$display("ERROR: %d + %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, -781435 , 0);
			$finish;
		end
		
		a = -4897;
		b = 4897;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
			$display("ERROR: %d + %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0 , 1);
			$finish;
		end
		
		// Subtraction
		aluControl = 1;
		a = 7913;
		b = 5923;
		#10;
		if (aluResult != 1990 || zero != 0)
		begin
			$display("ERROR: %d - %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 1990 , 0);
			$finish;
		end
		
		a = 8947613;
		b = -564979;
		#10;
		if (aluResult != 9512592 || zero != 0)
		begin
			$display("ERROR: %d - %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 9512592 , 0);
			$finish;
		end
		
		a = -461328;
		b = 36248;
		#10;
		if (aluResult != -497576 || zero != 0)
		begin
			$display("ERROR: %d - %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, -497576 , 0);
			$finish;
		end
		
		a = -741258;
		b = -632598;
		#10;
		if (aluResult != -108660 || zero != 0)
		begin
			$display("ERROR: %d - %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, -108660 , 0);
			$finish;
		end
		
		a = 16;
		b = 16;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
			$display("ERROR: %d - %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0 , 1);
			$finish;
		end
		
		// And
		aluControl = 2;
		a = 45897;
		b = 612493;
		#10;
		if (aluResult != 4105 || zero != 0)
		begin
			$display("ERROR: %d & %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 4105 , 0);
			$finish;
		end

		a = 0;
		b = 7486;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
			$display("ERROR: %d & %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0 , 1);
			$finish;
		end
		
		// Or
		aluControl = 3;
		a = 4978656;
		b = 3647894;
		#10;
		if (aluResult != 8388598 || zero != 0)
		begin
		  $display("ERROR: %d | %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 8388598, 0);
		  $finish;
		end
		
		a = 0;
		b = 175;
		#10;
		if (aluResult != 175 || zero != 0)
		begin
		  $display("ERROR: %d | %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 175, 0);
		  $finish;
		end
		
		a = 0;
		b = 0;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
		  $display("ERROR: %d | %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0, 1);
		  $finish;
		end
		
		// Nor
		aluControl = 4;
		a = 4789;
		b = 5236;
		#10;
		if (aluResult != -5878 || zero != 0)
		begin
		  $display("ERROR: %d ^| %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, -5878, 0);
		  $finish;
		end
		
		a = -25;
		b = 63;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
		  $display("ERROR: %d ^| %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0, 1);
		  $finish;
		end
		
		// Set on Less Than
		aluControl = 5;
		a = 0;
		b = 49894;
		#10;
		if (aluResult != 1 || zero != 0)
		begin
		  $display("ERROR: %d < %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 1, 0);
		  $finish;
		end
		
		a = 49894;
		b = 0;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
		  $display("ERROR: %d < %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0, 1);
		  $finish;
		end
		
		a = -56;
		b = 56;
		#10;
		if (aluResult != 1 || zero != 0)
		begin
		  $display("ERROR: %d < %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 1, 0);
		  $finish;
		end
		
		a = 56;
		b = -56;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
		  $display("ERROR: %d < %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0, 1);
		  $finish;
		end
		
		a = 0;
		b = 0;
		#10;
		if (aluResult != 0 || zero != 1)
		begin
		  $display("ERROR: %d < %d = %d [zero=%d] but expected %d [zero=%d]", a, b, aluResult, zero, 0, 1);
		  $finish;
		end
		
		$display("All Tests Passed Successfully");
		$finish;
	end

endmodule
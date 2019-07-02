`timescale 1ns / 1ps

module jumpALU_test;

	// Inputs
	reg [31:0] inputPC;
	reg [31:0] offset;

	// Outputs
	wire [31:0] jump_target;

	// Instantiate the Unit Under Test (UUT)
	jumpALU uut (
		.jump_target(jump_target), 
		.inputPC(inputPC), 
		.offset(offset)
	);

	initial begin
		// Initialize Inputs
		inputPC = 0;
		offset = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		inputPC = 32'h0000000E;		// 13
		offset = 32'h00000001;		// 1
		#20;
		
		offset = 32'hFFFFFFFF;		// -1
	end
      
endmodule

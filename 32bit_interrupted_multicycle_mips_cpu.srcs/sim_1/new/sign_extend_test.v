`timescale 1ns / 1ps

module sign_extend_test;

	// Inputs
	reg [15:0] input_data;

	// Outputs
	wire [31:0] output_data;

	// Instantiate the Unit Under Test (UUT)
	sign_extend uut (
		.input_data(input_data), 
		.output_data(output_data)
	);

	initial begin
		// Initialize Inputs
		input_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		input_data = 16'hFFFF;	// negative number
		#20;
		
		input_data = 16'h7FFF;	// positive number
	end
      
endmodule

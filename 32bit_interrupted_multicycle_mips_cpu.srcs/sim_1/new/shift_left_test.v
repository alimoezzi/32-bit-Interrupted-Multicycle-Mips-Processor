`timescale 1ns / 1ps

module shift_left_test;

	// Inputs
	reg [31:0] input_data;

	// Outputs
	wire [31:0] output_data;

	// Instantiate the Unit Under Test (UUT)
	shift_left uut (
		.input_data(input_data), 
		.output_data(output_data)
	);

	initial begin
		// Initialize Inputs
		input_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		input_data = {32{1'b1}};
	end
      
endmodule

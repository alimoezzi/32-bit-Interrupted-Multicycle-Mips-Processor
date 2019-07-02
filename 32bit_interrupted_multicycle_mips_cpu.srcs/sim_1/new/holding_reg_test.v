`timescale 1ns / 1ps

module holding_reg_test;

	// Inputs
	reg [31:0] input_data;
	reg write;
	reg clk;
	reg reset;

	// Outputs
	wire [31:0] output_data;

	// Instantiate the Unit Under Test (UUT)
	holding_reg uut (
		.output_data(output_data), 
		.input_data(input_data),
		.write(write),
		.clk(clk), 
		.reset(reset)
	);
	
	always
	#5 clk = ~clk;
	
	initial begin
		// Initialize Inputs
		input_data = 0;
		write = 0;
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		reset <= 0;
		
		input_data <= 32'hF0F0F0F0;	// no write
		#15;
		
		input_data <= 32'hAFAFAFAF;
		write <= 1;		// writing enabled
		#15;
		
		reset <= 1;		// clear contents
		#26;
		
		reset <= 0;	
	end
      
endmodule

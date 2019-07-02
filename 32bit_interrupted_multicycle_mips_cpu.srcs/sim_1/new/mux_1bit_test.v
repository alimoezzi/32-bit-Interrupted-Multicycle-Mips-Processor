`timescale 1ns / 1ps

module mux_1bit_test;

	// Inputs
	reg [31:0] input_data0;
	reg [31:0] input_data1;
	reg select;

	// Outputs
	wire [31:0] output_data;

	// Instantiate the Unit Under Test (UUT)
	mux_1bit uut (
		.output_data(output_data), 
		.input_data0(input_data0), 
		.input_data1(input_data1), 
		.select(select)
	);

	initial begin
		// Initialize Inputs
		input_data0 = 0;
		input_data1 = 0;
		select = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		input_data0 = 32'hFFFF0000;	// input 0
		input_data1 = 32'h0000FFFF;	// input 1
		#20;
		
		select = 1;		// change selected input
		#20;
		
		input_data0 = 32'h88888888;	// change input 0
		input_data1 = 32'hFEFEFEFE;	// change input 1
		
		#20;
		select = 0;		// change selected inpu
	end
      
endmodule

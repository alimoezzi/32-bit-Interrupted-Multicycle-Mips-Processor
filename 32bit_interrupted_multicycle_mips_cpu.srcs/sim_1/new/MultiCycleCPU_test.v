`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.07.2019 02:22:10
// Design Name: 
// Module Name: MultiCycleCPU_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~ CPU TEST BENCH ~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

module MultiCycleCPU_test;

	// Inputs
	reg clk;
	reg reset;
	reg cntrlNMI;
	reg cntrlINT;
	// Outputs
	wire [31:0] ALUImmResult;
	wire [1:0] dpCauseInterruptout;
	wire [31:0] dpEPCout;
	wire cntrlINA;
	wire [1:0] dpCauseExceptionout;

	// Instantiate the Unit Under Test (UUT)
	MultiCycleCPU uut (
		.clk(clk),
		.reset(reset),
		.cntrlNMI(cntrlNMI),
		.cntrlINT(cntrlINT),
		.cntrlINA(cntrlINA),
		.AluRes(ALUImmResult),
		.datapathCauseInterruptout(dpCauseInterruptout),
		.datapathEPCout(dpEPCout),
		.datapathCauseExceptionout(dpCauseExceptionout)
	);
	always
	#5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		reset <= 0;		// drop reset
		#1245;			// wait for program to execute

		reset <= 1;		// reset cpu
		#40;
		reset <= 0;		// program restarts
	end

endmodule

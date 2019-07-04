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
	reg cntrlINTD;
	// Outputs
	wire [31:0] ALUImmResult;
	wire [1:0] dpCauseInterruptout;
	wire [31:0] dpEPCout;
	wire [31:0] dpPCout;
	wire cntrlINA;
	

	// Instantiate the Unit Under Test (UUT)
	MultiCycleCPU uut (
		.clk(clk),
		.reset(reset),
		.cntrlNMI(cntrlNMI),
		.cntrlINT(cntrlINT),
		.cntrlINA(cntrlINA),
		.cntrlINTD(cntrlINTD),
		.AluRes(ALUImmResult),
		.debugCauseInterruptout(dpCauseInterruptout),
		.debugEPCout(dpEPCout),
		.debugPCout(dpPCout)

	);
	always
	#5 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		cntrlNMI <= 0;
		cntrlINT <= 0; 
		cntrlINTD <= 0;
		
		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		reset <= 0;		    // drop reset
		//#1245;			// wait for program to execute

        #200;
        cntrlNMI <= 1;
        cntrlINT <= 0;
        cntrlINTD <= 0;
        #45;
        cntrlNMI <= 0;
        cntrlINT <= 0;
        cntrlINTD <= 0;
        
        #200
        cntrlNMI <= 0;
        cntrlINT <= 1;
        cntrlINTD <= 0;
        #45
        cntrlNMI <= 0;
        cntrlINT <= 0;
        cntrlINTD <= 0;
        
        #200
        cntrlNMI <= 0;
        cntrlINT <= 1;
        cntrlINTD <= 1;
        #45
        cntrlNMI <= 0;
        cntrlINT <= 0;
        cntrlINTD <= 0;
        
        #200
        cntrlNMI <= 1;
        cntrlINT <= 1;
        cntrlINTD <= 1;
        #45
        cntrlNMI <= 0;
        cntrlINT <= 0;
        cntrlINTD <= 0;
        
        #200
        cntrlNMI <= 1;
        cntrlINT <= 1;
        cntrlINTD <= 0;
        #45
        cntrlNMI <= 0;
        cntrlINT <= 0;
        cntrlINTD <= 0;
        
        #120;        
		reset <= 1;		// reset cpu
		
		#40;
		reset <= 0;		// program restarts
	end

endmodule

`timescale 1ns / 1ps

// IMem
//
// A module used to mimic Instruction memory,
// Returns hardcoded instructions based on the current PC.
//
// Fixed a false nop instruction and reg select fields in 1.
//
// ----------------------------------------------------
// IMPORTANT!
// Which test program to use:
// - PROGRAM_1: MY_EXAMPLE.
`define PROGRAM_1 // <<<<<<<<<<<< CHANGE TEST PROGRAM HERE!
//
// Change the previous line to try a different program,
// when available.
// ----------------------------------------------------

module IMem(PC,          // PC (address) of instruction in IMem
            Instruction);
  `ifdef PROGRAM_1
    parameter PROG_LENGTH= 10;
  `endif
  //-------------Input Ports-----------------------------
  input [31:0] PC;
  //-------------Output Ports----------------------------
  output [31:0] Instruction;
  reg [31:0] Instruction;
  //------------Code Starts Here-------------------------
  always @(PC)
  begin
    case(PC)
    //-----------------------------------------------------
    `ifdef PROGRAM_1
    //-----------------------------------------------------

      // My_Example
      
      // ADDI   $R0, $R0, 0x00001  --> $R0 = 1
      0: Instruction=  32'b110010_00000_00000_0000000000000001;
      // ADDI   $R1, $R1, 0x00001 --> $R1 = 1
      1: Instruction=  32'b110010_00001_00001_0000000000000001;
      // AND    $R2, $R0, $R1     --> $R2 = 1
      2: Instruction= 32'b010101_00000_00001_00010_00000000000;
      // ADD    $R3, $R2, $R0     --> $R3 = 2
      3: Instruction=  32'b010010_00010_00000_00011_00000000000;
      // XOR    $R4, $R1, $R3     --> $R4 = 3
      4: Instruction= 32'b010110_00001_00011_00100_00000000000;
      // SLT    $R5, $R3, $R4     --> $R5 = 1
      5: Instruction= 32'b010111_00011_00100_00101_00000000000;
      // J 2	
      6: Instruction= 32'b000001_00000_00000_0000000000000010;
      // ADD    $R6, $R3, $R3     --> $R6 = 4
      7: Instruction=  32'b010010_00011_00011_00110_00000000000;
      // ADD    $R6, $R3, $R3     --> $R6 = 4
      8: Instruction=  32'b010010_00011_00011_00110_00000000000;
      // SW     $R4, $R3[0x1]     --> $R4 into 3
      9: Instruction=  32'b111110_00011_00100_0000000000000001;
      // LW  $R7, $R3[0x1]        --> $R7 = $R4 = 3
      10: Instruction= 32'b111101_00011_00111_0000000000000001;



    `endif
      default: Instruction= 0; //NOOP
    endcase
  end
endmodule



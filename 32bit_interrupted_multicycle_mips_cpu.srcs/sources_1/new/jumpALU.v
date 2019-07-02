`timescale 1ns / 1ps

// ALU for jump target calculations
module jumpALU(jump_target, inputPC, offset);
  parameter word_size = 32;

  // inputs and outpust
  input [word_size-1:0] inputPC, offset;
  output [word_size-1:0] jump_target;

  // assign target
  assign jump_target = inputPC + offset;
endmodule

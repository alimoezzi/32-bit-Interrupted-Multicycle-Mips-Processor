`timescale 1ns / 1ps

// zero extend module
module zero_extend(input_data, output_data);
  // parameters
  parameter word_size = 32;
  parameter imm_size = 16;

  // input and output
  input [imm_size-1:0] input_data;
  output [word_size-1:0] output_data;

  // output assignment
  assign output_data = $unsigned(input_data);
endmodule

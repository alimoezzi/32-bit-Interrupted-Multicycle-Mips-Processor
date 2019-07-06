`timescale 1ns / 1ps

// zero extend module
module shift_left(input_data, output_data);
  // parameters
  parameter word_size = 32;
  parameter shift_size = 2;

  // input and output
  input [word_size-1:0] input_data;
  output [word_size-1:0] output_data;

  // output assignment
  assign output_data = {input_data[word_size-1-shift_size:0], {shift_size{1'b0}}};
endmodule
`timescale 1ns / 1ps

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~ CPU ~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

module MultiCycleCPU(clk, reset,AluRes);
  // ~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~ //

  input clk, reset;
  
  // ~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~ //
  
  output wire AluRes;

  // ~~~~~~~~~~~~~~~~~~~~~ WIRES ~~~~~~~~~~~~~~~~~~~~~~~ //

  wire PCWrite, PCWriteCond, IRWrite, DMEMWrite, RegWrite, ALUSrcA, RegReadSel;
  wire [1:0] MemtoReg, ALUSrcB, PCSource;
  wire [3:0] ALUSel;
  wire [5:0] opcode;

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~ DATAPATH ~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  datapath	cpu_datapath(clk, reset, PCWrite, PCWriteCond, IRWrite, DMEMWrite,
                         RegWrite, ALUSrcA, RegReadSel, MemtoReg, ALUSrcB,
                         PCSource, ALUSel, opcode, AluRes);

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~ CONTROLLER ~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  controller	cpu_controller(opcode, clk, reset, PCWrite, PCWriteCond,
                             DMEMWrite, IRWrite, MemtoReg, PCSource, ALUSel,
                             ALUSrcA, ALUSrcB, RegWrite, RegReadSel);
endmodule

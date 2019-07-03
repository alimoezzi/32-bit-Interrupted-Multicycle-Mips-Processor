`timescale 1ns / 1ps

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~ CPU ~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //


module MultiCycleCPU(clk, reset, cntrlNMI, cntrlINT, cntrlINA, AluRes, datapathCauseInterruptout, datapathEPCout,
datapathCauseExceptionout);
  
  // ~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~ //

  parameter word_size = 32;
  parameter cause_size = 2;
  
  // ~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~ //

  input clk, reset;
  wire [word_size-1:0] datapathEPCin;
  wire [cause_size-1:0] datapathCauseInterruptin;
  // wire datapathCauseInterruptWrite; // wirte is always asserted
  wire [cause_size-1:0] datapathCauseExceptionin;
  // wire datapathCauseExceptionWrite; // wirte is always asserted
  // wire datapathEPCWrite; // wirte is always asserted
  input cntrlNMI;
  input cntrlINT;
  
  // ~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~ //
  
  output wire [word_size-1:0] AluRes;
  output wire [cause_size-1:0] datapathCauseInterruptout;
  output wire [cause_size-1:0] datapathCauseExceptionout;
  output [word_size-1:0] datapathEPCout;
  output cntrlINA;
  
  // ~~~~~~~~~~~~~~~~~~~~~ WIRES ~~~~~~~~~~~~~~~~~~~~~~~ //

  wire PCWrite, PCWriteCond, IRWrite, DMEMWrite, RegWrite, ALUSrcA, RegReadSel;
  wire [word_size-1:0] datapathPCout;
  wire [1:0] MemtoReg, ALUSrcB, PCSource;
  wire [3:0] ALUSel;
  wire [5:0] opcode;

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~ DATAPATH ~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  datapath	cpu_datapath(clk, reset, PCWrite, PCWriteCond, IRWrite, DMEMWrite,
                         RegWrite, ALUSrcA, RegReadSel, MemtoReg, ALUSrcB,
                         PCSource, ALUSel, opcode, AluRes,datapathPCout, datapathEPCout, datapathEPCin,
                         datapathCauseExceptionout, datapathCauseExceptionin,
                         datapathCauseInterruptout, datapathCauseInterruptin);

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~ CONTROLLER ~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  controller	cpu_controller(opcode, clk, reset, PCWrite, PCWriteCond,
                             DMEMWrite, IRWrite, MemtoReg, PCSource, ALUSel,
                             ALUSrcA, ALUSrcB, RegWrite, RegReadSel, cntrlNMI, cntrlINT,cntrlINA, datapathCauseExceptionout,
                             datapathPCout,
                             datapathEPCout,
                             datapathEPCin,datapathCauseInterruptin);
endmodule

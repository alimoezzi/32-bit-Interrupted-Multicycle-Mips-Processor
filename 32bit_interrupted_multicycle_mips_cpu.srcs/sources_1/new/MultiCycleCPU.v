`timescale 1ns / 1ps

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~ CPU ~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //


module MultiCycleCPU(clk, reset, cntrlNMI, cntrlINT, cntrlINA, AluRes, datapathCauseInterruptout, datapathEPCout,
datapathCauseExceptionout);
  
  // ~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~ //

  parameter word_size = 32;
  
  // ~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~ //

  input clk, reset;
  wire datapathEPCin;
  wire datapathCauseInterruptin;
  // wire datapathCauseInterruptWrite; // wirte is always asserted
  wire datapathCauseExceptionin;
  // wire datapathCauseExceptionWrite; // wirte is always asserted
  // wire datapathEPCWrite; // wirte is always asserted
  input cntrlNMI;
  input cntrlINT;
  
  // ~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~ //
  
  output wire [word_size-1:0] AluRes;
  output wire datapathCauseInterruptout;
  output wire datapathCauseExceptionout;
  output datapathEPCout;
  output cntrlINA;
  
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
                         PCSource, ALUSel, opcode, AluRes, datapathEPCout, datapathEPCin,
                         1/*datapathEPCWrite*/, datapathCauseExceptionout,
                         datapathCauseExceptionin,
                         1/*datapathCauseExceptionWrite*/,
                         datapathCauseInterruptout,
                         datapathCauseInterruptin,
                         1/*datapathCauseInterruptWrite*/ );

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~ CONTROLLER ~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  controller	cpu_controller(opcode, clk, reset, PCWrite, PCWriteCond,
                             DMEMWrite, IRWrite, MemtoReg, PCSource, ALUSel,
                             ALUSrcA, ALUSrcB, RegWrite, RegReadSel, cntrlNMI, cntrlINT,cntrlINA, datapathCauseExceptionout,
                             datapathEPCout,
                             datapathEPCin,datapathCauseInterruptin,
                             datapathCauseInterruptWrite );
endmodule

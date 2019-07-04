`timescale 1ns / 1ps

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~ CPU ~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //


module MultiCycleCPU(clk, reset, cntrlNMI, cntrlINT, cntrlINA, AluRes, mccCauseInterruptout, mccEPCout);
  
  // ~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~ //

  parameter word_size = 32;
  parameter cause_size = 2;
  
  // ~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~ //

  input clk, reset;
  input cntrlNMI;
  input cntrlINT;
  
  // ~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~ //
  
  output wire [word_size-1:0] AluRes;
  output cntrlINA;
  output [cause_size-1:0] mccCauseInterruptout;
  output [word_size-1:0] mccEPCout;
  
  // ~~~~~~~~~~~~~~~~~~~~~ WIRES ~~~~~~~~~~~~~~~~~~~~~~~ //

  wire PCWrite, PCWriteCond, IRWrite, DMEMWrite, RegWrite, ALUSrcA, RegReadSel;
  wire [word_size-1:0] datapathPCout;
  wire [1:0] MemtoReg, ALUSrcB, PCSource;
  wire [3:0] ALUSel;
  wire [5:0] opcode;
  wire [cause_size-1:0] datapathCauseInterruptin;
  wire [cause_size-1:0] datapathCauseInterruptout;
  wire [word_size-1:0] datapathEPCin;
  wire [word_size-1:0] datapathEPCout;

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~ DATAPATH ~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  datapath	cpu_datapath(.clk(clk), .reset(reset), .PCWrite(PCWrite),
                         .PCWriteCond(PCWriteCond), .IRWrite(IRWrite),
                         .DMEMWrite(DMEMWrite), .RegWrite(RegWrite),
                         .ALUSrcA(ALUSrcA), .RegReadSel(RegReadSel),
                         .MemtoReg(MemtoReg), .ALUSrcB(ALUSrcB),
                         .PCSource(PCSource), .ALUSel(ALUSel),
                         .opcode(opcode), .ALUResTemp(AluRes),
                         .PCout(datapathPCout), .EPCout(datapathEPCout),
                         .EPCin(datapathEPCin),
                         .causeInterruptout(datapathCauseInterruptout),
                         .causeInterruptin(datapathCauseInterruptin));

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~ CONTROLLER ~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  controller	cpu_controller(opcode, clk, reset, PCWrite, PCWriteCond,
                             DMEMWrite, IRWrite, MemtoReg, PCSource, ALUSel,
                             ALUSrcA, ALUSrcB, RegWrite, RegReadSel,
                             cntrlNMI, cntrlINT, cntrlINA,
                             datapathPCout, datapathEPCout,
                             datapathEPCin, datapathCauseInterruptin);


  assign mccCauseInterruptout = datapathCauseInterruptout;
  assign mccEPCout = datapathEPCout;

endmodule

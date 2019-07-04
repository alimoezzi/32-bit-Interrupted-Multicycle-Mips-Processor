`timescale 1ns / 1ps

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~ CPU ~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //


module MultiCycleCPU(clk, reset, cntrlNMI, cntrlINT, cntrlINA, cntrlINTD, AluRes, debugCauseInterruptout, debugEPCout, debugPCout);
  
  // ~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~ //

  parameter word_size = 32;
  parameter cause_size = 2;
  
  // ~~~~~~~~~~~~~~~~~~~~~ INPUTS ~~~~~~~~~~~~~~~~~~~~~~ //

  input clk, reset;
  input cntrlNMI;
  input cntrlINT;
  input cntrlINTD;
  
  // ~~~~~~~~~~~~~~~~~~~~~ OUTPUTS ~~~~~~~~~~~~~~~~~~~~~~ //
  
  output wire [word_size-1:0] AluRes;
  output cntrlINA;
  output [cause_size-1:0] debugCauseInterruptout;
  output [word_size-1:0] debugEPCout;
  output [word_size-1:0] debugPCout;
  
  // ~~~~~~~~~~~~~~~~~~~~~ WIRES ~~~~~~~~~~~~~~~~~~~~~~~ //

  wire PCWrite, mccBranch, IRWrite, DMEMWrite, RegWrite, ALUSrcA, RegReadSel;
  wire [1:0] MemtoReg, ALUSrcB, PCSource;
  wire [3:0] ALUSel;
  wire [5:0] opcode;
  wire [word_size-1:0] mccPCout;
  wire [cause_size-1:0] mccCauseInterruptin;
  wire [cause_size-1:0] mccCauseInterruptout;
  wire [word_size-1:0] mccpathEPCin;
  wire [word_size-1:0] mccEPCout;

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~ DATAPATH ~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  datapath	cpu_datapath(.clk(clk),
                         .reset(reset),
                         .PCWrite(PCWrite),
                         .Branch(mccBranch),
                         .IRWrite(IRWrite),
                         .DMEMWrite(DMEMWrite),
                         .RegWrite(RegWrite),
                         .ALUSrcA(ALUSrcA),
                         .RegReadSel(RegReadSel),
                         .MemtoReg(MemtoReg),
                         .ALUSrcB(ALUSrcB),
                         .PCSource(PCSource),
                         .ALUSel(ALUSel),
                         .opcode(opcode),
                         .ALUResTemp(AluRes),
                         .PCoutoutside(mccPCout), .EPCout(mccEPCout),
                         .EPCin(mccpathEPCin),
                         .causeInterruptout(mccCauseInterruptout),
                         .causeInterruptin(mccCauseInterruptin));

  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~ CONTROLLER ~~~~~~~~~~~~~~~~~~~ //
  // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

  controller	cpu_controller(
                             .opcode(opcode),
                             .clk(clk),
                             .reset(reset),
                             .PCWrite(PCWrite),
                             .Branch(mccBranch),
                             .DMEMWrite(DMEMWrite),
                             .IRWrite(IRWrite),
                             .MemtoReg(MemtoReg),
                             .PCSource(PCSource),
                             .ALUSel(ALUSel),
                             .ALUSrcA(ALUSrcA),
                             .ALUSrcB(ALUSrcB),
                             .RegWrite(RegWrite),
                             .RegReadSel(RegReadSel),
                             .NMI(cntrlNMI),
                             .INT(cntrlINT),
                             .INA(cntrlINA),
                             .INTD(cntrlINTD),
                             .datapathPCout(mccPCout), 
                             .datapathEPCin(mccpathEPCin),
                             .datapathCauseInterruptin(mccCauseInterruptin));


  assign debugCauseInterruptout = mccCauseInterruptout;
  assign debugEPCout = mccEPCout;
  assign debugPCout = mccPCout;

endmodule

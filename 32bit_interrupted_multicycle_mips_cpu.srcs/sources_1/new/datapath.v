`timescale 1ns / 1ps

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~ DATAPATH ~~~~~~~~~~~~~~~~~~~ //
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ //

module datapath(clk, reset, PCWrite, Branch, IRWrite, DMEMWrite, RegWrite,
                 ALUSrcA, RegReadSel, MemtoReg, ALUSrcB, PCSource, ALUSel,
                 opcode, ALUResTemp, PCoutoutside, EPCout, EPCin,causeInterruptout, causeInterruptin);

  // ~~~~~~~~~~~~~~~~~~~ PARAMETERS ~~~~~~~~~~~~~~~~~~~ //

  parameter word_size = 32;
  parameter cause_size = 2;

  // ~~~~~~~~~~~~~~~~~~~ PORTS ~~~~~~~~~~~~~~~~~~~ //

  input PCWrite, Branch, IRWrite, DMEMWrite, RegWrite, ALUSrcA, RegReadSel /* 0 for R3, 1 for R1*/;
  input [1:0] MemtoReg, ALUSrcB, PCSource;
  input [3:0] ALUSel;
  input clk, reset;
  output [5:0] opcode;
  output wire [word_size-1:0] ALUResTemp;
  // PC
  output [word_size-1:0] PCoutoutside;

  // EPC
  output [word_size-1:0]  EPCout;
  input [word_size-1:0]  EPCin;//*
  
  // Cause Interrupt
  output [cause_size-1:0] causeInterruptout;
  input [cause_size-1:0] causeInterruptin;//*

  // ~~~~~~~~~~~~~~~~~~~ WIRES ~~~~~~~~~~~~~~~~~~~ //

  // PC
  wire [word_size-1:0] PCin;
  wire [word_size-1:0] PCout;

  // EPC
  wire [word_size-1:0]  EPCoutinside;
  wire [word_size-1:0]  EPCininside;
  
  // Cause Interrupt
  wire [cause_size-1:0] causeInterruptoutinside;
  wire [cause_size-1:0] causeInterruptininside;
  
  // Instruction Memory
  wire [word_size-1:0] IMout;

  // Instruction Register
  wire [word_size-1:0] IRout;
  wire [15:0] immediate;

  // Data Memory
  wire [word_size-1:0] DMout;

  // Memory Data Register
  wire [word_size-1:0] MDRout;

  // Sign/Sign+Shift Extension
  wire [word_size-1:0] immSE, immSESH;

  // Reg File
  wire [4:0] read_sel_1, read_sel_2, write_address;
  wire [word_size-1:0] write_data;
  wire [word_size-1:0] read_data_1, read_data_2;

  // A and B outputs
  wire [word_size-1:0] Aout, Bout;

  // Jump ALU
  wire [word_size-1:0] jump_target;

  // ALU
  wire [word_size-1:0] sourceA, sourceB;
  wire [word_size-1:0] ALU_wire;
  wire zero;

  // ALUOut
  wire [word_size-1:0] ALUOut_wire;

  // ~~~~~~~~~~~~~~~~~~~ PC WRITE SIGNAL ~~~~~~~~~~~~~~~~~~~ //

  wire	w1;
  and	and1(w1, Branch, zero);
  or or1(PCWrite_datapath, w1, PCWrite);

  // ~~~~~~~~~~~~~~~~~~~ ASSIGNMENTS ~~~~~~~~~~~~~~~~~~~ //

  assign opcode = IRout[31:26];
  assign immediate = IRout[15:0];
  assign read_sel_1 = IRout[25:21]; // R1
  assign read_sel_2 = IRout[20:16]; // R2

  // ~~~~~~~~~~~~~~~~~~~ MEMORY ~~~~~~~~~~~~~~~~~~~ //

  // INSTRUCTION MEM
  IMem IM(PCout, IMout);

  // DATA MEM
  DMem DM(Bout, DMout, immediate, DMEMWrite, clk);

  // MEM DATA REGISTER
  holding_reg MDR(MDRout, DMout, 1'b1, clk, reset);

  // Reg File
  nbit_register_file RF(write_data,
                        read_data_1, read_data_2,
                        read_sel_1, read_sel_2,
                        write_address, RegWrite, clk);

  // ~~~~~~~~~~~~~~~~~~~ INTERNAL REGISTERS ~~~~~~~~~~~~~~~~~~~ //

  // PC
  holding_reg PC(PCout, PCin, PCWrite_datapath, clk, reset);
  assign PCoutoutside = PCout;

  // EPC
  // wirte is always asserted
  holding_reg  EPC(EPCoutinside,EPCininside,1'b1,clk,reset);
  assign EPCout = EPCoutinside;//*
  assign EPCininside = EPCin ;//*
  
  // causeInterrupt
  // wirte is always asserted
  holding_reg  causeInterrupt(causeInterruptoutinside,causeInterruptininside,1'b1,clk,reset);
  defparam  causeInterrupt.word_size = cause_size;

  assign causeInterruptininside = causeInterruptin;//*
  assign causeInterruptout = causeInterruptoutinside;

   
  // INSTRUCTION REGISTER
  holding_reg IR(IRout, IMout, IRWrite, clk, reset);

  // A and B
  holding_reg	A(Aout, read_data_1, 1'b1, clk, reset);
  holding_reg B(Bout, read_data_2, 1'b1, clk, reset);

  // ALUOut Register
  holding_reg	ALUOut(ALUOut_wire, ALU_wire, 1'b1, clk, reset);

  // ~~~~~~~~~~~~~~~~~~~ EXTENDERS ~~~~~~~~~~~~~~~~~~~ //

  // SE(imm) and SESH(imm)
  sign_extend SE(immediate, immSE);
  shift_left  shift(immSE, immSESH);

  // ~~~~~~~~~~~~~~~~~~~ MULTIPLEXERS ~~~~~~~~~~~~~~~~~~~ //

  // Reg File inputs
  read_mux	read_sel_mux(write_address, IRout[20:16], IRout[15:11], RegReadSel); // write_address is R2 or R3
  mux_1bit write_data_mux(write_data, ALUOut_wire, MDRout, MemtoReg);
  //mux_2bit write_data_mux(write_data, ALUOut_wire, MDRout, {read_data_2[31:16],immediate}, {immediate,read_data_2[15:0]}, MemtoReg);
  
  // ALU inputs
  mux_1bit ALUSrcA_mux(sourceA, PCout, Aout, ALUSrcA); // alusrca = 0 -> sourceA = pc
  mux_2bit ALUSrcB_mux(sourceB, Bout, 32'd1, immSE, immSESH, ALUSrcB);

  //PC source mux
  mux_2bit	PC_mux(PCin, ALU_wire, ALUOut_wire, jump_target, 32'h00000000, PCSource);

  // ~~~~~~~~~~~~~~~~~~~ JUMP ALU ~~~~~~~~~~~~~~~~~~~ //

  //jump_target, inputPC, offset
  jumpALU	jALU(jump_target, PCout, immSE);

  // ~~~~~~~~~~~~~~~~~~~ MAIN ALU ~~~~~~~~~~~~~~~~~~~ //

  // ALU
  myALU	mainALU(ALU_wire, zero, sourceA, sourceB, ALUSel);
  assign ALUResTemp=ALUOut_wire;
  
endmodule

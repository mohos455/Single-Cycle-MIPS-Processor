module Top_Module (
    input clk,rst,
    output [31:0] test 
 );



// interconnection 
wire MemWrite; 
wire RegDst;
wire RegWrite;
wire ALUSrc;
wire MemtoReg;
wire PCSrc;
wire zero;
wire Jump;
wire Branch;
wire [2:0] ALUControl;
wire [31:0] PC;
wire [31:0] ALUOut;
wire [31:0] WriteData;
wire [31:0] Instr;
wire [31:0] ReadData;
/////// ALU_Decoder

//DataPath
DataPath D_Path (
.clk(clk),
.rst(rst),
.regDest(RegDst),
.regWrite(RegWrite),
.aluSrc(ALUSrc),
.MemtoReg(MemtoReg),
.PCSrc(PCSrc),
.Zero(zero),
.Jump(Jump),
.ALUControl(ALUControl),
.Instr(Instr),
.ReadData(ReadData),
.PC(PC),
.ALUResult(ALUOut),
.WriteData(WriteData)
);
//Instruction Memory
Instruction_Memory In_Mem(
.PC (PC),
.RD (Instr)
);
//Data Meomory 
Data_Memory D_Mem (
.A(ALUOut),
.WD(WriteData),
.WE(MemWrite),
.clk(clk),
.rst(rst),
.RD(ReadData),
.tst(test)
);

// control unit


Control_Unit Con_Uni (
.opCode(Instr[31:26]),
.Funct(Instr[5:0]),
.regDst(RegDst),
.regWrite(RegWrite),
.aluSrc(ALUSrc),
.MemtoReg(MemtoReg),
.PCSrc(PCSrc),
.Zero(zero),
.jump(Jump),
.ALUControl(ALUControl),
.memWrite(MemWrite)
);

endmodule
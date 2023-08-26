module DataPath (
    input clk ,rst,regWrite,regDest,aluSrc,MemtoReg,Jump,PCSrc,
    input [2:0]  ALUControl,
    output Zero,
    output [31:0] PC,ALUResult, WriteData,
    input [31:0] Instr,ReadData
);
/////////////////////////
// interconnection 
wire [27:0] Pcjump;
wire [31:0] PCBJump;
wire [31:0] Signlmm;
wire [31:0] Result;
wire [31:0] RD1;
wire [31:0] RD2;
wire [31:0] SrcB;
wire [31:0] PCPlus4;
wire [27:0] PCShift;
wire [31:0] PCBranch;
wire [4:0] WriteReg;
wire [31:0] MUXOut1;
wire [31:0] MUXOut2;
wire [31:0] SignlmmShift;

assign WriteData = RD2 ;
Adder Adder(
    .A(PC),
    .B(32'd4), 
    .C(PCPlus4)
);
///////////////
alu U_alu(
        .A(RD1),
        .B(SrcB),
        .Op(ALUControl),
        .alu_out(ALUResult),
        .zero_flag(Zero)
    );

shiftpc shiftpc_U(
    .in(Instr[25:0]),
    .out(Pcjump)
);


Program_Counter Program_Counter_U(
    .PC1(MUXOut2),
    .clk(clk),
    .rst(rst),
    .PC2(PC)
    );
////////////
MUX MUX_PCSrc(
.in1(PCPlus4),
.in2(PCBranch),
.sel(PCSrc),
.out(MUXOut1)
);
MUX MUX_Jump(
.in1(MUXOut1),
.in2({PCPlus4[31:28],Pcjump}),
.sel(Jump),
.out(MUXOut2)
);

signExtend S_E (
.inst(Instr[15:0]),
.Signlmm(Signlmm)
);
Register_File R_F (
.A1(Instr[25:21]),
.A2(Instr[20:16]),
.A3(WriteReg),
.WD(Result),
.WE(regWrite),
.clk(clk),
.RD1(RD1),
.rst(rst),
.RD2(RD2)
);
MUX MUX_ALUSrc (
.in1(RD2),
.in2(Signlmm),
.sel(aluSrc),
.out(SrcB)
);

MUX #(.width(5)) MUX_REGDst  ( 
.in1(Instr[20:16]),
.in2(Instr[15:11]),
.sel(regDest),
.out(WriteReg)
);
shiftlefttwice SLT (
    .in(Signlmm),
    .out(SignlmmShift)
);
Adder Adder_2 (
.A(SignlmmShift),
.B(PCPlus4),
.C(PCBranch)
);
MUX MUX_MemtoReg (
.in1(ALUResult),
.in2(ReadData),
.sel(MemtoReg),
.out(Result)
);

endmodule

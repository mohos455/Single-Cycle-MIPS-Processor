module Control_Unit (
    input [5:0] Funct ,opCode,
    input Zero,
    output memWrite,regWrite,regDst,aluSrc,MemtoReg,jump,PCSrc,
    output [2:0]  ALUControl
);
    wire Branch;
    wire [1:0] ALUOP;
    assign PCSrc = Zero & Branch ;
 
    Main_Decoder U_Main_Decoder (
        .opCode(opCode),
        .ALUOP(ALUOP),
        .MemWrite(memWrite),
        .regWrite(regWrite),
        .RegDst(regDst),
        .ALUSrc(aluSrc),
        .MemtoReg(memtoReg),
        .Jump(jump),
        .Branch(Branch)
    );

    ALU_Decoder U_ALU_Decoder(
        .ALUOP(ALUOP),
        .Funct(Funct),
        .ALUControl(ALUControl)
    );
    
endmodule
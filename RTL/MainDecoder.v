module Main_Decoder (
    input [5:0] opCode,
    output  reg [1:0] ALUOP,
    output reg MemWrite,regWrite,RegDst,ALUSrc,MemtoReg,Branch,Jump
);

    always @(*) 
    begin

    case(opCode)
        6'b00_0000:
        begin
            Jump= 1'b0;
            ALUOP=2'b10;
            MemWrite= 1'b0;
            regWrite= 1'b1;
            RegDst= 1'b1;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b0;
        end
        6'b00_0010:
        begin
            Jump= 1'b1;
            ALUOP=2'b00;
            MemWrite= 1'b0;
            regWrite= 1'b0;
            RegDst= 1'b0;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b0;
        end
        6'b00_0100:
        begin
            Jump= 1'b0;
            ALUOP=2'b01;
            MemWrite= 1'b0;
            regWrite= 1'b0;
            RegDst= 1'b0;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b1;
        end
        6'b00_1000:
        begin
            Jump= 1'b0;
            ALUOP=2'b00;
            MemWrite= 1'b0;
            regWrite= 1'b1;
            RegDst= 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b0;
            Branch = 1'b0;
        end
    6'b10_0011:
        begin
            Jump= 1'b0;
            ALUOP=2'b00;
            MemWrite= 1'b0;
            regWrite= 1'b1;
            RegDst= 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b1;
            Branch = 1'b0;
        end
    6'b10_1011:
        begin
            Jump= 1'b0;
            ALUOP=2'b00;
            MemWrite= 1'b1;
            regWrite= 1'b0;
            RegDst= 1'b0;
            ALUSrc = 1'b1;
            MemtoReg = 1'b1;
            Branch = 1'b0;
        end
    default :
        begin
            Jump= 1'b0;
            ALUOP=2'b00;
            MemWrite= 1'b0;
            regWrite= 1'b0;
            RegDst= 1'b0;
            ALUSrc = 1'b0;
            MemtoReg = 1'b0;
            Branch = 1'b0;
        end
    endcase
    end
endmodule
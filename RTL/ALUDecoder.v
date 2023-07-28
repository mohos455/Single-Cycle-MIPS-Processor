module ALU_Decoder (
    input [1:0] ALUOP,
    input [5:0] Funct ,
    output reg [2:0]  ALUControl
);
    always @(*) 
    begin
    case(ALUOP)
        2'b00 : ALUControl = 3'b010 ;
        2'b01 : ALUControl = 3'b100 ;
        2'b10 :
        begin
                 if(Funct == 6'b10_0000)
                    ALUControl = 3'b010;
                else if (Funct == 6'b10_0010)
                    ALUControl = 3'b100;
                else if (Funct == 6'b10_1010)
                    ALUControl = 3'b110;
                else if (Funct == 6'b01_1100)
                    ALUControl = 3'b101;
                else 
                    ALUControl = 3'b010;
        end
        default : ALUControl = 3'b010;
    endcase
    end
endmodule
module Register_File (A1,A2,A3,WD,WE,RD1,RD2,clk,rst);
input [4:0] A1,A2,A3;
input [31:0] WD;
input WE,clk,rst;
output [31:0] RD1,RD2;  
reg [31:0] Reg [0:99] ;
integer i;

always @(posedge clk or negedge rst ) begin
    //Reg[0]=0;
    if(!rst) for(i = 0; i < 32; i = i + 1) Reg [i] <= 32'b0;
    else if (WE) begin
        Reg[A3]<=WD;
        
    end
end    
assign RD1 = Reg[A1];
assign RD2 = Reg[A2];

endmodule
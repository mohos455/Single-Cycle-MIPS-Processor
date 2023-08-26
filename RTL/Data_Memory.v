module Data_Memory (A,WD,WE,RD,clk,rst,tst);
input [31:0] A, WD;
input WE,clk,rst;
output [31:0] RD;
output [31:0] tst;  

integer i;

reg [31:0] mem_RAM [0:99];  

initial
begin
for(i=0;i<100;i=i+1)
mem_RAM[i]<=32'b0;
end

always @(posedge clk or negedge rst)
begin 
if(!rst)
for(i=0;i<100;i=i+1)
  mem_RAM[i]<=32'b0;
else if(WE & rst)
 mem_RAM[A]<=WD;
end


assign RD= mem_RAM[A];
assign tst= mem_RAM[0][15:0];

endmodule


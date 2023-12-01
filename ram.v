module ram(input clk,en,wr,input [7:0] data_in,input[2:0] address,output reg [7:0] data_out);
 reg [7:0] memo [7:0];
always @(posedge clk)
begin
if (en)
begin 
  if(wr)
    memo[address]<=data_in;
  else 
    data_out<=memo[address];
end
else data_out=0;
end
endmodule


module tb;
reg clk,en,wr;
reg [7:0] data_in;
reg [2:0] address;
wire [7:0] data_out;
always #1 clk=~clk;
ram r1(clk,en,wr,data_in,address,data_out);
initial begin
clk=1;
$monitor($time,"data_in=%d,address=%b,data_out=%d",data_in,address,data_out);
en=0;#1 en=1;
#2 wr=1; address=3'b111; data_in=8'd19;
#2 wr=0;
#2 wr=1; address=3'b110; data_in=8'd55;
#2 wr=0;
#2 wr=1; address=3'b101; data_in=8'd20;
end
initial begin 
#50 $finish;
end
endmodule 

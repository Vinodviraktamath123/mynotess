//testbench
`include "backdoor.v"
module tb;
parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WIDTH=$clog2(DEPTH);

reg clk,rst,valid,wr_rd;
reg [WIDTH-1:0]wdata;
reg [ADDR_WIDTH-1:0]addr;
wire [DEPTH-1:0]rdata;
wire ready;

backdoor  #(WIDTH,DEPTH,ADDR_WIDTH) dut(.*);

reg [8*30:1]testcase;

always #5 clk=~clk;
initial begin
    clk=0;
    rst=1;
    rst_logic();
   repeat (2)@(posedge clk);
   rst=0;
  $value$piusargs("testcase=%0s",testcase);

//load data into the registers
$readmemh("data_image.hex",dut.mem);
//read the data from the registers
$writememh("data_image1.hex",dut.mem);
$finish;
end

//write transaction
task rst_logic();
   begin
       wdata=0;
	   valid=0;
	   addr=0;
	   wr_rd=0;
	 end
 endtask
 endmodule




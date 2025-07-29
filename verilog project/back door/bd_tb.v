`include "bd.v"
module tb;
parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WIDTH=$clog2(DEPTH);
parameter STR_ADDR=15;
parameter NUM_TXS=6;

reg clk_i,rst_i,valid_i,wr_rd_i;
reg [ADDR_WIDTH-1:0]addr_i;
reg [WIDTH-1:0] wdata_i;
wire [WIDTH-1:0]rdata_o;
wire ready_o;

memory #(WIDTH,DEPTH,ADDR_WIDTH) dut(.*);

reg [8*30:1]testcase;
integer i;
integer fd;

always #5 clk_i=~clk_i;
initial begin
   clk_i=0;
   rst_i=0;
repeat(2)@(posedge clk_i);
   rst_logic();
   rst_i=0;

   $value$plusargs("testcase=%0s",testcase);
   $display("testcase=%0s",testcase);

   case(testcase)
   "WRITE_FD_READ_BD":begin
     write_logic(0,DEPTH);
	 $writememh("data_image.hex",dut.mem);
	 end

   "WRITE_BD_READ":begin
   $readmemh("data_image.hex",dut.mem);
   $writememh("data_image2.hex",dut.mem);
   end

   "WRITE_BD_READ_FD":begin
   $readmemh("data_image2.hex",dut.mem);
   read_logic(0,DEPTH);
   end
endcase
#200;
$finish;
end

task write_logic(input reg[ADDR_WIDTH-1:0]str_addr,input reg [ADDR_WIDTH:0]num_txs); 
integer i;
begin
for(i=str_addr;i<str_addr+num_txs;i=i+1) begin
     @(posedge clk_i);
    valid_i=1;
	wr_rd_i=1;
	addr_i=i ;
	wdata_i=$random;
	wait(ready_o==1);
	end
	@(posedge clk_i);
	rst_logic();
end
endtask	
task read_logic(input reg[ADDR_WIDTH-1:0]str_addr,input reg [ADDR_WIDTH:0]num_txs);
integer i;
begin
for(i=str_addr;i<=str_addr+num_txs;i=i+1) begin
    @(posedge clk_i);
    valid_i=1;
	wr_rd_i=0;
	addr_i=i ;
	wait(ready_o==1);
	end
	@(posedge clk_i);
	rst_logic();
end
endtask
task rst_logic();
begin
valid_i=0;
wr_rd_i=0;
addr_i=0;
wdata_i=0;
end
endtask
endmodule









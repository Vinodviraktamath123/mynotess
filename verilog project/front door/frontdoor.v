//front door memory
module memory(clk_i,rst_i,addr_i,wdata_i,rdata_o,wr_rd_i,valid_i,ready_o);

parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_SIZE=$clog2(DEPTH);

input clk_i,rst_i,valid_i,wr_rd_i;
input [ADDR_SIZE-1:0]addr_i;
input [WIDTH-1:0]wdata_i;
output reg ready_o;
output reg[WIDTH-1:0]rdata_o;
integer i;

//internal registers 
reg [WIDTH-1:0]mem[DEPTH-1:0];

//functionality
always @(posedge clk_i)begin
      if(rst_i==1)begin   //reset all reg variables should be made 0
	      rdata_o=0;
          ready_o=0;
          for(i=0;i<DEPTH;i=i+1)
               mem[i]=0;
          end


          else begin//rst=0
              if(valid_i==1)begin
                 ready_o=1;
                      if(wr_rd_i==1)begin
                       mem[addr_i]=wdata_i;
					   end
                      else begin
                       rdata_o=mem[addr_i];
                     end
					 end
			  
			  else begin
                 ready_o=0;
                end
			end
		end
     endmodule



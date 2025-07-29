//front door tb
`include "frontdoor.v"
module tb();
parameter WIDTH=16;
parameter DEPTH=64;
parameter ADDR_WIDTH=$clog2(DEPTH);

reg clk_i,rst_i,valid_i,wr_rd_i;
reg [ADDR_WIDTH-1:0]addr_i;
reg [WIDTH-1:0]wdata_i;
wire ready_o;
wire [WIDTH-1:0]rdata_o;
event e;
integer i;

reg [8*30:1]testcase;

//memory declare

memory #(WIDTH,DEPTH,ADDR_WIDTH) dut(.*);

initial begin
   clk_i=0;
  forever #5 clk_i=~clk_i;
 end
initial begin
        //clk_i=0;
        rst_i=1;
	    rst_logic();
	    repeat(2)@(posedge clk_i);
        rst_i=0;
	
	    $value$plusargs("testcase=%0s",testcase);
        $display("testcase=%0s",testcase);

case(testcase)
        
		"ONE_WRITE":begin
		write_logic(0,1);
		end

		"ONE_WRITE_ONE_READ":begin
		    write_logic(0,1);
			read_logic(0,1);
		end

		"WRITE_ALL_LOCATION":begin
		    write_logic(0,DEPTH);
		end

		"WRITE_READ_ALL_LOCATION":begin
		    write_logic(0,DEPTH);
			read_logic(0,DEPTH);
		end

		//"WRITE_READ_SPECIFIC_LOGIC":begin
		  //  write_logic(ST_ADDR ,NUM_TXS);
		//	read_logic(ST_ADDR ,NUM_TXS);
		//end

		"FIRST_HALF_OF_MEMORY":begin
		   write_logic(0,DEPTH/2);
		   read_logic(0,DEPTH/2);
		end
		
		"SECOND_HALF_OF_MEMORY":begin
		    write_logic(DEPTH/2,DEPTH);
			read_logic(DEPTH/2,DEPTH);
		end
		
		 "1ST_QUATAR_OR_MEMORY":begin
	        write_logic(0,DEPTH/4);
	        read_logic(0,DEPTH/4);
	    end

         "3RD_QUATAR_OF_MEMORY":begin
	         write_logic(0,DEPTH/4);
	         read_logic(0,DEPTH/4);
	    end

	      "2ND_QUATAR_OF_MEMORY": begin
	         write_logic(0,DEPTH/4);
             read_logic(0,DEPTH/4);
	     end

	    "3RD_QUATAR_OF_MEMORY":begin
	        write_logic(DEPTH/2,DEPTH/4);
		    read_logic(DEPTH/2,DEPTH/4);
		 end

       "4TH_QUATAR_OF_MEMORY":begin
     	    write_logic(( DEPTH/4)*3,DEPTH/4);
    	    read_logic((DEPTH/4)*3,DEPTH/4);
    	end

		"CONSECUTIVE_WR_RD":begin
           for(i=0;i<DEPTH;i=i+1)  begin
            write_logic(i,1);
            read_logic(i,1);
   	     end
       end
  endcase
 ->e;//triggering the event
 end

initial begin 
	@e;//waiting for event
#350;
$finish;
end

task rst_logic();
begin
      valid_i=0;
      wdata_i=0;
	  addr_i=0;
      wr_rd_i=0;
    end
 endtask

task write_logic(input[ADDR_WIDTH-1:0]start_loc,input[ADDR_WIDTH:0]num_loc);
integer j;
begin 
	for(i=start_loc;i<start_loc+num_loc;i=i+1)begin 
		@(posedge clk_i);
		addr_i=i;
		wdata_i = $random;
		wr_rd_i=1;
		valid_i=1;
		wait(ready_o==1);
	end
		@(posedge clk_i);
		rst_logic();
end
endtask

task read_logic(input[ADDR_WIDTH-1:0]start_loc,input[ADDR_WIDTH:0]num_loc);
begin
	for(i=start_loc;i<start_loc+num_loc;i=i+1)begin 
		@(posedge clk_i);
		addr_i=i;
		wr_rd_i=0;
		valid_i=1;
		wait(ready_o==1);
	end
		@(posedge clk_i);
		rst_logic();
end 
endtask
endmodule 


`include "ha_s.v"
module tb();
reg a,b;
wire s,c;
ha gt(a,b,s,c);
initial begin
repeat(10) begin
a = $random; b = $random;
#10;
$monitor("time=%t,a=%b,b=%b,s=%b,c=%b",$time,a,b,s,c);
end
end
endmodule


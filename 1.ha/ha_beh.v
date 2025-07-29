module ha_beh(a,b,s,c);
input a,b;
output s,c;
reg s,c;
always@(*)
begin
s=a^b;
c=a&b;
end
endmodule

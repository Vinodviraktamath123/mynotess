module ha(input a,b,output s,c);

assign s = a ^ b;
assign c = a & b;

endmodule

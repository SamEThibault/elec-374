`timescale 1ns/10ps
module reg_tb(input a, output b);
	
	reg[31:0] d;
	wire[31:0] q;
	reg enable;
	reg clr;
	reg clk;
	
	Register32 register(d, clk, clr, enable, q);
	
	initial
		begin
		
		clk = 0;
		d = 32'b1111;
		enable = 1;
		clr = 0;
		#20
		clk = 1;
		#20
		clk = 0;
		#20
		clr = 1;
		#20
		clk = 1;
		end
endmodule
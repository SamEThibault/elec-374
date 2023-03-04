`timescale 1ns/10ps
module reg_tb(input a, output b);
	
	reg[31:0] d;
	wire[31:0] q;
	reg enable;
	reg clr;
	reg clk;
	
	Register32 register(q, d, clk, clr, enable);
	
	initial
		begin
		
		clk = 0;
		enable = 1;
		clr = 0;
		d = 32'hFFFFFFFFF;

		//Delay for 20ns, set clk high to allow q <= d, q will store h'FFFFFFFFF
		#20 
		clk = 1; 

		//Delay for 20ns, set clk to low so q value wont change. d and q will store h'88888888, h'FFFFFFFF respectively
		#20 
		clk = 0;
		d = 32'h88888888;  

		//Delay for 20ns, clear q, q will store h'000000000
		#20 
		clr = 1; 

		//Delays for 20ns, turn off clear, set clk high so now q <= d, where q will store h'888888888
		#20 //Delay for 20ns
		clr = 0; //Turn off clear
		clk = 1; //q register should be set to h'88888888
		end
endmodule
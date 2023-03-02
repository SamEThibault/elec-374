`timescale 1ns/10ps
module reg_64_bit_tb(input a, output b);
	
	wire[63:0] q;
	reg[63:0] d;
	reg enable;
	reg clr;
	reg clk;
	
	reg_64_bit register(q, d, clk, clr, enable);
	
	initial
		begin
		
		clk = 0;
		enable = 1;
		clr = 0;
		d = 64'hFFFFFFFFFFFFFFFFFF;

		//Delay for 20ns, set clk high to allow q <= d, q will store h'FFFFFFFFF
		#20 
		clk = 1; 

		//Delay for 20ns, set clk to low so q value wont change. d and q will store h'88888888, h'FFFFFFFF respectively
		#20 
		clk = 0;
		d = 64'h8888888888888888;  

		//Delay for 20ns, clear q, q will store h'000000000
		#20 
		clr = 1; 

		//Delays for 20ns, turn off clear, set clk high so now q <= d, where q will store h'888888888
		#20 //Delay for 20ns
		clr = 0; //Turn off clear
		clk = 1; //q register should be set to h'88888888
		end
endmodule
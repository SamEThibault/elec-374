`timescale 1ns/10ps
module z_tb(input a, output b);
	
    wire[31:0] z_high_out;
    wire[31:0] z_low_out;
    reg[63:0] z_in;
    reg clr, clk, enable;

    z z_test(z_high_out, z_low_out, z_in, clk, clr, enable);

initial
		begin
            clk = 1;
            enable =1;
            clr=0;
            z_in = 64'h8888888888888888;
            #20;
            clk = 0;
            enable = 0;
            #20
            clk = 1;
            enable =1;
            z_in = 64'hFFFFFFFFFFFFFFFF;

		end
endmodule
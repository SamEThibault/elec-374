`timescale 1ns/10ps
module pc_tb(input a, output b);
	
    wire[31:0] pc_out;
    reg[31:0] inputPC;
    reg enable, clk, incPC;
    pc pc_test(pc_out, clk, incPC, enable, inputPC);
initial
		begin
            clk = 1;
            incPC = 1;
            inputPC = 32'h00000000;
            enable = 1;
            #20;
            clk = 0;
            #20
            clk = 1;
            incPC = 0;
            inputPC = 32'hFFFFFFFF;

		end
endmodule
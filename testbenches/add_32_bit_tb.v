`timescale 1ns/10ps
module add_32_bit_tb(input a, output b);
	
    wire [31:0] c_out;
    wire [31:0] s_out;
    reg [31:0] x_in;
    reg [31:0] y_in;
    reg c_in;

    add_32_bit add_32_bit_test(c_out, s_out, x_in, y_in, c_in);

initial
		begin

            //Should simulate the truth table for half adder
            c_in = 1'b0;
            x_in = 32'hFFFF0000;
            y_in = 32'h0000FFFF;
            #20
            x_in = 32'hF0F0F0F0;
            y_in = 32'h000F0000;

		end
endmodule
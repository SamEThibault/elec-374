`timescale 1ns/10ps
module negate_32_bit_tb(input a, output b);
	
    wire[31:0] result_hi;
    wire[31:0] result_lo;
    wire[31:0] multiplicand;
    wire[31:0] multiplier;

    mul mul_test(res_hi, res_lo, multiplicand, multiplier);

	initial
		begin
            // should be 0000 0000
            multiplicand = 32'h00000001;
            multiplier = 32'h00000000;
            #20
            // should be 1111 1111
            multiplicand = 32'h00000001;
            multiplier = 32'h11111111;
            #20
            // should be 2000 0000
            multiplicand = 32'h00000002;
            multiplier = 32'h10000000;

		end
endmodule
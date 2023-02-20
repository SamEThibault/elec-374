`timescale 1ns/10ps
module div_32_bit_tb(input a, output b);
	
    wire[31:0] quotient;
    wire[31:0] remainder;
    reg[31:0] dividend;
    reg[31:0] divisor;

    div_32_bit div_test(quotient, remainder, dividend, divisor);

	initial
		begin

            dividend = 32'd10;
            divisor = 32'd5;
            #20
            dividend = 32'd37;
            divisor = 32'd3;
            #20
            dividend = 32'b10101;
            divisor =  32'b000101;

		end
endmodule
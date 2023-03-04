`timescale 1ns/10ps
module half_adder_tb(input a, output b);
	
    wire c_out;
    wire s_out;
    reg x_in;
    reg y_in;

    half_adder half_adder_test(c_out, s_out, x_in, y_in);

	initial
		begin

            //Should simulate the truth table for half adder
            x_in = 1'b0;
            y_in = 1'b0;
            #20
            
            x_in = 1'b0;
            y_in = 1'b1;
            #20

            x_in = 1'b1;
            y_in = 1'b0;
            #20

            x_in = 1'b1;
            y_in = 1'b1;
            

		end
endmodule
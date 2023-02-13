`timescale 1ns/10ps
module full_adder_tb(input a, output b);
	
    wire c_out;
    wire s_out;
    reg c_in;
    reg x_in;
    reg y_in;


    full_adder full_adder_gate( c_out, s_out, c_in, x_in, y_in);

	initial
		begin

            //Should simulate the truth table for half adder
            c_in = 1'b0;
            x_in = 1'b0;
            y_in = 1'b0;
            #20
            
            c_in = 1'b0;
            x_in = 1'b0;
            y_in = 1'b1;
            #20

            c_in = 1'b0;
            x_in = 1'b1;
            y_in = 1'b0;
            #20

            c_in = 1'b0;
            x_in = 1'b1;
            y_in = 1'b1;

            #20

            c_in = 1'b1;
            x_in = 1'b0;
            y_in = 1'b0;
            #20
            
            c_in = 1'b1;
            x_in = 1'b0;
            y_in = 1'b1;
            #20

            c_in = 1'b1;
            x_in = 1'b1;
            y_in = 1'b0;
            #20

            c_in = 1'b1;
            x_in = 1'b1;
            y_in = 1'b1;
            

		end
endmodule
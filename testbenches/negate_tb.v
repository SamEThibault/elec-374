`timescale 1ns/10ps
module half_adder_tb(input a, output b);
	
    wire[31:0] Rz;
    reg[31:0] Ra;

    negate negate_gate(Rz, Ra);

	initial
		begin

            //Negate Ra to be 32'h10000000
            Ra = 32'h00000000;
            #20
            //Negate Ra to be 32'h11111111
            Ra = 32'h00000001;
            #20
            //Negate Ra to be 11111000
            Ra = 32'h00001000;

		end
endmodule
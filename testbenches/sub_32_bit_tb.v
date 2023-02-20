`timescale 1ns/10ps
module sub_32_bit_tb(input a, output b);
	
    wire[31:0] Rz;
    reg [31:0] Ra;
    reg [31:0] Rb;

    sub_32_bit subTest(Rz, Ra, Rb);

	initial
		begin

            //Negate RZ to be 32'hFFFFFFFF
            Ra = 32'hFFFFFFFF;
            Rb = 32'h00000000;
            #20
            //Negate RZ to be 32'h00000000
            Ra = 32'hFFFFFFFF;
            Rb = 32'hFFFFFFFF;
            #20
            //Negate RZ to be F0F0F0F0
            Ra = 32'hFFFFFFFF;
            Rb = 32'h0F0F0F0F;

		end
endmodule
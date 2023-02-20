`timescale 1ns/10ps
module shra_32_bit_tb(input a, output b);
	
    wire signed[31:0] Rz;
    reg signed[31:0] Ra;
    

    shra_32_bit shraTest(Rz, Ra, 32'b1);

	initial
		begin
            
            //Negate RZ to be 32'hFFFFFFFF
            Ra = 32'hFFFFFFFF;
            #20
            //Negate RZ to be 32'hFFFFFFF8
            Ra = 32'hFFFFFFF0;
            #20
            //Negate RZ to be 32'h00000078
            Ra = 32'h000000F0;

		end
endmodule
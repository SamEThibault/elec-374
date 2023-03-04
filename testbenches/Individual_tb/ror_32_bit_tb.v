`timescale 1ns/10ps
module ror_32_bit_tb(input a, output b);
	
    wire[31:0] Rz;
    reg [31:0] Ra;
    

    ror_32_bit rorTest(Rz, Ra, 32'b10);

	initial
		begin
            
            //Negate RZ to be 32'h4FFFFFFC
            Ra = 32'hFFFFFFF1;
            #20
            //Negate RZ to be 32'C00000000
            Ra = 32'h00000002;
		end
endmodule
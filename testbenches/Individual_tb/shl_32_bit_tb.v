`timescale 1ns/10ps
module shl_32_bit_tb(input a, output b);
	
    wire[31:0] Rz;
    reg [31:0] Ra;
    

    shl_32_bit shlTest(Rz, Ra, 32'b1);

	initial
		begin
            
            //Negate RZ to be 32'hFFFFFFF7
            Ra = 32'hFFFFFFFF;
            #20
            //Negate RZ to be 32'00000017
            Ra = 32'h0000000F;
            #20
            //Negate RZ to be 32'h00020000
            Ra = 32'h00010000;

		end
endmodule
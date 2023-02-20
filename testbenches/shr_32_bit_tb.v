`timescale 1ns/10ps
module shr_32_bit_tb(input a, output b);
	
    wire[31:0] Rz;
    reg [31:0] Ra;
    

    shr_32_bit shrTest(Rz, Ra, 32'b1);

	initial
		begin
            
            //Negate RZ to be 32'h0FFFFFFF
            Ra = 32'hFFFFFFFF;
            #20
            //Negate RZ to be 32'h0F0F0F0F
            Ra = 32'hF0F0F0F0;
            #20
            //Negate RZ to be F0F0F0F0
            Ra = 32'hF0000001;

		end
endmodule
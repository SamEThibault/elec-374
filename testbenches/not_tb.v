`timescale 1ns/10ps
module not_tb(input a, output b);
	
    reg[31:0] Ra;
    wire[31:0] RZ;

    not_32_bit notTest(Ra, Rb, RZ);

	initial
		begin
            Ra = 32'hFFFFFFFF;
            // here rz should be 32'h00000000
            #20 //Delay for 20ns
            Ra = 32'h00000000;
            // here rz should be 32'hFFFFFFFF
		end
endmodule
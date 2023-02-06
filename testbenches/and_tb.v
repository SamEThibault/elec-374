`timescale 1ns/10ps
module and_tb(input a, output b);
	
    reg[31:0] Ra;
    reg[31:0] Rb;
    wire[31:0] RZ;

    and_32_bit And(Ra, Rb, RZ);

	initial
		begin
            Ra = 32'hFFFFFFFF;
            Rb = 32'h00000000;
            // here rz should be 0
            #20
            Ra = 32'hFFFFFFFF;
            Rb = 32'hFFFFFFFF;
            // here rz should be 1
            #20
            Ra = 32'h00000000;
            Rb = 32'h00000000;
            // here rz should be 0
		end
endmodule
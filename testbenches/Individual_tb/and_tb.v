`timescale 1ns/10ps
module and_tb(input a, output b);
	
    wire[31:0] Rz;
    reg[31:0] Ra;
    reg[31:0] Rb;

    and_32_bit andGate(Rz, Ra, Rb);

	initial
		begin
            Ra = 32'hFFFFFFFF;
            Rb = 32'h00000000;
            // here rz should be 0
            #20 //Delay for 20ns
            Ra = 32'hFFFFFFFF;
            Rb = 32'hFFFFFFFF;
            // here rz should be 1
            #20 //Delay for 20ns
            Ra = 32'h00000000;
            Rb = 32'h00000000;
            // here rz should be 0
		end
endmodule